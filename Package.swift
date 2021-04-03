// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Pancake",
  platforms: [
    .iOS(.v11),
    .macOS(.v10_11),
  ],
  products: [
    .library(
      name: "Pancake",
      targets: ["PancakeCore", "PancakeUI", "PancakeKeychain", "PancakeLogging"]
    ),
    .library(name: "PancakeCore", targets: ["PancakeCore"]),
    .library(name: "PancakeUI", targets: ["PancakeUI"]),
    .library(name: "PancakeKeychain", targets: ["PancakeKeychain"]),
    .library(name: "PancakeLogging", targets: ["PancakeLogging"]),
  ],
  dependencies: [
    .package(url: "https://github.com/roberthein/TinyConstraints", from: "4.0.0"),
    .package(
      name: "SnapshotTesting",
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.8.1"
    ),
  ],
  targets: [
    .target(name: "PancakeCore", dependencies: []),
    .testTarget(name: "PancakeCoreTests", dependencies: ["PancakeCore", "SnapshotTesting"]),
    .target(name: "PancakeKeychain", dependencies: ["PancakeCore"]),
    .target(
      name: "PancakeUI",
      dependencies: [
        .target(name: "PancakeCore"),
        "TinyConstraints",
      ]),
    .testTarget(name: "PancakeUITests", dependencies: ["PancakeUI", "SnapshotTesting"]),
    .target(name: "PancakeLogging", dependencies: ["PancakeCore"]),
    .testTarget(name: "PancakeLoggingTests", dependencies: ["PancakeLogging"]),
  ],
  swiftLanguageVersions: [.v5]
)
