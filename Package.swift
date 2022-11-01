// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WindowSceneReader",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "WindowSceneReader",
            targets: ["WindowSceneReader"]
        ),
    ],
    targets: [
        .target(name: "WindowSceneReader")
    ]
)
