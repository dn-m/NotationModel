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

    // MARK: - StartOrStop

    // Don't consume start when cutting _at_
    func testStartOrStopCutAtStartEqual() {
        let amount = 7
        let startOrStop = Beaming.Point.StartOrStop.start(count: amount)
        let (before,after,remaining) = try! startOrStop.cutAt(amount: 7)
        XCTAssertEqual(remaining, 7)
        XCTAssertEqual(startOrStop, .start(count: amount))
    }

    // Don't consume start when cutting _at_
    func testStartOrStopCutAtStartAmountGreaterThanCount() {
        let startOrStop = Beaming.Point.StartOrStop.start(count: 1)
        let (before,after,remaining) = try! startOrStop.cutAt(amount: 2)
        XCTAssertEqual(remaining, 2)
        XCTAssertEqual(startOrStop, .start(count: 1))
    }

    // Don't consume start when cutting _at_
    func testStartOrStopCutAtStartAmountLessThanCount() {
        let startOrStop = Beaming.Point.StartOrStop.start(count: 2)
        let (before,after,remaining) = try! startOrStop.cutAt(amount: 1)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(startOrStop, .start(count: 2))
    }

    // Consume stop when cutting _at_
    func testStartOrStopCutAtStopEqual() {
        let amount = 7
        let startOrStop = Beaming.Point.StartOrStop.stop(count: amount)
        let (before,after,remaining) = try! startOrStop.cutAt(amount: 7)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(after, .none)
    }

    // Consume stop when cutting _at_
    func testStartOrStopCutAtStopAmountGreaterThanCount() {
        let startOrStop = Beaming.Point.StartOrStop.stop(count: 1)
        let (before,after,remaining) = try! startOrStop.cutAt(amount: 2)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(after, .none)
    }

    // Consume stop when cutting _at_
    func testStartOrStopCutAtStopAmountLessThanCount() {
        let startOrStop = Beaming.Point.StartOrStop.stop(count: 2)
        let (before,after,remaining) = try! startOrStop.cutAt(amount: 1)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(after, .stop(count: 1))
    }

    // Consume start when cutting _after_
    func testStartOrStopCutAfterStartEqual() {
        let amount = 7
        let startOrStop = Beaming.Point.StartOrStop.start(count: amount)
        let (before,after,remaining) = try! startOrStop.cutAfter(amount: 7)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(after, .none)
    }

    // Consume start when cutting _after_
    func testStartOrStopCutAfterStartAmountGreaterThanCount() {
        let startOrStop = Beaming.Point.StartOrStop.start(count: 1)
        let (before,after,remaining) = try! startOrStop.cutAfter(amount: 2)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(after, .none)
    }

    // Consume start when cutting _after_
    func testStartOrStopCutAfterStartAmountLessThanCount() {
        var startOrStop = Beaming.Point.StartOrStop.start(count: 2)
        let (before,after,remaining) = try! startOrStop.cutAfter(amount: 1)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(after, .start(count: 1))
    }

    // Don't consume stop when cutting _after
    func testStartOrStopCutAfterStopEqual() {
        let amount = 7
        let startOrStop = Beaming.Point.StartOrStop.stop(count: amount)
        let (before,after,remaining) = try! startOrStop.cutAfter(amount: 7)
        XCTAssertEqual(remaining, 7)
        XCTAssertEqual(startOrStop, .stop(count: amount))
    }

    // Don't consume stop when cutting _after
    func testStartOrStopCutAfterStopAmountGreaterThanCount() {
        let startOrStop = Beaming.Point.StartOrStop.stop(count: 1)
        let (before,after,remaining) = try! startOrStop.cutAfter(amount: 2)
        XCTAssertEqual(remaining, 2)
        XCTAssertEqual(startOrStop, .stop(count: 1))
    }

    // Don't consume stop when cutting _after
    func testStartOrStopCutAfterStopAmountLessThanCount() {
        let startOrStop = Beaming.Point.StartOrStop.stop(count: 2)
        let (before,after,remaining) = try! startOrStop.cutAfter(amount: 1)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(startOrStop, .stop(count: 2))
    }

    // MARK: - Vertical

    func testCutAfterEqualToStartCountSingleLevel() {
        let vertical = Beaming.Point.Vertical(start: 1)
        let cut = try! vertical.cutAfter(amount: 1)
        XCTAssertEqual(cut, .init(beamlets: 1))
    }

    func testCutAtEqualToStopCountSingleLevel() {
        let vertical = Beaming.Point.Vertical(stop: 1)
        let cut = try! vertical.cutAt(amount: 1)
        XCTAssertEqual(cut, .init(beamlets: 1))
    }

    // MARK: - Beaming

    func beaming(beamCounts: [Int]) -> Beaming {
        return Beaming(beamingVerticals(beamCounts))
    }

    // MARK: Errors

    func testCutSingleBeamingThrowsItemOutOfRange() {
        let beaming = self.beaming(beamCounts: [8])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 0))
    }

    func testCutFirstThrowsIndexOutOfBounds() {
        let beaming = self.beaming(beamCounts: [1,2,3,4])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 0))
    }

    func testCutAfterLastThrowsOutOfBounds() {
        let beaming = self.beaming(beamCounts: [1,2,3])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 3))
    }

    func testCutQuarterNotesThrowsCurrentStackEmpty() {
        let beaming = self.beaming(beamCounts: [4,0])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 1))
    }

    func testCutQuarterNotesThrowsPreviousStackEmpty() {
        let beaming = self.beaming(beamCounts: [0,4])
        XCTAssertThrowsError(try beaming.cut(amount: 1, at: 1))
    }

    func testCutTwoBeamedEighthsIntoTwoQuarterNoteBeamlets() {
        let beaming = self.beaming(beamCounts: [1,1])
        let cut = try! beaming.cut(amount: 1, at: 1)
        let expected = Beaming([.init(beamlets: 1), .init(beamlets: 1)])
        dump(cut)
        dump(expected)
        XCTAssertEqual(cut, expected)
    }

    func testCutFourSixteenthsIntoTwoPairs() {
        #warning("Implement testCutFourSixteenthsIntoTwoPairs()")
    }
}
