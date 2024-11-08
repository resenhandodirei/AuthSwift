// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "AuthApp",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        // 🗄 An ORM for SQL and NoSQL databases.
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        // 🐘 Fluent driver for Postgres.
        .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
        // 🍃 Templating language for Vapor.
        .package(url: "https://github.com/vapor/leaf.git", from: "4.0.0"),
        // 🔵 Networking framework for Swift.
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Fluent", package: "fluent"),
                .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver"),
                .product(name: "Leaf", package: "leaf"),
                .product(name: "Vapor", package: "vapor"),
                .product(name: "NIOCore", package: "swift-nio"),
                .product(name: "NIOPosix", package: "swift-nio"),
            ]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .target(name: "App"),
                .product(name: "XCTVapor", package: "vapor"),
            ]
        )
    ]
)

