// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Exts",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(name: "Exts", targets: ["Exts"]),
        .library(name: "MVVM", targets: ["MVVM"]),
        .library(name: "Bases", targets: ["Bases"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.2.0"),
        .package(url: "https://github.com/SnapKit/SnapKit", from: "5.0.1"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.5.0"),
        .package(url: "https://github.com/devxoul/Then", from: "2.7.0"),
        
    ],
    targets: [
        // targets
        .target(name: "Exts", dependencies: ["RxSwift", "SnapKit", "Alamofire"]),
        .target(name: "MVVM", dependencies: ["RxSwift", "SnapKit", "Alamofire"]),
        .target(name: "Bases", dependencies: ["RxSwift", "SnapKit", "Alamofire"]),
        .target(name: "ModalMoveable", dependencies: ["RxSwift", "SnapKit", "Alamofire", "Then"]),
        // tests
        .testTarget(name: "ExtsTests", dependencies: ["Exts", "MVVM"]),
    ],
    swiftLanguageVersions: [.v5]
)
