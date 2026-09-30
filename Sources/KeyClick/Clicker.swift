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
    // ponytail: every bundled pack is 48 kHz mono; user-supplied packs would need converting to this.
    private static let format = AVAudioFormat(standardFormatWithSampleRate: 48_000, channels: 1)!
    private static let modifierFlags: [Int64: CGEventFlags] = [
        54: .maskCommand, 55: .maskCommand, 56: .maskShift, 60: .maskShift,
        58: .maskAlternate, 61: .maskAlternate, 59: .maskControl, 62: .maskControl, 63: .maskSecondaryFn,
    ]
    private static let capsLock: Int64 = 57

    private let engine = AVAudioEngine()
    private let players = (0..<8).map { _ in AVAudioPlayerNode() }
    private var nextPlayer = 0
    private var sounds: [String: [AVAudioPCMBuffer]] = [:]
    private var tap: CFMachPort?
    private var retry: Timer?

    init() {
        packs = ((try? FileManager.default.contentsOfDirectory(atPath: Self.soundsURL.path)) ?? []).sorted()
        let saved = UserDefaults.standard.string(forKey: "pack") ?? "Cream"
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
        let root = Self.soundsURL.appendingPathComponent(pack)
        for action in ["press", "release"] {
            for group in ["default", "space", "enter", "backspace"] {
                let dir = root.appendingPathComponent("\(action)/\(group)")
                let files = (try? FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)) ?? []
                sounds["\(action)/\(group)"] = files.compactMap(Self.buffer)
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
        guard enabled, engine.isRunning else { return }
        let group = switch keyCode {
        case 49: "space"
        case 36, 76: "enter"
        case 51, 117: "backspace"
        default: "default"
        }
        guard let buffer = sounds["\(action)/\(group)"]?.randomElement() ?? sounds["\(action)/default"]?.randomElement() else { return }
        let player = players[nextPlayer]
        nextPlayer = (nextPlayer + 1) % players.count
        player.volume = .random(in: 0.8...1)
        player.scheduleBuffer(buffer, at: nil, options: .interrupts)
        player.play()
    }
}
