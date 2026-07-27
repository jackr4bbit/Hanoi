// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Hanoi",
    products: [
        .library(name: "HanoiCore", targets: ["HanoiCore"]),
        .executable(name: "hanoi", targets: ["HanoiCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.4.0")
    ],
    targets: [
        .target(name: "HanoiCore"),
        .executableTarget(
            name: "HanoiCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "HanoiCore"
            ]
        ),
        .testTarget(name: "HanoiCoreTests", dependencies: ["HanoiCore"])
    ]
)
