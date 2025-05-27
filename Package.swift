// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "Keyboard",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Keyboard",
            targets: ["Keyboard"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/KeyboardKit.git", from: "7.0.0")
    ],
    targets: [
        .target(
            name: "Keyboard",
            dependencies: ["KeyboardKit"],
            path: "Keyboard"),
        .testTarget(
            name: "KeyboardTests",
            dependencies: ["Keyboard"],
            path: "KeyboardTests"),
    ]
) 