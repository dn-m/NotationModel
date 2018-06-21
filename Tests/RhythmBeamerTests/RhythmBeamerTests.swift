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

    func assertBeamingItems(
        for beamCounts: [Int],
        areEqualTo points: [Stack<Rhythm<()>.Beaming.Item.Point>]
    )
    {
        let items: [Rhythm<()>.Beaming.Item] = beamingItems(beamCounts)
        let expected = points.map(Rhythm<()>.Beaming.Item.init)
        XCTAssertEqual(items, expected)
    }

    func assertBeamingItems(
        for metricalDurationTree: MetricalDurationTree,
        areEqualTo points: [Stack<Rhythm<()>.Beaming.Item.Point>]
    )
    {
        let items: [Rhythm<()>.Beaming.Item] = beamingItems(metricalDurationTree.leaves)
        let expected = points.map(Rhythm<()>.Beaming.Item.init)
        XCTAssertEqual(items, expected)
    }

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
        assertBeamingItems(for: [4], areEqualTo: [
            [
                .beamlet(direction: .forward),
                .beamlet(direction: .forward),
                .beamlet(direction: .forward),
                .beamlet(direction: .forward)
            ]
        ])
    }

    func testDoubletSameValues() {
        assertBeamingItems(for: [3,3], areEqualTo: [
            [.start, .start, .start],
            [.stop, .stop, .stop]
        ])
    }

    func testDoubletFirstHigher() {
        assertBeamingItems(for: [4,1], areEqualTo: [
            [
                .start,
                .beamlet(direction: .forward),
                .beamlet(direction: .forward),
                .beamlet(direction: .forward)
            ],
            [
                .stop
            ]
        ])
    }

    func testDoubletSecondHigher() {
        assertBeamingItems(for: [2,3], areEqualTo: [
            [.start, .start],
            [.stop, .stop, .beamlet(direction: .backward)]
        ])
    }

    func testTripletSameValues() {
        assertBeamingItems(for: [2,2,2], areEqualTo: [
            [.start, .start],
            [.maintain, .maintain],
            [.stop, .stop]
        ])
    }

    func testTripletLowMidHigh() {
        assertBeamingItems(for: [1,2,4], areEqualTo: [
            [.start],
            [.maintain, .start],
            [.stop, .stop, .beamlet(direction: .backward), .beamlet(direction: .backward)]
        ])
    }

    func testTripletLowHighMid() {
        assertBeamingItems(for: [1,3,2], areEqualTo: [
            [.start],
            [.maintain, .start, .beamlet(direction: .backward)],
            [.stop, .stop]
        ])
    }

    func testTripletMidLowHigh() {
        assertBeamingItems(for:  [2,1,4], areEqualTo: [
            [.start, .beamlet(direction: .forward)],
            [.maintain],
            [
                .stop,
                .beamlet(direction: .backward),
                .beamlet(direction: .backward),
                .beamlet(direction: .backward)
            ]
        ])
    }

    func testTripletMidHighLow() {
        assertBeamingItems(for: [2,3,1], areEqualTo: [
            [.start, .start],
            [.maintain, .stop, .beamlet(direction: .backward)],
            [.stop]
        ])
    }

    func testLongSequence() {
        assertBeamingItems(for: [1,3,2,2,4,3,3,1,3], areEqualTo: [
            [.start], // 1
            [.maintain, .start, .beamlet(direction: .backward)], // 3
            [.maintain, .maintain], // 2
            [.maintain, .maintain], // 2
            [.maintain, .maintain, .start, .beamlet(direction: .backward)], // 4
            [.maintain, .maintain, .maintain], // 3
            [.maintain, .stop, .stop], // 3
            [.maintain], // 1
            [.stop, .beamlet(direction: .backward), .beamlet(direction: .backward)] // 3
        ])
    }

    func testFourOneOneOneOne() {
        assertBeamingItems(for: 4/>8 * [4,1,1,1,1], areEqualTo: [
            [],
            [.start, .start],
            [.maintain, .maintain],
            [.maintain, .maintain],
            [.stop, .stop]
        ])
    }

    func testOneFourOneOneOne() {
        assertBeamingItems(for: 4/>8 * [1,4,1,1,1], areEqualTo: [
            [.beamlet(direction: .forward), .beamlet(direction: .forward)],
            [],
            [.start, .start],
            [.maintain, .maintain],
            [.stop, .stop]
        ])
    }

    func testOneOneFourOneOne() {
        assertBeamingItems(for: 4/>8 * [1,1,4,1,1], areEqualTo: [
            [.start, .start],
            [.stop, .stop],
            [],
            [.start, .start],
            [.stop, .stop]
        ])
    }

    func testOneOneOneFourOne() {
        assertBeamingItems(for: 4/>8 * [1,1,1,4,1], areEqualTo: [
            [.start, .start],
            [.maintain, .maintain],
            [.stop, .stop],
            [],
            [.beamlet(direction: .backward), .beamlet(direction: .backward)]
        ])
    }

    func testOneOneOneOneFour() {
        assertBeamingItems(for: 4/>8 * [1,1,1,1,4], areEqualTo: [
            [.start, .start],
            [.maintain, .maintain],
            [.maintain, .maintain],
            [.stop, .stop],
            []
        ])
    }

    func testInitWithRhythmTreeDottedValues() {
        assertBeamingItems(for: 2/>8 * [1,2,3,7], areEqualTo: [
            [.start, .start, .start, .beamlet(direction: .forward)],
            [.maintain, .maintain, .maintain],
            [.maintain, .maintain, .stop],
            [.stop, .stop]
        ])
    }
}
