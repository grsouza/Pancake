// swift-tools-version:5.3
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
        .library(name: "PancakeCoreData", targets: ["PancakeCoreData"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Pancake",
            dependencies: [
                .target(name: "PancakeCore")
            ]
        ),
        .testTarget(
            name: "PancakeTests",
            dependencies: ["Pancake"]
        ),
        .target(name: "PancakeCore"),
        .testTarget(name: "PancakeCoreTests", dependencies: ["PancakeCore"]),
        .target(name: "PancakeCoreData"),
//        .testTarget(
//            name: "PancakeCoreDataTests",
//            dependencies: ["PancakeCoreData"],
//            resources: [
//                .process("Support Files")
//            ]
//        )
    ],
    swiftLanguageVersions: [.v5]
)
