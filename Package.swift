sl // swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotationModel",
    products: [
        .library(name: "PlotModel", targets: ["PlotModel"]),
        .library(name: "SpelledPitch", targets: ["SpelledPitch"]),
        .library(name: "PitchSpeller", targets: ["PitchSpeller"]),
        .library(name: "RhythmBeamer", targets: ["RhythmBeamer"]),
        .library(name: "SpelledRhythm", targets: ["SpelledRhythm"]),
        .library(name: "StaffModel", targets: ["StaffModel"])
    ],
    dependencies: [
        .package(url: "https://github.com/dn-m/Structure", from: "0.1.3"),
        .package(url: "https://github.com/dn-m/Math", from: "0.1.0"),
        .package(url: "https://github.com/dn-m/Music", from: "0.1.0")
    ],
    targets: [
        // Sources
        .target(name: "PlotModel", dependencies: ["DataStructures"]),
        .target(name: "SpelledPitch", dependencies: ["Pitch", "DataStructures"]),
        .target(name: "PitchSpeller", dependencies: ["SpelledPitch"]),
        .target(name: "RhythmBeamer", dependencies: ["SpelledRhythm"]),
        .target(name: "SpelledRhythm", dependencies: ["Rhythm"]),
        .target(name: "StaffModel", dependencies: ["PlotModel", "SpelledPitch"]),

        // Tests
        .testTarget(name: "PlotModelTests", dependencies: ["PlotModel"]),
        .testTarget(name: "SpelledPitchTests", dependencies: ["SpelledPitch"]),
        .testTarget(name: "PitchSpellerTests", dependencies: ["PitchSpeller"]),
        .testTarget(name: "SpelledRhythmTests", dependencies: ["SpelledRhythm", "RhythmBeamer"]),
        .testTarget(name: "RhythmBeamerTests", dependencies: ["RhythmBeamer"]),
        .testTarget(name: "StaffModelTests", dependencies: ["StaffModel"])
    ]
)
