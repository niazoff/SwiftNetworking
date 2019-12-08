// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "SwiftNetworking",
  platforms: [
    .iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6),
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
