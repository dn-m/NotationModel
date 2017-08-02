// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotationModel",
    products: [
        .library(name: "PlotModel", targets: ["PlotModel"]),
        .library(name: "SpelledPitch", targets: ["SpelledPitch"]),
        .library(name: "PitchSpeller", targets: ["PitchSpeller"]),
        .library(name: "BeamedRhythm", targets: ["BeamedRhythm"]),
        .library(name: "StaffModel", targets: ["StaffModel"])
    ],
    dependencies: [
        .package(url: "https://github.com/dn-m/Structure", .branch("master")),
        .package(url: "https://github.com/dn-m/Math", .branch("master")),
        .package(url: "https://github.com/dn-m/Music", .branch("master"))
    ],
    targets: [
        // Sources
        .target(name: "PlotModel", dependencies: ["StructureWrapping", "DictionaryProtocol"]),
        .target(name: "SpelledPitch", dependencies: ["Pitch"]),
        .target(name: "PitchSpeller", dependencies: ["SpelledPitch"]),
        .target(name: "BeamedRhythm", dependencies: ["Rhythm"]),
        .target(name: "StaffModel", dependencies: ["PlotModel", "SpelledPitch"]),

        // Tests
        .testTarget(name: "PlotModelTests"),
        .testTarget(name: "SpelledPitchTests", dependencies: ["SpelledPitch"]),
        .testTarget(name: "PitchSpellerTests", dependencies: ["PitchSpeller"]),
        .testTarget(name: "BeamedRhythmTests", dependencies: ["BeamedRhythm"]),
        .testTarget(name: "StaffModelTests", dependencies: ["StaffModel"])
    ]
)
