// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MiniMartCore",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "MiniMartCore",
            targets: ["MiniMartCore"]
        )
    ],
    targets: [
        .target(
            name: "MiniMartCore",
            path: "Sources/MiniMartCore"
        )
    ]
)
