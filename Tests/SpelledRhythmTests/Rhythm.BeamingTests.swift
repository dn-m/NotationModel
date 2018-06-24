//
//  Rhythm.swift
//  SpelledRhythmTests
//
//  Created by James Bean on 6/20/18.
//

import XCTest
import MetricalDuration
import Rhythm
@testable import RhythmBeamer
@testable import SpelledRhythm

class Rhythm_BeamingTests: XCTestCase {

    func beaming(beamCounts: [Int]) -> Rhythm<()>.Beaming {
        return Rhythm<()>.Beaming(beamingItems(beamCounts))
    }

    func testCutSingleBeamingThrowsItemOutOfRange() {
        var beams = beaming(beamCounts: [1])
        //XCTAssertThrowsError(try beams.cut(amount: 1, at: 1))
    }

    func testTwoBeamedEighthsIntoTwoQuarterNoteBeamlets() {
        var beams = beaming(beamCounts: [1,1])
        do {
            //try beams.cut(amount: 1, at: 1)
            //XCTAssertEqual(beams, beaming([]))
        } catch { }
    }

    func testCutFourSixteenthsIntoTwoPairs() {

    }
}
