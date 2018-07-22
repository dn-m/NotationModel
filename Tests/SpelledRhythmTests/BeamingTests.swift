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

    func testCutStartCountEqualToAmount() {
        let startOrStop = Beaming.Point.StartOrStop.start(count: 2)
        let (cut, remaining) = startOrStop.cut(amount: 2)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(cut, .none)
    }

    func testCutStartCountGreaterThanAmount() {
        let startOrStop = Beaming.Point.StartOrStop.start(count: 2)
        let (cut, remaining) = startOrStop.cut(amount: 1)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(cut, .start(count: 1))
    }

    func testCutStartCountLessThanAmount() {
        let startOrStop = Beaming.Point.StartOrStop.start(count: 1)
        let (cut, remaining) = startOrStop.cut(amount: 2)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(cut, .none)
    }

    func testCutStopCountEqualToAmount() {
        let startOrStop = Beaming.Point.StartOrStop.stop(count: 2)
        let (cut, remaining) = startOrStop.cut(amount: 2)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(cut, .none)
    }

    func testCutStopCountGreaterThanAmount() {
        let startOrStop = Beaming.Point.StartOrStop.stop(count: 2)
        let (cut, remaining) = startOrStop.cut(amount: 1)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(cut, .stop(count: 1))
    }

    func testCutStopCountLessThanAmount() {
        let startOrStop = Beaming.Point.StartOrStop.stop(count: 1)
        let (cut, remaining) = startOrStop.cut(amount: 2)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(cut, .none)
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

    // MARK: - Vertical Transforms

    func testStopsToBeamletsNoStops() {
        let vertical = Beaming.Point.Vertical()
        let (newVertical, remaining) = vertical.stopsToBeamlets(amount: 1)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(newVertical, vertical)
    }

    func testStopsToBeamletsAmountGreaterThanCount() {
        let vertical = Beaming.Point.Vertical(stop: 1)
        let (newVertical, remaining) = vertical.stopsToBeamlets(amount: 2)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(newVertical, .init(beamlets: 1))
    }

    func testStopsToBeamletsCountGreaterThanAmount() {
        let vertical = Beaming.Point.Vertical(stop: 4)
        let (newVertical, remaining) = vertical.stopsToBeamlets(amount: 1)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(newVertical, .init(stop: 3, beamlets: 1))
    }

    func testStartsToBeamletsNoStarts() {
        let vertical = Beaming.Point.Vertical()
        let (newVertical, remaining) = vertical.startsToBeamlets(amount: 1)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(newVertical, vertical)
    }

    func testStartsToBeamletsAmountGreaterThanCount() {
        let vertical = Beaming.Point.Vertical(start: 1)
        let (newVertical, remaining) = vertical.startsToBeamlets(amount: 2)
        XCTAssertEqual(remaining, 1)
        XCTAssertEqual(newVertical, .init(beamlets: 1))
    }

    func testStartsToBeamletsCountGreaterThanAmount() {
        let vertical = Beaming.Point.Vertical(start: 4)
        let (newVertical, remaining) = vertical.startsToBeamlets(amount: 1)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(newVertical, .init(start: 3, beamlets: 1))
    }

    func testMaintainsToStartsNone() {
        let vertical = Beaming.Point.Vertical()
        let (newVertical, remaining) = vertical.maintainsToStarts(amount: 3)
        XCTAssertEqual(remaining, 3)
        XCTAssertEqual(newVertical, vertical)
    }

    func testMaintainsToStartsAmountGreaterThanCount() {
        let vertical = Beaming.Point.Vertical(maintain: 2)
        let (newVertical, remaining) = vertical.maintainsToStarts(amount: 5)
        XCTAssertEqual(remaining, 3)
        XCTAssertEqual(newVertical, .init(start: 2))
    }

    func testMaintainsToStartsAmountLessThanCount() {
        let vertical = Beaming.Point.Vertical(maintain: 4)
        let (newVertical, remaining) = vertical.maintainsToStarts(amount: 3)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(newVertical, .init(maintain: 1, start: 3))
    }

    func testMaintainsToStopsNone() {
        let vertical = Beaming.Point.Vertical()
        let (newVertical, remaining) = vertical.maintainsToStops(amount: 3)
        XCTAssertEqual(remaining, 3)
        XCTAssertEqual(newVertical, vertical)
    }

    func testMaintainsToStopsAmountGreaterThanCount() {
        let vertical = Beaming.Point.Vertical(maintain: 2)
        let (newVertical, remaining) = vertical.maintainsToStops(amount: 5)
        XCTAssertEqual(remaining, 3)
        XCTAssertEqual(newVertical, .init(stop: 2))
    }

    func testMaintainsToStopsAmountLessThanCount() {
        let vertical = Beaming.Point.Vertical(maintain: 4)
        let (newVertical, remaining) = vertical.maintainsToStops(amount: 3)
        XCTAssertEqual(remaining, 0)
        XCTAssertEqual(newVertical, .init(maintain: 1, stop: 3))
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

    // MARK: - Cut

    func testCutTwoBeamedEighthsIntoTwoQuarterNoteBeamlets() {
        let beaming = self.beaming(beamCounts: [1,1])
        let cut = try! beaming.cut(amount: 1, at: 1)
        let expected = Beaming([.init(beamlets: 1), .init(beamlets: 1)])
        XCTAssertEqual(cut, expected)
    }

    /// :---:---:      :-   :---:
    /// :   :   :  ->  :    :   :
    ///     x
    func testTripletEighthsCutAt1() {
        let beaming = self.beaming(beamCounts: [1,1,1])
        let cut = try! beaming.cut(amount: 1, at: 1)
        let expected = Beaming([
            .init(beamlets: 1),
            .init(start: 1),
            .init(stop: 1)
        ])
        XCTAssertEqual(cut, expected)
    }

    /// :---:---:      :---:   -:
    /// :   :   :  ->  :   :    :
    ///         x
    func testTripletEighthsCutAt2() {
        let beaming = self.beaming(beamCounts: [1,1,1])
        let cut = try! beaming.cut(amount: 1, at: 2)
        let expected = Beaming([
            .init(start: 1),
            .init(stop: 1),
            .init(beamlets: 1)
        ])
        XCTAssertEqual(cut, expected)
    }

    /// :---:---:      :---:---:
    /// :---:---:      :-  :---:
    /// :   :  -:  ->  :   :  -:
    ///     x
    func testSixteenthSixteenthThirtySecondCutAt1() {
        let beaming = self.beaming(beamCounts: [2,2,3])
        let cut = try! beaming.cut(amount: 1, at: 1)
        let expected = Beaming([
            .init(start: 1, beamlets: 1),
            .init(maintain: 1, start: 1),
            .init(stop: 2, beamlets: 1)
        ])
        XCTAssertEqual(cut, expected)
    }

    /// :---:---:---:      :---:---:---:
    /// :---:---:---:      :---:   :---:
    /// :   :   :   :  ->  :   :   :   :
    ///         x
    func testCutFourSixteenthsIntoTwoPairsCutOneLevel() {
        let beaming = self.beaming(beamCounts: [2,2,2,2])
        let cut = try! beaming.cut(amount: 1, at: 2)
        let expected = Beaming([
            .init(start: 2),
            .init(maintain: 1, stop: 1),
            .init(maintain: 1, start: 1),
            .init(stop: 2)
        ])
        XCTAssertEqual(cut, expected)
    }
}
