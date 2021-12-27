// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Exts",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "Exts",
            targets: ["Exts"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            from: "6.2.0"),
        .package(
            url: "https://github.com/SnapKit/SnapKit",
            from: "5.0.1"),
    ],
    targets: [
        .target(
            name: "Exts",
            dependencies: ["RxSwift", "SnapKit"]),
        .testTarget(
            name: "ExtsTests",
            dependencies: ["Exts"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
