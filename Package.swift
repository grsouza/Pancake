// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Pancake",
  platforms: [
    .iOS(.v10),
  ],
  products: [
    .library(
      name: "Pancake",
      targets: ["Pancake", "PancakeCore"]
    ),
    .library(name: "PancakeUI", targets: ["PancakeUI"]),
    .library(name: "PancakeHTTP", targets: ["PancakeCore", "PancakeHTTP"]),
  ],
  dependencies: [
    .package(url: "https://github.com/roberthein/TinyConstraints", from: "4.0.0")
  ],
  targets: [
    .target(
      name: "Pancake",
      dependencies: [
        .target(name: "PancakeCore"),
      ]
    ),
    .testTarget(
      name: "PancakeTests",
      dependencies: ["Pancake"]
    ),
    .target(name: "PancakeCore"),
    .testTarget(name: "PancakeCoreTests", dependencies: ["PancakeCore"]),
    .target(name: "PancakeUI", dependencies: [
              "PancakeCore",
              "TinyConstraints"]),
    .target(name: "PancakeHTTP"),
    .testTarget(name: "PancakeHTTPTests", dependencies: ["PancakeHTTP"]),
  ],
  swiftLanguageVersions: [.v5]
)
