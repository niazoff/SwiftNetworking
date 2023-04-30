// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "SwiftNetworking",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v6)
  ],
  products: [
    .library(
      name: "SwiftNetworking",
      targets: ["SwiftNetworking"]),
  ],
  targets: [
    .target(
      name: "SwiftNetworking"),
    .testTarget(
      name: "SwiftNetworkingTests",
      dependencies: ["SwiftNetworking"]),
  ]
)
