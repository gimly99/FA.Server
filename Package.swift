// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "serv3",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Server",
            targets: ["Server"]),
        
        .executable(
            name: "Run",
            targets: ["Run"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: Version(3, 0, 0)),
        .package(url: "https://github.com/vapor/routing.git", from: Version(3, 0, 0)),

        // Auth
        .package(url: "https://github.com/vapor/leaf.git", from: Version(3, 0, 0)),
        .package(url: "https://github.com/vapor/auth.git", from: Version(2, 0, 0)),
        .package(url: "https://github.com/vapor/crypto.git", from: Version(3, 0, 0)),

        // Database
        .package(url: "https://github.com/vapor/fluent-mysql-driver", from: Version(3, 0, 0)),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Server",
            dependencies: ["Routing", "Vapor", "Authentication", "FluentMySQL", "Crypto", "Leaf"]),
        .target(
            name: "Run",
            dependencies: ["Server"])
    ]
)
