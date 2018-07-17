//
//  RhythmBeamerTests.swift
//  RhythmBeamerTests
//
//  Created by James Bean on 6/18/18.
//

import XCTest
import DataStructures
import MetricalDuration
import Rhythm
@testable import RhythmBeamer

class RhythmBeamerTests: XCTestCase {

    func testBeamsCountDurationCoefficient2() {
        let duration = 8 /> 64 // 1/8
        XCTAssertEqual(beamCount(duration), 1)
    }

    func testBeamsCountDurationCoefficient3() {
        let duration = 12 /> 256 // 3/64
        XCTAssertEqual(beamCount(duration), 3)
    }

    func testBeamsCountDurationCoefficient7() {
        let duration = 28 /> 32 // 7/8
        XCTAssertEqual(beamCount(duration), -1)
    }

    func testSingletSetOfBeamlets() {
        let beamCounts = [4]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(beamlets: 4)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testDoubletSameValues() {
        let beamCounts = [3,3]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 3),
            .init(stop: 3)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testDoubletFirstHigher() {
        let beamCounts = [4,1]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 1, beamlets: 3),
            .init(stop: 1)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testDoubletSecondHigher() {
        let beamCounts = [2,3]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 2),
            .init(stop: 2, beamlets: 1)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testTripletSameValues() {
        let beamCounts = [2,2,2]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 2),
            .init(maintain: 2),
            .init(stop: 2)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testTripletLowMidHigh() {
        let beamCounts = [1,2,4]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 1),
            .init(maintain: 1, start: 1),
            .init(stop: 2, beamlets: 2)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testTripletLowHighMid() {
        let beamCounts = [1,3,2]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 1),
            .init(maintain: 1, start: 1, beamlets: 1),
            .init(stop: 2)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testTripletMidLowHigh() {
        let beamCounts = [2,1,4]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 1, beamlets: 1),
            .init(maintain: 1),
            .init(stop: 1, beamlets: 3)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testTripletMidHighLow() {
        let beamCounts = [2,3,1]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 2),
            .init(maintain: 1, stop: 1, beamlets: 1),
            .init(stop: 1)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testLongSequence() {
        let beamCounts = [1,3,2,2,4,3,3,1,3]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(beamCounts)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 1), // 1
            .init(maintain: 1, startOrStop: .start(count: 1), beamlets: 1), // 3
            .init(maintain: 2), // 2
            .init(maintain: 2), // 2
            .init(maintain: 2, start: 1, beamlets: 1), // 4
            .init(maintain: 3), // 3
            .init(maintain: 1, stop: 2), // 3
            .init(maintain: 1), // 1
            .init(stop: 1, beamlets: 2) // 3
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testFourOneOneOneOne() {
        let tree = 4/>8 * [4,1,1,1,1]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(tree.leaves)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(),
            .init(start: 2),
            .init(maintain: 2),
            .init(maintain: 2),
            .init(stop: 2)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testOneFourOneOneOne() {
        let tree = 4/>8 * [1,4,1,1,1]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(tree.leaves)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(beamlets: 2),
            .init(),
            .init(start: 2),
            .init(maintain: 2),
            .init(stop: 2)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testOneOneFourOneOne() {
        let tree = 4/>8 * [1,1,4,1,1]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(tree.leaves)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 2),
            .init(stop: 2),
            .init(),
            .init(start: 2),
            .init(stop: 2)
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testOneOneOneFourOne() {
        let tree = 4/>8 * [1,1,1,4,1]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(tree.leaves)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 2),
            .init(maintain: 2),
            .init(stop: 2),
            .init(),
            .init(beamlets: 2),
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testOneOneOneOneFour() {
        let tree = 4/>8 * [1,1,1,1,4]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(tree.leaves)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 2),
            .init(maintain: 2),
            .init(maintain: 2),
            .init(stop: 2),
            .init(),
        ]
        XCTAssertEqual(verticals, expected)
    }

    func testInitWithRhythmTreeDottedValues() {
        let tree = 2/>8 * [1,2,3,7]
        let verticals: [Rhythm<()>.Beaming.Point.Vertical] = beamingVerticals(tree.leaves)
        let expected: [Rhythm<()>.Beaming.Point.Vertical] = [
            .init(start: 3, beamlets: 1),
            .init(maintain: 3),
            .init(maintain: 2, stop: 1),
            .init(stop: 2)
        ]
        XCTAssertEqual(verticals, expected)
    }
}
