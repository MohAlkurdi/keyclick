import AVFoundation
import CoreGraphics

/// Listens to key presses (never their characters) and plays a switch sound for each.
@MainActor
final class Clicker: ObservableObject {
    @Published var enabled = UserDefaults.standard.object(forKey: "enabled") as? Bool ?? true {
        didSet { UserDefaults.standard.set(enabled, forKey: "enabled") }
    }
    @Published var volume = UserDefaults.standard.object(forKey: "volume") as? Float ?? 0.7 {
        didSet {
            UserDefaults.standard.set(volume, forKey: "volume")
            engine.mainMixerNode.outputVolume = volume
        }
    }
    @Published var pack: String {
        didSet {
            UserDefaults.standard.set(pack, forKey: "pack")
            load()
        }
    }
    @Published private(set) var hasPermission = false
    let packs: [String]

    private static let soundsURL = Bundle.main.resourceURL!.appendingPathComponent("Sounds")
    // ponytail: every bundled pack is 48 kHz stereo; user-supplied packs would need converting to this.
    private static let format = AVAudioFormat(standardFormatWithSampleRate: 48_000, channels: 2)!
    private static let modifierFlags: [Int64: CGEventFlags] = [
        54: .maskCommand, 55: .maskCommand, 56: .maskShift, 60: .maskShift,
        58: .maskAlternate, 61: .maskAlternate, 59: .maskControl, 62: .maskControl, 63: .maskSecondaryFn,
    ]
    private static let capsLock: Int64 = 57
    /// macOS virtual key code → KeyboardEvent.code, the file names in each pack.
    private static let keyNames: [Int64: String] = [
        0: "KeyA", 1: "KeyS", 2: "KeyD", 3: "KeyF", 4: "KeyH", 5: "KeyG", 6: "KeyZ", 7: "KeyX", 8: "KeyC", 9: "KeyV",
        11: "KeyB", 12: "KeyQ", 13: "KeyW", 14: "KeyE", 15: "KeyR", 16: "KeyY", 17: "KeyT", 18: "Digit1", 19: "Digit2",
        20: "Digit3", 21: "Digit4", 22: "Digit6", 23: "Digit5", 24: "Equal", 25: "Digit9", 26: "Digit7", 27: "Minus",
        28: "Digit8", 29: "Digit0", 30: "BracketRight", 31: "KeyO", 32: "KeyU", 33: "BracketLeft", 34: "KeyI", 35: "KeyP",
        36: "Enter", 37: "KeyL", 38: "KeyJ", 39: "Quote", 40: "KeyK", 41: "Semicolon", 42: "Backslash", 43: "Comma",
        44: "Slash", 45: "KeyN", 46: "KeyM", 47: "Period", 48: "Tab", 49: "Space", 50: "Backquote", 51: "Backspace",
        53: "Escape", 54: "MetaRight", 55: "MetaLeft", 56: "ShiftLeft", 57: "CapsLock", 58: "AltLeft", 59: "ControlLeft",
        60: "ShiftRight", 61: "AltRight", 62: "ControlRight", 76: "Enter", 96: "F5", 97: "F6", 98: "F7", 99: "F3",
        100: "F8", 101: "F9", 103: "F11", 109: "F10", 111: "F12", 115: "Home", 116: "PageUp", 117: "Delete", 118: "F4",
        119: "End", 120: "F2", 121: "PageDown", 122: "F1", 123: "ArrowLeft", 124: "ArrowRight", 125: "ArrowDown", 126: "ArrowUp",
    ]

    private let engine = AVAudioEngine()
    private let players = (0..<8).map { _ in AVAudioPlayerNode() }
    private var nextPlayer = 0
    private var sounds: [String: [String: AVAudioPCMBuffer]] = [:]
    private var tap: CFMachPort?
    private var retry: Timer?

