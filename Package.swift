// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Pancake",
  platforms: [
    .iOS(.v11),
    .macOS(.v10_12),
  ],
  products: [
    .library(
      name: "Pancake",
      targets: ["PancakeCore"]
    ),
    .library(name: "PancakeCore", targets: ["PancakeCore"]),

    .library(name: "Box", targets: ["Box"]),
    .library(name: "Cache", targets: ["Cache"]),
    .library(name: "Keychain", targets: ["Keychain"]),
    .library(name: "Lazy", targets: ["Lazy"]),
    .library(name: "Lock", targets: ["Lock"]),
    .library(name: "Logger", targets: ["Logger"]),
    .library(name: "Storage", targets: ["Storage"]),
    .library(name: "ThreadSafe", targets: ["ThreadSafe"]),
    .library(name: "UIKitExt", targets: ["UIKitExt"]),
    .library(name: "Weak", targets: ["Weak"]),
  ],
  dependencies: [
    .package(
      name: "SnapshotTesting",
      url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
      from: "1.8.1"
    )
  ],
  targets: [
    // Box
    .target(name: "Box"),
    .testTarget(name: "BoxTests", dependencies: ["Box"]),

    // Cache
    .target(name: "Cache"),

    // Keychain
    .target(name: "Keychain", dependencies: ["PancakeCore"]),

    // Lazy
    .target(name: "Lazy", dependencies: ["Lock"]),

    // Lock
    .target(name: "Lock"),
    .testTarget(name: "LockTests", dependencies: ["Lock"]),

    // Logger
    .target(name: "Logger"),

    .target(name: "PancakeCore", dependencies: []),
    .testTarget(name: "PancakeCoreTests", dependencies: ["PancakeCore", "SnapshotTesting"]),

    // Storage
    .target(name: "Storage", dependencies: ["ThreadSafe"]),
    .testTarget(name: "StorageTests", dependencies: ["Storage"]),

    // ThreadSafe
    .target(name: "ThreadSafe", dependencies: ["Lock"]),

    // UIKitExt
    .target(name: "UIKitExt"),

    // Weak
    .target(name: "Weak"),
    .testTarget(name: "WeakTests", dependencies: ["Weak"]),
  ],
  swiftLanguageVersions: [.v5]
)
