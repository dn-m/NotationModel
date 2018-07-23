//
//  BeamletDirectionTests.swift
//  NotationModel
//
//  Created by James Bean on 7/22/18.
//

import XCTest
import SpelledRhythm
@testable import RhythmBeamer

class BeamletDirectionTests: XCTestCase {

    func testTwoEighthNotesCutBeamletDirectionsForwardBackward() {
        let beaming = Beaming(beamingVerticals([1,1]))
        let cut = try! beaming.cut(amount: 1, at: 1)
        let expected: [[Beaming.Point]] = [
            [.beamlet(direction: .forward)],
            [.beamlet(direction: .backward)]
        ]
        XCTAssertEqual(cut.map { $0.points }, expected)
    }
}
