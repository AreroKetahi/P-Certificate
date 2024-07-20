// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PCertificate",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "PCertificate",
            targets: ["PCertificate"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", "1.0.0" ..< "4.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "PCertificate",
            dependencies: [
                .product(name: "SwiftProtobuf", package: "swift-protobuf"),
                .product(name: "Crypto", package: "swift-crypto"),
                .product(name: "_CryptoExtras", package: "swift-crypto"),
            ],
            exclude: [
                "Protobuf/PCert.proto",
                "Protobuf/PCertChain.proto",
                "Protobuf/PKey.proto",
            ],
            swiftSettings: .swiftSettings
        ),
        .testTarget(
            name: "PCertificateTests",
            dependencies: ["PCertificate"],
            swiftSettings: .swiftSettings
        ),
    ]
)

extension Array where Element == PackageDescription.SwiftSetting {
    static let swiftSettings: Self = [
        .enableExperimentalFeature("StrictConcurrency=complete"),
        .enableUpcomingFeature("ExistentialAny"),
    ]
}
