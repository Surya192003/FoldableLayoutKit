// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FoldableLayoutKit",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "FoldableLayoutKit", targets: ["FoldableLayoutKit"])
    ],
    targets: [
        .target(name: "FoldableLayoutKit"),
        .testTarget(
            name: "FoldableLayoutKitTests",
            dependencies: ["FoldableLayoutKit"]
        )
    ]
)