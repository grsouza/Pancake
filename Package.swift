// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pancake",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(
            name: "Pancake",
            targets: ["Pancake", "PancakeCore"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Pancake",
            dependencies: [
            .target(name: "PancakeCore")
        ]),
        .testTarget(
            name: "PancakeTests",
            dependencies: ["Pancake"]
        ),
        .target(name: "PancakeCore")
    ],
    swiftLanguageVersions: [.v5]
)
