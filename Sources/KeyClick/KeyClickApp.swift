import AppKit
import ServiceManagement
import Sparkle
import SwiftUI

@main
struct KeyClickApp: App {
    @StateObject private var clicker = Clicker()
    private let updater = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: nil)

    var body: some Scene {
        MenuBarExtra("KeyClick", systemImage: clicker.enabled ? "keyboard.fill" : "keyboard") {
            VStack(alignment: .leading, spacing: 12) {
                Toggle(isOn: $clicker.enabled) {
                    HStack {
                        Text("Sound")
                        Text("⌃⌥K").foregroundStyle(.secondary)
                    }
                }
                if !clicker.hasPermission {
                    Text("KeyClick needs Input Monitoring to hear your keys.")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    Button("Open Settings…") {
                        NSWorkspace.shared.open(URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ListenEvent")!)
                    }
                }
                Slider(value: $clicker.volume, in: 0...1) { Text("Volume") }
                Picker("Switch", selection: $clicker.pack) {
                    ForEach(clicker.packs, id: \.self) { Text($0) }
                }
                Toggle("Open at login", isOn: Binding(
                    get: { SMAppService.mainApp.status == .enabled },
                    set: { on in
                        if on { try? SMAppService.mainApp.register() } else { try? SMAppService.mainApp.unregister() }
                    }
                ))
                Divider()
                Button("Check for Updates…") { updater.checkForUpdates(nil) }
                Button("Quit KeyClick") { NSApp.terminate(nil) }
            }
            .toggleStyle(.switch)
            .padding()
            .frame(width: 260)
        }
        .menuBarExtraStyle(.window)
    }
}
