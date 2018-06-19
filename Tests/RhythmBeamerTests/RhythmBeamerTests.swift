//
//  RhythmBeamerTests.swift
//  RhythmBeamerTests
//
//  Created by James Bean on 6/18/18.
//

import XCTest
import MetricalDuration
import Rhythm
@testable import RhythmBeamer

class RhythmBeamerTests: XCTestCase {

    func assertBeamingItems(
        for beamCounts: [Int],
        areEqualTo points: [[Rhythm<()>.Beaming.Item.Point]]
    )
    {
        let items: [Rhythm<()>.Beaming.Item] = beamingItems(beamCounts)
        let expected = points.map(Rhythm<()>.Beaming.Item.init)
        XCTAssertEqual(items, expected)
    }

    func assertBeamingItems(
        for metricalDurationTree: MetricalDurationTree,
        areEqualTo points: [[Rhythm<()>.Beaming.Item.Point]]
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
        let beamCounts = [4]
        assertBeamingItems(for: beamCounts, areEqualTo: [
            [
                .beamlet(direction: .forward),
                .beamlet(direction: .forward),
                .beamlet(direction: .forward),
                .beamlet(direction: .forward)
            ]
        ])
    }

    func testDoubletSameValues() {
        let beamCounts = [3,3]
        assertBeamingItems(for: beamCounts, areEqualTo: [
            [.start, .start, .start],
            [.stop, .stop, .stop]
        ])
    }

