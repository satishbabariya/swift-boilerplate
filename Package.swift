// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-boilerplate",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "swift-boilerplate",
            targets: ["core"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .exact("5.0.0")),
    ],
    targets: [
        .target(
            name: "core",
            dependencies: ["RxSwift"]
        ),
    ]
)
