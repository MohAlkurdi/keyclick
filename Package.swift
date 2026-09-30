// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "KeyClick",
    platforms: [.macOS(.v13)],
    dependencies: [.package(url: "https://github.com/sparkle-project/Sparkle", from: "2.10.0")],
    targets: [
        .executableTarget(
            name: "KeyClick",
            dependencies: [.product(name: "Sparkle", package: "Sparkle")],
            linkerSettings: [.unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "@executable_path/../Frameworks"])]
        ),
    ]
)
