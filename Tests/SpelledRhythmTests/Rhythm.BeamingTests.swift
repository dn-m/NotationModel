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
        return Rhythm<()>.Beaming(beamingVerticals(beamCounts))
    }

    func testCutSingleBeamingThrowsItemOutOfRange() {
        var beaming = self.beaming(beamCounts: [8])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 0))
    }

    func testCutFirstThrowsIndexOutOfBounds() {
        var beaming = self.beaming(beamCounts: [1,2,3,4])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 0))
    }

    func testCutAfterLastThrowsOutOfBounds() {
        var beaming = self.beaming(beamCounts: [1,2,3])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 3))
    }

    func testCutQuarterNotesThrowsCurrentStackEmpty() {
        #warning("Implement testCutQuarterNotesThrowsCurrentStackEmpty()")
    }

    func testCutQuarterNotesThrowsPreviousStackEmpty() {
        #warning("Implement testCutQuarterNotesThrowsPreviousStackEmpty()")
    }

    func testCutTwoBeamedEighthsIntoTwoQuarterNoteBeamlets() {
        #warning("Implement testCutTwoBeamedEighthsIntoTwoQuarterNoteBeamlets()")
    }

    func testCutFourSixteenthsIntoTwoPairs() {
        #warning("Implement testCutFourSixteenthsIntoTwoPairs()")
    }
}
