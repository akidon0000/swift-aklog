// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AKLog",
    products: [
        .library(
            name: "AKLog",
            targets: ["AKLog"]),
    ],
    targets: [
        .target(
            name: "AKLog"),
        .testTarget(
            name: "AKLogTests",
            dependencies: ["AKLog"]),
    ]
)
