// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotationModel",
    products: [
        .library(name: "PlotModel", targets: ["PlotModel"]),
        .library(name: "SpelledPitch", targets: ["SpelledPitch"]),
        .library(name: "PitchSpeller", targets: ["PitchSpeller"]),
        .library(name: "BeamedRhythm", targets: ["BeamedRhythm"]),
        .library(name: "RhythmBeamer", targets: ["RhythmBeamer"]),
        .library(name: "SpelledRhythm", targets: ["SpelledRhythm"]),
        .library(name: "StaffModel", targets: ["StaffModel"])
    ],
    dependencies: [
        .package(url: "https://github.com/dn-m/Structure", .branch("swift-4.2")),
        .package(url: "https://github.com/dn-m/Math", .branch("swift-4.2")),
        .package(url: "https://github.com/dn-m/Music", .branch("swift-4.2"))
    ],
    targets: [
        // Sources
        .target(name: "PlotModel", dependencies: ["StructureWrapping", "DataStructures"]),
        .target(name: "SpelledPitch", dependencies: ["Pitch", "DataStructures"]),
        .target(name: "PitchSpeller", dependencies: ["SpelledPitch"]),
        .target(name: "BeamedRhythm", dependencies: ["Rhythm"]),
        .target(name: "RhythmBeamer", dependencies: ["BeamedRhythm"]),
        .target(name: "SpelledRhythm", dependencies: ["Rhythm"]),
        .target(name: "StaffModel", dependencies: ["PlotModel", "SpelledPitch"]),

        // Tests
        .testTarget(name: "PlotModelTests", dependencies: ["PlotModel"]),
        .testTarget(name: "SpelledPitchTests", dependencies: ["SpelledPitch"]),
        .testTarget(name: "PitchSpellerTests", dependencies: ["PitchSpeller"]),
        .testTarget(name: "SpelledRhythmTests", dependencies: ["SpelledRhythm"]),
        .testTarget(name: "RhythmBeamerTests", dependencies: ["RhythmBeamer"]),
        .testTarget(name: "StaffModelTests", dependencies: ["StaffModel"])
    ]
)
