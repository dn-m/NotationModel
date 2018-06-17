//
//  RhythmSpellingTests.swift
//  RhythmSpellingTools
//
//  Created by James Bean on 2/13/17.
//
//

import XCTest
import DataStructures
import MetricalDuration
import Rhythm
@testable import BeamedRhythm

class RhythmSpellingTests: XCTestCase {
    
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
        let junctions = makeJunctions(beamCounts)
        
        let expectedStates: [RhythmSpelling.BeamJunction.State] = [
            .beamlet(direction: .forward),
            .beamlet(direction: .forward),
            .beamlet(direction: .forward),
            .beamlet(direction: .forward)
        ]
        
        XCTAssertEqual(junctions, [expectedStates].map(RhythmSpelling.BeamJunction.init))
    }
    
    func testDoubletSameValues() {
        
        let beamCounts = [3,3]
        let junctions = makeJunctions(beamCounts)
        
        let expectedStates: [[RhythmSpelling.BeamJunction.State]] = [
            [.start, .start, .start],
            [.stop, .stop, .stop],
        ]
        
        XCTAssertEqual(junctions, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testDoubletFirstHigher() {
        
        let beamCounts = [4,1]
        let junctions = makeJunctions(beamCounts)
        
        let expectedStates: [[RhythmSpelling.BeamJunction.State]] = [
            [
                .start,
                .beamlet(direction: .forward),
                .beamlet(direction: .forward),
                .beamlet(direction: .forward)
            ],
            [
                .stop
            ]
        ]
        
        XCTAssertEqual(junctions, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testDoubletSecondHigher() {
        
        let beamCounts = [2,3]
        let beaming = makeJunctions(beamCounts)
        
        let expectedStates: [[RhythmSpelling.BeamJunction.State]] = [
            [.start, .start],
            [.stop, .stop, .beamlet(direction: .backward)]
        ]
        
        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletSameValues() {
        
        let beamCounts = [2,2,2]
        let beaming = makeJunctions(beamCounts)
        
        let expectedStates: [[RhythmSpelling.BeamJunction.State]] = [
            [.start, .start],
            [.maintain, .maintain],
            [.stop, .stop]
        ]
        
        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletLowMidHigh() {
        
        let beamCounts = [1,2,4]
        let beaming = makeJunctions(beamCounts)
        
        let expectedStates: [[RhythmSpelling.BeamJunction.State]] = [
            [.start],
            [.maintain, .start],
            [.stop, .stop, .beamlet(direction: .backward), .beamlet(direction: .backward)]
        ]
        
        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletLowHighMid() {
        
        let beamCounts = [1,3,2]
        let beaming = makeJunctions(beamCounts)
        
        let expectedStates: [[RhythmSpelling.BeamJunction.State]] = [
            [.start],
            [.maintain, .start, .beamlet(direction: .backward)],
            [.stop, .stop]
        ]

        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletMidLowHigh() {
        
        let beamCounts = [2,1,4]
        let beaming = makeJunctions(beamCounts)
        
        let expectedStates: [[RhythmSpelling.BeamJunction.State]] = [
            [.start, .beamlet(direction: .forward)],
            [.maintain],
            [
                .stop,
                .beamlet(direction: .backward),
                .beamlet(direction: .backward),
                .beamlet(direction: .backward)
            ]
        ]

        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletMidHighLow() {
        
        let beamCounts = [2,3,1]
        let beaming = makeJunctions(beamCounts)
        
        let expectedStates: [[RhythmSpelling.BeamJunction.State]] = [
            [.start, .start],
            [.maintain, .stop, .beamlet(direction: .backward)],
            [.stop]
        ]

        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testLongSequence() {
        
        let beamCounts = [1,3,2,2,4,3,3,1,3]
        let beaming = makeJunctions(beamCounts)
        
        let expectedStates: [[RhythmSpelling.BeamJunction.State]] = [
            [.start], // 1
            [.maintain, .start, .beamlet(direction: .backward)], // 3
            [.maintain, .maintain], // 2
            [.maintain, .maintain], // 2
            [.maintain, .maintain, .start, .beamlet(direction: .backward)], // 4
            [.maintain, .maintain, .maintain], // 3
            [.maintain, .stop, .stop], // 3
            [.maintain], // 1
            [.stop, .beamlet(direction: .backward), .beamlet(direction: .backward)] // 3
        ]
        
        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testMakeJunctionsQuarterNotesHomogenous() {
        let durationTree = 4/>4 * [1,1,1,1]
        let contexts = durationTree.leaves.map { _ in MetricalContext.instance(.event(0)) }
        let rhythmTree = Rhythm(durationTree, contexts)
        let spelling = RhythmSpelling(rhythmTree)
    }
    
    func testMakeJunctionsHeterogenousGreaterAndLessThanQuarterNotes() {
        let durationTree = 4/>8 * [1,1,4,1,1]
        let junctions = makeJunctions(durationTree.leaves)
        
        let expected = [
            [.start, .start],
            [.stop, .stop],
            [],
            [.start, .start],
            [.stop, .stop],
        ].map(RhythmSpelling.BeamJunction.init)
        
        XCTAssertEqual(junctions, expected)
    }
    
    func testMakeJunctionsShiftingHeterogeneousGreaterAndLessThanQuarterNotes() {
        
        let durationTrees = [
            [4,1,1,1,1],
            [1,4,1,1,1],
            [1,1,4,1,1],
            [1,1,1,4,1],
            [1,1,1,1,4]
        ].map { 4/>8 * $0 }
        
        let junctions = durationTrees.map { makeJunctions($0.leaves) }
        
        let expected: [[RhythmSpelling.BeamJunction]] = [
            [
                [],
                [.start, .start],
                [.maintain, .maintain],
                [.maintain, .maintain],
                [.stop, .stop]
            ],
            [
                [.beamlet(direction: .forward), .beamlet(direction: .forward)],
                [],
                [.start, .start],
                [.maintain, .maintain],
                [.stop, .stop]
            ],
            [
                [.start, .start],
                [.stop, .stop],
                [],
                [.start, .start],
                [.stop, .stop]
            ],
            [
                [.start, .start],
                [.maintain, .maintain],
                [.stop, .stop],
                [],
                [.beamlet(direction: .backward), .beamlet(direction: .backward)]
            ],
            [
                [.start, .start],
                [.maintain, .maintain],
                [.maintain, .maintain],
                [.stop, .stop],
                []
            ]
        ].map { $0.map(RhythmSpelling.BeamJunction.init) }

        XCTAssertEqual(junctions, expected)
    }
    
    func testTieStateAllNones() {
        
        let contexts: [MetricalContext<Int>] = [
            .instance(.event(1)),
            .instance(.event(1)),
            .instance(.event(1))
        ]
        
        let expected: [RhythmSpelling.TieState] = [.none, .none, .none]
        
        XCTAssertEqual(makeTieStates(contexts), expected)
    }
    
    func testTieStateCombo() {
        
        let contexts: [MetricalContext<Int>] = [
            .instance(.event(1)),
            .continuation,
            .instance(.absence)
        ]
        
        let expected: [RhythmSpelling.TieState] = [.start, .stop, .none]
        
        XCTAssertEqual(makeTieStates(contexts), expected)
    }
    
    func testTieStatesSequence() {
        
        let contexts: [MetricalContext<Int>] = [
            .instance(.event(1)),
            .instance(.event(1)),
            .continuation,
            .instance(.absence),
            .instance(.event(1)),
            .continuation,
            .continuation,
            .instance(.event(1)),
            .instance(.absence)
        ]
        
        let expected: [RhythmSpelling.TieState] = [
            .none,
            .start,
            .stop,
            .none,
            .start,
            .maintain,
            .stop,
            .none,
            .none
        ]
        
        XCTAssertEqual(makeTieStates(contexts), expected)
    }

    func testInitWithRhythmTree() {

        // Construct actual `RhythmSpelling`
        let metricalDurationTree = 4/>8 * [1,1,1,1]
        let metricalContexts: [MetricalContext<Int>] = [
            .instance(.event(1)),
            .continuation,
            .continuation,
            .instance(.absence)
        ]
        let rhythmTree = Rhythm(metricalDurationTree, metricalContexts)
        let spelling = RhythmSpelling(rhythmTree)

        // Construct expected `RhythmSpelling` components
        let expectedBeamJunctions: [RhythmSpelling.BeamJunction] = [
            [.start],
            [.maintain],
            [.maintain],
            [.stop]
        ].map(RhythmSpelling.BeamJunction.init)
        let expectedTieStates: [RhythmSpelling.TieState] = [
            .start,
            .maintain,
            .stop,
            .none
        ]
        let expectedDots = [0,0,0,0]
        let expectedItems = zip(
            expectedBeamJunctions,
            expectedTieStates,
            expectedDots
        ).map(RhythmSpelling.Item.init)
        let expectedContext = Group(duration: 4/>8, contentsSum: 4).context(range: 0...3)
        let expectedGroups = Grouping.leaf(expectedContext)
        let expected = RhythmSpelling(items: expectedItems, groups: expectedGroups)
        XCTAssertEqual(spelling, expected)
    }
    
//    // FIXME: Not fully implemented
//    func testInitWithRhythmTreeDottedValues() {
//
//        let metricalDurationTree = 2/>8 * [1,2,3,7]
//
//        let metricalContexts: [MetricalContext<Int>] = [
//            .instance(.event(1)),
//            .continuation,
//            .continuation,
//            .instance(.absence)
//        ]
//
//        let rhythmTree = Rhythm(metricalDurationTree, metricalContexts)
//        let spelling = RhythmSpelling(rhythmTree)
//
//        let expectedBeamJunctions: [RhythmSpelling.BeamJunction] = [
//            [.start, .start, .start, .beamlet(direction: .backward)],
//            [.maintain, .maintain, .maintain],
//            [.maintain, .maintain, .stop],
//            [.stop, .stop]
//        ].map(RhythmSpelling.BeamJunction.init)
//
//        let expectedTieStates: [RhythmSpelling.TieState] = [
//            .start,
//            .maintain,
//            .stop,
//            .none
//        ]
//
//        let expectedDots = [0,0,1,2]
//
//        let contexts = zip(
//            expectedBeamJunctions,
//            expectedTieStates,
//            expectedDots
//        ).map(RhythmSpelling.Item.init)
//
//        let context = Group(duration: 4/>8, contentsSum: 4).context(range: 0...8)
//        let groups: Grouping = .leaf(context)
//
//        let expected = RhythmSpelling(items: contexts, groups: groups)
//        XCTAssertEqual(spelling, expected)
//    }

    func testMakeGroups() {
        //let tree = 1/>8 * [1,[[1,[1,1]],[1,[[1,[1,1,1]],[1,[1,1,1]]]]]]
        //let groups = makeGroups(tree)
    }
}
