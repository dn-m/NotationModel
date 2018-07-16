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
        #warning("Implement testCutSingleBeamingThrowsItemOutOfRange()")
    }

    func testCutTwoBeamedEighthsIntoTwoQuarterNoteBeamlets() {
        #warning("Implement testCutTwoBeamedEighthsIntoTwoQuarterNoteBeamlets()")
    }

    func testCutFourSixteenthsIntoTwoPairs() {
        #warning("Implement testCutFourSixteenthsIntoTwoPairs()")
    }
}
