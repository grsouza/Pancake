// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pancake",
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
