// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "TheCHRP",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "TheCHRP",
            targets: ["TheCHRP"]
        )
    ],
    targets: [
        .target(
            name: "TheCHRP",
            path: "Sources/TheCHRP"
        ),
        .testTarget(
            name: "TheCHRPTests",
            dependencies: ["TheCHRP"],
            path: "Tests/TheCHRPTests"
        )
    ]
)
