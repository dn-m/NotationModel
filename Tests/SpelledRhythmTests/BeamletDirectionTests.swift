//
//  BeamletDirectionTests.swift
//  NotationModel
//
//  Createsd by James Bean on 7/22/18.
//

import XCTest
@testable import SpelledRhythm

class BeamletDirectionTests: XCTestCase {

    func testTwoEighthNotesCutBeamletDirectionsForwardBackward() {
        let beaming = Beaming(beamCounts: ([1,1]))
        let cut = try! beaming.cut(amount: 1, at: 1)
        let expected: [[Beaming.Point]] = [
            [.beamlet(direction: .forward)],
            [.beamlet(direction: .backward)]
        ]
        XCTAssertEqual(cut.map { $0.points }, expected)
    }

    func testSingleBeamletsForward() {
        for beamCount in 1..<10 {
            let beaming = Beaming(beamCounts: [beamCount])
            XCTAssertEqual(beaming.first!.beamletDirection, .forward)
        }
    }

    func testFirstBeamletsForward() {
        // Creates one thousand beamings where the first vertical has beamlets
        for _ in 1..<1_000 {
            let verticalsCount = Int.random(in: 2..<20)
            let firstBeamCount = Int.random(in: 1...10)
            let rest = (0..<(verticalsCount - 1)).map { _ in Int.random(in: 0..<firstBeamCount) }
            let beaming = Beaming(beamCounts: [firstBeamCount] + rest)
            XCTAssertEqual(beaming.first!.beamletDirection, .forward)
        }
    }

    func testLastBeamletsBackward() {
        // Creates one thousand beamings where the first vertical has beamlets
        for _ in 1..<1_000 {
            let verticalsCount = Int.random(in: 2..<20)
            let lastBeamCount = Int.random(in: 1...10)
            let rest = (0..<(verticalsCount - 1)).map { _ in Int.random(in: 0..<lastBeamCount) }
            let beaming = Beaming(beamCounts: rest + [lastBeamCount])
            XCTAssertEqual(beaming.last!.beamletDirection, .backward)
        }
    }
}
