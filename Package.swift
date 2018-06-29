// swift-tools-version:4.2
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
        .target(name: "StaffModel", dependencies: ["PlotModel", "SpelledPitch"]),

        // Tests
        .testTarget(name: "PlotModelTests", dependencies: ["PlotModel"]),
        .testTarget(name: "SpelledPitchTests", dependencies: ["SpelledPitch"]),
        .testTarget(name: "PitchSpellerTests", dependencies: ["PitchSpeller"]),
        .testTarget(name: "BeamedRhythmTests", dependencies: ["BeamedRhythm"]),
        .testTarget(name: "StaffModelTests", dependencies: ["StaffModel"])
    ]
)