    init() {
        packs = ((try? FileManager.default.contentsOfDirectory(atPath: Self.soundsURL.path)) ?? []).sorted()
        let saved = UserDefaults.standard.string(forKey: "pack") ?? "MX Brown"
        pack = packs.contains(saved) ? saved : packs.first ?? ""
        load()

        for player in players {
            engine.attach(player)
            engine.connect(player, to: engine.mainMixerNode, format: Self.format)
        }
        engine.mainMixerNode.outputVolume = volume
        try? engine.start()
        // Plugging in headphones or switching output stops the engine.
        NotificationCenter.default.addObserver(forName: .AVAudioEngineConfigurationChange, object: engine, queue: .main) { [weak self] _ in
            MainActor.assumeIsolated { try? self?.engine.start() }
        }

        if !startTap() {
            CGRequestListenEventAccess()
            retry = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { [weak self] _ in
                MainActor.assumeIsolated { _ = self?.startTap() }
            }
        }
    }

    private func load() {
        sounds = [:]
        for action in ["press", "release"] {
            let dir = Self.soundsURL.appendingPathComponent("\(pack)/\(action)")
            let files = (try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)) ?? []
            for file in files {
                sounds[action, default: [:]][file.deletingPathExtension().lastPathComponent] = Self.buffer(file)
            }
        }
    }

    private static func buffer(_ url: URL) -> AVAudioPCMBuffer? {
        guard let file = try? AVAudioFile(forReading: url),
              let buffer = AVAudioPCMBuffer(pcmFormat: file.processingFormat, frameCapacity: AVAudioFrameCount(file.length)),
              (try? file.read(into: buffer)) != nil
        else { return nil }
        return buffer
    }

    private func startTap() -> Bool {
        let mask = (1 << CGEventType.keyDown.rawValue) | (1 << CGEventType.keyUp.rawValue) | (1 << CGEventType.flagsChanged.rawValue)
        tap = CGEvent.tapCreate(
            tap: .cgSessionEventTap,
            place: .headInsertEventTap,
            options: .listenOnly,
            eventsOfInterest: CGEventMask(mask),
            callback: { _, type, event, refcon in
                let clicker = Unmanaged<Clicker>.fromOpaque(refcon!).takeUnretainedValue()
                let keyCode = event.getIntegerValueField(.keyboardEventKeycode)
                let isRepeat = event.getIntegerValueField(.keyboardEventAutorepeat) != 0
                let flags = event.flags
                MainActor.assumeIsolated { clicker.handle(type, keyCode: keyCode, flags: flags, isRepeat: isRepeat) }
                return Unmanaged.passUnretained(event)
            },
            userInfo: Unmanaged.passUnretained(self).toOpaque()
        )
        guard let tap else { return false }
        CFRunLoopAddSource(CFRunLoopGetMain(), CFMachPortCreateRunLoopSource(nil, tap, 0), .commonModes)
        hasPermission = true
        retry?.invalidate()
        return true
    }

    private func handle(_ type: CGEventType, keyCode: Int64, flags: CGEventFlags, isRepeat: Bool) {
        switch type {
        case .tapDisabledByTimeout, .tapDisabledByUserInput:
            if let tap { CGEvent.tapEnable(tap: tap, enable: true) }
        case .keyDown where !isRepeat:
            play("press", keyCode)
        case .keyUp:
            play("release", keyCode)
        case .flagsChanged where keyCode == Self.capsLock:
            play("press", keyCode)
        case .flagsChanged:
            guard let flag = Self.modifierFlags[keyCode] else { return }
            play(flags.contains(flag) ? "press" : "release", keyCode)
        default:
            break
        }
    }

    private func play(_ action: String, _ keyCode: Int64) {
        guard enabled, engine.isRunning, let recorded = sounds[action] else { return }
        // Keys a pack did not record (Fn, F13…) borrow a random letter.
        guard let buffer = Self.keyNames[keyCode].flatMap({ recorded[$0] })
            ?? recorded.filter({ $0.key.hasPrefix("Key") }).randomElement()?.value
        else { return }
        let player = players[nextPlayer]
        nextPlayer = (nextPlayer + 1) % players.count
        player.volume = .random(in: 0.85...1)
        player.scheduleBuffer(buffer, at: nil, options: .interrupts)
        player.play()
    }
}
