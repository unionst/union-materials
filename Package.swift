// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "union-materials",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "UnionMaterials",
            targets: ["UnionMaterials"]
        ),
    ],
    targets: [
        .target(
            name: "UnionMaterials",
            path: "Sources/UnionMaterials"
        ),
    ]
)
