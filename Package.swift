// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Pancake",
  platforms: [
    .iOS(.v10),
    .macOS(.v10_11),
  ],
  products: [
    .library(
      name: "Pancake",
      targets: ["PancakeCore", "PancakeUI"]
    ),
    .library(name: "PancakeCore", targets: ["PancakeCore"]),
    .library(name: "PancakeUI", targets: ["PancakeUI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/roberthein/TinyConstraints", from: "4.0.0"),
  ],
  targets: [
    .target(name: "PancakeCore"),
    .testTarget(name: "PancakeCoreTests", dependencies: ["PancakeCore"]),
    .target(name: "PancakeUI", dependencies: [
      .target(name: "PancakeCore"),
      "TinyConstraints",
    ]),
  ],
  swiftLanguageVersions: [.v5]
)
