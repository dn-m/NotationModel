//
//  PitchSpellerTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 10/16/18.
//

import XCTest
import DataStructures
import Pitch
@testable import SpelledPitch

class PitchSpellerTests: XCTestCase {

    // MARK: - Monads

    func testSpellZeroOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 60], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.c))]
        XCTAssertEqual(result, expected)
    }

    func testSpellOneOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 61], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.c, .sharp))]
        XCTAssertEqual(result, expected)
    }

    func testSpellTwoOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 62], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.d))]
        XCTAssertEqual(result, expected)
    }

    func testSpellThreeOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 63], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.e, .flat))]
        XCTAssertEqual(result, expected)
    }

    func testSpellFourOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 64], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.e))]
        XCTAssertEqual(result, expected)
    }

    func testSpellFiveOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 65], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.f))]
        XCTAssertEqual(result, expected)
    }

    func testSpellSixOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 66], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.f, .sharp))]
        XCTAssertEqual(result, expected)
    }

    func testSpellSevenOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 67], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.g))]
        XCTAssertEqual(result, expected)
    }

    func testSpellNineOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 69], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.a))]
        XCTAssertEqual(result, expected)
    }

    func testSpellTenOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 70], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.b, .flat))]
        XCTAssertEqual(result, expected)
    }

    func testSpellElevenOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 71], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.b))]
        XCTAssertEqual(result, expected)
    }
    
    func testSpellEightOverCNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 68], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.g, .sharp))]
        XCTAssertEqual(result, expected)
    }
    

    // MARK: - Dyads

    func testSpelledZeroOneOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 61]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let expectedGraph = WeightedDirectedGraph<PitchSpellingNode.Index,Double> (Set([
            .internal(.init(0,.down)),
            .internal(.init(0,.up)),
            .internal(.init(1,.down)),
            .internal(.init(1,.up)),
            .source,
            .sink]), [
                
            // source edges
            .init(.source,                  .internal(.init(0,.down))): 2,
            .init(.source,                  .internal(.init(1,.down))): 3,
            
            //sink edges
            .init(.internal(.init(0,  .up)),                    .sink): 3,
            .init(.internal(.init(1,  .up)),                    .sink): 1,
            
            // bigM edges
            .init(.internal(.init(1,  .up)),.internal(.init(1,.down))): Double.infinity,
            .init(.internal(.init(0,  .up)),.internal(.init(0,.down))): Double.infinity,
            
            // internal edges
            .init(.internal(.init(1,  .up)),.internal(.init(0,.down))): 1.5,
            .init(.internal(.init(1,.down)),.internal(.init(0,  .up))): 0.5,
            .init(.internal(.init(0,  .up)),.internal(.init(1,.down))): 0.5,
            .init(.internal(.init(0,.down)),.internal(.init(1,  .up))): 1.5,
            ]
        )
        let expectedFlowNetwork = FlowNetwork<PitchSpellingNode.Index,Double> (
            expectedGraph, source: .source, sink: .sink
        )
        XCTAssertEqual(pitchSpeller.flowNetwork.nodes, expectedFlowNetwork.nodes)
        XCTAssertEqual(pitchSpeller.flowNetwork.edges, expectedFlowNetwork.edges)
        XCTAssertEqual(pitchSpeller.flowNetwork, expectedFlowNetwork)

        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.d, .flat), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroTwoOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 62]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.d), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroThreeOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 63]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.e, .flat), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroFourOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 64]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.e), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroFiveOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 65]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.f), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroSixOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 66]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.f, .sharp), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroSevenOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 67]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.g), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroEightOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 68]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.a, .flat), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroNineOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 69]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.a), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroTenOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 70]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.b, .flat), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledZeroElevenOverDNatural() {
        let pitches: [Int: Pitch] = [0: 60, 1: 71]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c), 4),
            1: SpelledPitch(Pitch.Spelling(.b), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledOneTwoOverDNatural() {
        let pitches: [Int: Pitch] = [0: 61, 1: 62]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c, .sharp), 4),
            1: SpelledPitch(Pitch.Spelling(.d), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledOneThreeOverDNatural() {
        let pitches: [Int: Pitch] = [1: 61, 3: 63]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let expectedGraph = WeightedDirectedGraph<PitchSpellingNode.Index,Double> (Set([
            .internal(.init(1,.down)),
            .internal(.init(1,.up)),
            .internal(.init(3,.down)),
            .internal(.init(3,.up)),
            .source,
            .sink]), [
                
                // source edges
                .init(.source,                  .internal(.init(1,.down))): 3,
                .init(.source,                  .internal(.init(3,.down))): 1,
                
                //sink edges
                .init(.internal(.init(1,  .up)),                    .sink): 1,
                .init(.internal(.init(3,  .up)),                    .sink): 3,
                
                // bigM edges
                .init(.internal(.init(1,  .up)),.internal(.init(1,.down))): Double.infinity,
                .init(.internal(.init(3,  .up)),.internal(.init(3,.down))): Double.infinity,
                
                // internal edges
                .init(.internal(.init(1,  .up)),.internal(.init(3,.down))): 1,
                .init(.internal(.init(1,.down)),.internal(.init(3,  .up))): 1,
                .init(.internal(.init(3,  .up)),.internal(.init(1,.down))): 1,
                .init(.internal(.init(3,.down)),.internal(.init(1,  .up))): 1,
                ]
        )
        let expectedFlowNetwork = FlowNetwork<PitchSpellingNode.Index,Double> (
            expectedGraph, source: .source, sink: .sink
        )
        XCTAssertEqual(pitchSpeller.flowNetwork.nodes, expectedFlowNetwork.nodes)
        XCTAssertEqual(pitchSpeller.flowNetwork.edges, expectedFlowNetwork.edges)
        XCTAssertEqual(pitchSpeller.flowNetwork, expectedFlowNetwork)
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            1: SpelledPitch(Pitch.Spelling(.c, .sharp), 4),
            3: SpelledPitch(Pitch.Spelling(.d, .sharp), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledOneFourOverDNatural() {
        let pitches: [Int: Pitch] = [0: 61, 1: 64]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            0: SpelledPitch(Pitch.Spelling(.c, .sharp), 4),
            1: SpelledPitch(Pitch.Spelling(.e), 4)
        ]
        XCTAssertEqual(result, expected)
    }

    func testSpelledOneFiveOverDNatural() {
        let pitches: [Int: Pitch] = [1: 61, 5: 65]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: Pitch.Spelling(.d))
        let expectedGraph = WeightedDirectedGraph<PitchSpellingNode.Index,Double> (Set([
            .internal(.init(1,.down)),
            .internal(.init(1,.up)),
            .internal(.init(5,.down)),
            .internal(.init(5,.up)),
            .source,
            .sink]), [
                
                // source edges
                .init(.source,                  .internal(.init(1,.down))): 3,
                .init(.source,                  .internal(.init(5,.down))): 2,
                
                //sink edges
                .init(.internal(.init(1,  .up)),                    .sink): 1,
                .init(.internal(.init(5,  .up)),                    .sink): 3,
                
                // bigM edges
                .init(.internal(.init(1,  .up)),.internal(.init(1,.down))): Double.infinity,
                .init(.internal(.init(5,  .up)),.internal(.init(5,.down))): Double.infinity,
                
                // internal edges
                .init(.internal(.init(1,  .up)),.internal(.init(5,.down))): 1.5,
                .init(.internal(.init(1,.down)),.internal(.init(5,  .up))): 0.5,
                .init(.internal(.init(5,  .up)),.internal(.init(1,.down))): 0.5,
                .init(.internal(.init(5,.down)),.internal(.init(1,  .up))): 1.5,
                ]
        )
        let expectedFlowNetwork = FlowNetwork<PitchSpellingNode.Index,Double> (
            expectedGraph, source: .source, sink: .sink
        )
        XCTAssertEqual(pitchSpeller.flowNetwork.nodes,  expectedFlowNetwork.nodes)
        XCTAssertEqual(pitchSpeller.flowNetwork.edges,  expectedFlowNetwork.edges)
        XCTAssertEqual(pitchSpeller.flowNetwork.sink,   expectedFlowNetwork.sink)
        XCTAssertEqual(pitchSpeller.flowNetwork.source, expectedFlowNetwork.source)
        XCTAssertEqual(pitchSpeller.flowNetwork, expectedFlowNetwork)
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [
            1: SpelledPitch(Pitch.Spelling(.d, .flat), 4),
            5: SpelledPitch(Pitch.Spelling(.f), 4)
        ]
        XCTAssertEqual(result, expected)
    }
}
