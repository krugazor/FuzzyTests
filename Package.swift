// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FuzzyTests",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "FuzzyTests",
            targets: ["FuzzyTests"]),
        .executable(name: "FTDocs", targets: ["FTDocs"]),
        .executable(name: "FTLint", targets: ["FTLint"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/krugazor/HoledRange", from: "0.1.3"),
        .package(url: "https://github.com/realm/SwiftLint", from: "0.39.0"),
        .package(url: "https://github.com/krugazor/SourceDocs", from: "0.7.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "FuzzyTests",
            dependencies: ["HoledRange"]),
        .testTarget(
            name: "FuzzyTestsTests",
            dependencies: ["FuzzyTests"]),
        .target(
            name: "FTDocs",
            dependencies: [.product(name: "sourcedocslib", package: "SourceDocs")]),
        .target(
            name: "FTLint",
            dependencies: [.product(name: "SwiftLintFramework", package: "SwiftLint")]),
    ]
)
