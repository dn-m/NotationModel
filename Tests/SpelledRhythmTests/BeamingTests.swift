//
//  BeamingTests.swift
//  SpelledRhythmTests
//
//  Created by James Bean on 6/20/18.
//

import XCTest
import MetricalDuration
import Rhythm
@testable import RhythmBeamer
@testable import SpelledRhythm

class BeamingTests: XCTestCase {

    func beaming(beamCounts: [Int]) -> Beaming {
        return Beaming(beamingVerticals(beamCounts))
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
        var beaming = self.beaming(beamCounts: [4,0])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 1))
    }

    func testCutQuarterNotesThrowsPreviousStackEmpty() {
        var beaming = self.beaming(beamCounts: [0,4])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 1))
    }

    func testCutTwoBeamedEighthsIntoTwoQuarterNoteBeamlets() {
        var beaming = self.beaming(beamCounts: [1,1])
        try! beaming.cut(amount: 1, at: 1)
        let expected = Beaming([.init(beamlets: 1), .init(beamlets: 1)])
        XCTAssertEqual(beaming, expected)
    }

    func testCutFourSixteenthsIntoTwoPairs() {
        #warning("Implement testCutFourSixteenthsIntoTwoPairs()")
    }
}
