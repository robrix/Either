// swift-tools-version:4.0

import PackageDescription

let package = Package(
        name: "Either",
        products: [
            .library(name: "Either", targets: ["Either"])
        ],
        dependencies: [
            .package(url: "https://github.com/robrix/Prelude.git", "3.0.1"..<"4.0.0")
        ],
        targets: [
            .target(name: "Either", dependencies: ["Prelude"], path: "Either"),
            .testTarget(name: "EitherTests", dependencies: ["Either"], path: "EitherTests")
        ],
        swiftLanguageVersions: [3]
)