    func testDoubletFirstHigher() {
        let beamCounts = [4,1]
        assertBeamingItems(for: beamCounts, areEqualTo: [
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
        let beamCounts = [2,3]
        assertBeamingItems(for: beamCounts, areEqualTo: [
            [.start, .start],
            [.stop, .stop, .beamlet(direction: .backward)]
        ])
    }

    func testTripletSameValues() {
        let beamCounts = [2,2,2]
        assertBeamingItems(for: beamCounts, areEqualTo: [
            [.start, .start],
            [.maintain, .maintain],
            [.stop, .stop]
        ])
    }

    func testTripletLowMidHigh() {
        let beamCounts = [1,2,4]
        assertBeamingItems(for: beamCounts, areEqualTo: [
            [.start],
            [.maintain, .start],
            [.stop, .stop, .beamlet(direction: .backward), .beamlet(direction: .backward)]
        ])
    }

    func testTripletLowHighMid() {
        let beamCounts = [1,3,2]
        assertBeamingItems(for: beamCounts, areEqualTo: [
            [.start],
            [.maintain, .start, .beamlet(direction: .backward)],
            [.stop, .stop]
        ])
    }

    func testTripletMidLowHigh() {
        let beamCounts = [2,1,4]
        assertBeamingItems(for: beamCounts, areEqualTo: [
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
        let beamCounts = [2,3,1]
        assertBeamingItems(for: beamCounts, areEqualTo: [
            [.start, .start],
            [.maintain, .stop, .beamlet(direction: .backward)],
            [.stop]
        ])
    }

    func testLongSequence() {
        let beamCounts = [1,3,2,2,4,3,3,1,3]
        assertBeamingItems(for: beamCounts, areEqualTo: [
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
        let durationTree = 4/>8 * [4,1,1,1,1]
        assertBeamingItems(for: durationTree, areEqualTo: [
            [],
            [.start, .start],
            [.maintain, .maintain],
            [.maintain, .maintain],
            [.stop, .stop]
        ])
    }

    func testOneFourOneOneOne() {
        let durationTree = 4/>8 * [1,4,1,1,1]
        assertBeamingItems(for: durationTree, areEqualTo: [
            [.beamlet(direction: .forward), .beamlet(direction: .forward)],
            [],
            [.start, .start],
            [.maintain, .maintain],
            [.stop, .stop]
        ])
    }

    func testOneOneFourOneOne() {
        let durationTree = 4/>8 * [1,1,4,1,1]
        assertBeamingItems(for: durationTree, areEqualTo: [
            [.start, .start],
            [.stop, .stop],
            [],
            [.start, .start],
            [.stop, .stop]
        ])
    }

    func testOneOneOneFourOne() {
        let durationTree = 4/>8 * [1,1,1,4,1]
        assertBeamingItems(for: durationTree, areEqualTo: [
            [.start, .start],
            [.maintain, .maintain],
            [.stop, .stop],
            [],
            [.beamlet(direction: .backward), .beamlet(direction: .backward)]
        ])
    }

    func testOneOneOneOneFour() {
        let durationTree = 4/>8 * [1,1,1,1,4]
        assertBeamingItems(for: durationTree, areEqualTo: [
            [.start, .start],
            [.maintain, .maintain],
            [.maintain, .maintain],
            [.stop, .stop],
            []
        ])
    }

//    func testInitWithRhythmTree() {
//
//        // Construct actual `RhythmSpelling`
//        let metricalDurationTree = 4/>8 * [1,1,1,1]
//        let metricalContexts: [MetricalContext<Int>] = [
//            .instance(.event(1)),
//            .continuation,
//            .continuation,
//            .instance(.absence)
//        ]
//        let rhythmTree = Rhythm(metricalDurationTree, metricalContexts)
//        let spelling = RhythmSpelling(rhythmTree)
//
//        // Construct expected `RhythmSpelling` components
//        let expectedBeamJunctions: [RhythmSpelling.BeamJunction] = [
//            [.start],
//            [.maintain],
//            [.maintain],
//            [.stop]
//            ].map(Rhythm<()>.Beaming.Item.init)
//        let expectedTieStates: [RhythmSpelling.TieState] = [
//            .start,
//            .maintain,
//            .stop,
//            .none
//        ]
//        let expectedDots = [0,0,0,0]
//        let expectedItems = zip(
//            expectedBeamJunctions,
//            expectedTieStates,
//            expectedDots
//            ).map(RhythmSpelling.Item.init)
//        let expectedContext = Group(duration: 4/>8, contentsSum: 4).context(range: 0...3)
//        let expectedGroups = Grouping.leaf(expectedContext)
//        let expected = RhythmSpelling(items: expectedItems, groups: expectedGroups)
//        XCTAssertEqual(spelling, expected)
//    }
//
//    func testInitWithRhythmTreeDottedValues() {
//
//        // Construct actual `RhythmSpelling`
//        let metricalDurationTree = 2/>8 * [1,2,3,7]
//        let metricalContexts: [MetricalContext<Int>] = [
//            .instance(.event(1)),
//            .continuation,
//            .continuation,
//            .instance(.absence)
//        ]
//        let rhythmTree = Rhythm(metricalDurationTree, metricalContexts)
//        let spelling = RhythmSpelling(rhythmTree)
//
//        // Construct expected `RhythmSpelling` components
//        let expectedBeamJunctions: [RhythmSpelling.BeamJunction] = [
//            [.start, .start, .start, .beamlet(direction: .forward)],
//            [.maintain, .maintain, .maintain],
//            [.maintain, .maintain, .stop],
//            [.stop, .stop]
//            ].map(Rhythm<()>.Beaming.Item.init)
//        let expectedTieStates: [RhythmSpelling.TieState] = [
//            .start,
//            .maintain,
//            .stop,
//            .none
//        ]
//        let expectedDots = [0,0,1,2]
//        let expectedItems = zip(
//            expectedBeamJunctions,
//            expectedTieStates,
//            expectedDots
//            ).map(RhythmSpelling.Item.init)
//        let expectedContext = Group(duration: 2/>8, contentsSum: 13).context(range: 0...3)
//        let expectedGroups: Grouping = .leaf(expectedContext)
//        let expected = RhythmSpelling(items: expectedItems, groups: expectedGroups)
//        XCTAssertEqual(spelling, expected)
//    }

}
