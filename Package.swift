// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "vercel-vapor",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/swift-cloud/Vercel", from: "2.3.0"),
        .package(url: "https://github.com/MarkCodable/MarkCodable.git", from: "0.6.9"),
    ],
    targets: [
        .executableTarget(name: "App", dependencies: [
            .product(name: "Vercel", package: "Vercel"),
            .product(name: "VercelVapor", package: "Vercel"),
            .product(name: "MarkCodable", package: "MarkCodable"),
        ])
    ]
)
