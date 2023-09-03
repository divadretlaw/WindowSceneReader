// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WindowSceneReader",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "WindowSceneReader",
            targets: ["WindowSceneReader"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/divadretlaw/WindowReader", from: "1.1.0")
    ],
    targets: [
        .target(name: "WindowSceneReader", dependencies: ["WindowReader"])
    ]
)
