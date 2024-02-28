// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WindowSceneReader",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "WindowSceneReader",
            targets: ["WindowSceneReader"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/divadretlaw/WindowReader", from: "2.0.0")
    ],
    targets: [
        .target(name: "WindowSceneReader", dependencies: ["WindowReader"])
    ]
)
