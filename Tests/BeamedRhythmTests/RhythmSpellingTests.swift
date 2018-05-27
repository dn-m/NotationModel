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
        
        let values = [4]
        let junctions = makeJunctions(values)
        
        let expectedStates: [Int: RhythmSpelling.BeamJunction.State] = [
            1: .beamlet(direction: .forward),
            2: .beamlet(direction: .forward),
            3: .beamlet(direction: .forward),
            4: .beamlet(direction: .forward)
        ]
        
        XCTAssertEqual(junctions, [expectedStates].map(RhythmSpelling.BeamJunction.init))
    }
    
    func testDoubletSameValues() {
        
        let values = [3,3]
        let junctions = makeJunctions(values)
        
        let expectedStates: [[Int: RhythmSpelling.BeamJunction.State]] = [
            [1: .start, 2: .start, 3: .start],
            [1: .stop, 2: .stop, 3: .stop],
        ]
        
        XCTAssertEqual(junctions, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testDoubletFirstHigher() {
        
        let values = [4,1]
        let junctions = makeJunctions(values)
        
        let expectedStates: [[Int: RhythmSpelling.BeamJunction.State]] = [
            [
                1: .start,
                2: .beamlet(direction: .forward),
                3: .beamlet(direction: .forward),
                4: .beamlet(direction: .forward)
            ],
            [
                1: .stop
            ]
        ]
        
        XCTAssertEqual(junctions, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testDoubletSecondHigher() {
        
        let values = [2,3]
        let beaming = makeJunctions(values)
        
        let expectedStates: [[Int: RhythmSpelling.BeamJunction.State]] = [
            [1: .start, 2: .start],
            [1: .stop, 2: .stop, 3: .beamlet(direction: .backward)]
        ]
        
        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletSameValues() {
        
        let values = [2,2,2]
        let beaming = makeJunctions(values)
        
        let expectedStates: [[Int: RhythmSpelling.BeamJunction.State]] = [
            [1: .start, 2: .start],
            [1: .maintain, 2: .maintain],
            [1: .stop, 2: .stop]
        ]
        
        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletLowMidHigh() {
        
        let values = [1,2,4]
        let beaming = makeJunctions(values)
        
        let expectedStates: [[Int: RhythmSpelling.BeamJunction.State]] = [
            [1: .start],
            [1: .maintain, 2: .start],
            [1: .stop, 2: .stop, 3: .beamlet(direction: .backward), 4: .beamlet(direction: .backward)]
        ]
        
        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletLowHighMid() {
        
        let values = [1,3,2]
        let beaming = makeJunctions(values)
        
        let expectedStates: [[Int: RhythmSpelling.BeamJunction.State]] = [
            [1: .start],
            [1: .maintain, 2: .start, 3: .beamlet(direction: .backward)],
            [1: .stop, 2: .stop]
        ]

        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletMidLowHigh() {
        
        let values = [2,1,4]
        let beaming = makeJunctions(values)
        
        let expectedStates: [[Int: RhythmSpelling.BeamJunction.State]] = [
            [1: .start, 2: .beamlet(direction: .forward)],
            [1: .maintain],
            [
                1: .stop,
                2: .beamlet(direction: .backward),
                3: .beamlet(direction: .backward),
                4: .beamlet(direction: .backward)
            ]
        ]

        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testTripletMidHighLow() {
        
        let values = [2,3,1]
        let beaming = makeJunctions(values)
        
        let expectedStates: [[Int: RhythmSpelling.BeamJunction.State]] = [
            [1: .start, 2: .start],
            [1: .maintain, 2: .stop, 3: .beamlet(direction: .backward)],
            [1: .stop]
        ]

        XCTAssertEqual(beaming, expectedStates.map(RhythmSpelling.BeamJunction.init))
    }
    
    func testLongSequence() {
        
        let values = [1,3,2,2,4,3,3,1,3]
        let beaming = makeJunctions(values)
        
        let expectedStates: [[Int: RhythmSpelling.BeamJunction.State]] = [
            [1: .start], // 1
            [1: .maintain, 2: .start, 3: .beamlet(direction: .backward)], // 3
            [1: .maintain, 2: .maintain], // 2
            [1: .maintain, 2: .maintain], // 2
            [1: .maintain, 2: .maintain, 3: .start, 4: .beamlet(direction: .backward)], // 4
            [1: .maintain, 2: .maintain, 3: .maintain], // 3
            [1: .maintain, 2: .stop, 3: .stop], // 3
            [1: .maintain], // 1
            [1: .stop, 2: .beamlet(direction: .backward), 3: .beamlet(direction: .backward)] // 3
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
            [1: .start, 2: .start],
            [1: .stop, 2: .stop],
            [:],
            [1: .start, 2: .start],
            [1: .stop, 2: .stop],
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
        
        let expected = [
            [
                [:],
                [1: .start, 2: .start],
                [1: .maintain, 2: .maintain],
                [1: .maintain, 2: .maintain],
                [1: .stop, 2: .stop]
            ],
            [
                [1: .beamlet(direction: .forward), 2: .beamlet(direction: .forward)],
                [:],
                [1: .start, 2: .start],
                [1: .maintain, 2: .maintain],
                [1: .stop, 2: .stop]
            ],
            [
                [1: .start, 2: .start],
                [1: .stop, 2: .stop],
                [:],
                [1: .start, 2: .start],
                [1: .stop, 2: .stop]
            ],
            [
                [1: .start, 2: .start],
                [1: .maintain, 2: .maintain],
                [1: .stop, 2: .stop],
                [:],
                [1: .beamlet(direction: .backward), 2: .beamlet(direction: .backward)]
            ],
            [
                [1: .start, 2: .start],
                [1: .maintain, 2: .maintain],
                [1: .maintain, 2: .maintain],
                [1: .stop, 2: .stop],
                [:]
            ]
        ].map { $0.map(RhythmSpelling.BeamJunction.init) }
        
        zip(junctions, expected).forEach { a,b in
            XCTAssertEqual(a,b)
        }
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
    
//    // FIXME: Groups not yet equatable
//    func testInitWithRhythmTree() {
//        
//        let metricalDurationTree = 4/>8 * [1,1,1,1]
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
//            [1: .start],
//            [1: .maintain],
//            [1: .maintain],
//            [1: .stop]
//        ].map(RhythmSpelling.BeamJunction.init)
//        
//        let expectedTieStates: [RhythmSpelling.TieState] = [
//            .start,
//            .maintain,
//            .stop,
//            .none
//        ]
//        
//        let expectedDots = [0,0,0,0]
//        
//        let items = zip(
//            expectedBeamJunctions,
//            expectedTieStates,
//            expectedDots
//        ).map(RhythmSpelling.Item.init)
//        
//        // Groups not yet equatable
//        let context = Group(duration: 4/>8, contentsSum: 4).context(range: 0...8)
//        let groups = Grouping.leaf(context)
//        let expected = RhythmSpelling(items: items, groups: groups)
//        
//        XCTAssertEqual(spelling, expected)
//    }
    
    // FIXME: Not fully implemented
    func testInitWithRhythmTreeDottedValues() {
        
        let metricalDurationTree = 2/>8 * [1,2,3,7]
        
        let metricalContexts: [MetricalContext<Int>] = [
            .instance(.event(1)),
            .continuation,
            .continuation,
            .instance(.absence)
        ]
        
        let rhythmTree = Rhythm(metricalDurationTree, metricalContexts)
        let spelling = RhythmSpelling(rhythmTree)
        
        let expectedBeamJunctions: [RhythmSpelling.BeamJunction] = [
            [1: .start, 2: .start, 3: .start, 4: .beamlet(direction: .backward)],
            [1: .maintain, 2: .maintain, 3: .maintain],
            [1: .maintain, 2: .maintain, 3: .stop],
            [1: .stop, 2: .stop]
        ].map(RhythmSpelling.BeamJunction.init)
        
        let expectedTieStates: [RhythmSpelling.TieState] = [
            .start,
            .maintain,
            .stop,
            .none
        ]
        
        let expectedDots = [0,0,1,2]
        
        let contexts = zip(
            expectedBeamJunctions,
            expectedTieStates,
            expectedDots
        ).map(RhythmSpelling.Item.init)
        
        let context = Group(duration: 4/>8, contentsSum: 4).context(range: 0...8)
        let groups: Grouping = .leaf(context)
        
        //let expected = RhythmSpelling(contexts: contexts, groups: [])
        //XCTAssertEqual(spelling, expected)
    }
    
    func testMakeGroups() {
        //let tree = 1/>8 * [1,[[1,[1,1]],[1,[[1,[1,1,1]],[1,[1,1,1]]]]]]
        //let groups = makeGroups(tree)
    }
}
