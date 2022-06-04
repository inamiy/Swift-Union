// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Union",
    products: [
        .library(
            name: "Union",
            targets: ["Union"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Union",
            dependencies: []),
        .testTarget(
            name: "UnionTests",
            dependencies: ["Union"]),
    ]
)
