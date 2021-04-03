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
      targets: ["PancakeCore", "PancakeKeychain", "PancakeLogging"]
    ),
    .library(name: "PancakeCore", targets: ["PancakeCore"]),
    .library(name: "PancakeKeychain", targets: ["PancakeKeychain"]),
    .library(name: "PancakeLogging", targets: ["PancakeLogging"]),

    .library(name: "Box", targets: ["Box"]),
    .library(name: "Lazy", targets: ["Lazy"]),
    .library(name: "Weak", targets: ["Weak"]),
  ],
  dependencies: [
    .package(
      name: "SnapshotTesting",
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.8.1"
    ),
  ],
  targets: [
    // Box
    .target(name: "Box"),
    .testTarget(name: "BoxTests", dependencies: ["Box"]),
    // Lazy
    .target(name: "Lazy", dependencies: ["Lock"]),
    .target(name: "PancakeCore", dependencies: []),
    .testTarget(name: "PancakeCoreTests", dependencies: ["PancakeCore", "SnapshotTesting"]),
    .target(name: "PancakeKeychain", dependencies: ["PancakeCore"]),
    .target(name: "PancakeLogging", dependencies: ["PancakeCore"]),
    .testTarget(name: "PancakeLoggingTests", dependencies: ["PancakeLogging"]),
    // Weak
    .target(name: "Weak"),
    .testTarget(name: "WeakTests", dependencies: ["Weak"]),
  ],
  swiftLanguageVersions: [.v5]
)
