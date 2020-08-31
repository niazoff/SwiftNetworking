// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "SwiftNetworking",
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
