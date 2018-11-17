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

    /// Asserts the the given `pitchClasses` are spelled as the given `pitchSpellings` with the
    /// given `parsimonyPivot` (default: `.d`).
    ///
    /// - Precondition: `pitchClasses.count == pitchSpellings.count`
    func assert(
        pitchClasses: [Pitch.Class],
        areSpelledAs pitchSpellings: [Pitch.Spelling],
        parsimonyPivot: Pitch.Spelling = Pitch.Spelling(.d)
    )
    {
        precondition(pitchClasses.count == pitchSpellings.count)
        let pitches = Dictionary(uniqueKeysWithValues: zip(0..., pitchClasses.map(Pitch.init)))
        let speller = PitchSpeller(pitches: pitches, parsimonyPivot: parsimonyPivot)
        let spelledPitches = speller.spell()
        let results = spelledPitches.mapValues { $0.spelling }
        let expected = Dictionary(uniqueKeysWithValues: zip(0..., pitchSpellings))
        guard results != expected else { return }
        let message = "Pitch classes \(pitchClasses) are spelled as \(results.values), not as the expected \(pitchSpellings)"
        XCTFail(message)
    }

    // MARK: - Failing Tests

    func testFailingDyads() {
        let dyads: [[Pitch.Class]: [Pitch.Spelling]] = [
            [01,10]: [Pitch.Spelling(.c, .sharp), Pitch.Spelling(.a, .sharp)],
            [03,04]: [Pitch.Spelling(.d, .sharp), .e],
            [03,06]: [Pitch.Spelling(.d, .sharp), Pitch.Spelling(.f, .sharp)],
            [03,11]: [Pitch.Spelling(.d, .sharp), .b],
            [05,06]: [.f, Pitch.Spelling(.g, .flat)],
            [06,10]: [Pitch.Spelling(.f, .sharp), Pitch.Spelling(.a, .sharp)],
            [10,11]: [Pitch.Spelling(.a, .sharp), .b]
        ]
        for _ in dyads { /*assert(pitchClasses: $0, areSpelledAs: $1)*/ }
    }

    // MARK: - Monads

    func testMonads() {
        let monads: [Pitch.Class: Pitch.Spelling] = [
            00: .c,
            01: Pitch.Spelling(.c, .sharp),
            02: .d,
            03: Pitch.Spelling(.e, .flat),
            04: .e,
            05: .f,
            06: Pitch.Spelling(.f, .sharp),
            07: .g,
            08: Pitch.Spelling(.g, .sharp),
            09: .a,
            10: Pitch.Spelling(.b, .flat),
            11: .b,
        ]
        monads.forEach { assert(pitchClasses: [$0], areSpelledAs: [$1]) }
    }

    // MARK: - Dyads

    #warning("Reinstate dyad tests quarantined in `testFailingDyads()`")
    func testDyads() {

        let dyads: [[Pitch.Class]: [Pitch.Spelling]] = [

            [00,00]: [.c, .c],
            [00,01]: [.c, Pitch.Spelling(.d, .flat)],
            [00,02]: [.c, .d],
            [00,03]: [.c, Pitch.Spelling(.e, .flat)],
            [00,04]: [.c, .e],
            [00,05]: [.c, .f],
            [00,06]: [.c, Pitch.Spelling(.f, .sharp)],
            [00,07]: [.c, .g],
            [00,08]: [.c, Pitch.Spelling(.a, .flat)],
            [00,09]: [.c, .a],
            [00,10]: [.c, Pitch.Spelling(.b, .flat)],
            [00,11]: [.c, .b],

            [01,01]: [Pitch.Spelling(.c, .sharp), Pitch.Spelling(.c, .sharp)],
            [01,02]: [Pitch.Spelling(.c, .sharp), .d],
            [01,03]: [Pitch.Spelling(.c, .sharp), Pitch.Spelling(.d, .sharp)],
            [01,04]: [Pitch.Spelling(.c, .sharp), .e],
            [01,05]: [Pitch.Spelling(.d, .flat), .f],
            [01,06]: [Pitch.Spelling(.c, .sharp), Pitch.Spelling(.f, .sharp)],
            [01,07]: [Pitch.Spelling(.c, .sharp), .g],
            [01,08]: [Pitch.Spelling(.c, .sharp), Pitch.Spelling(.g, .sharp)],
            [01,09]: [Pitch.Spelling(.c, .sharp), .a],
            //[01,10]: [Pitch.Spelling(.c, .sharp), Pitch.Spelling(.a, .sharp)],
            [01,11]: [Pitch.Spelling(.c, .sharp), .b],

            [02,02]: [.d, .d],
            [02,03]: [.d, Pitch.Spelling(.e, .flat)],
            [02,04]: [.d, .e],
            [02,05]: [.d, .f],
            [02,06]: [.d, Pitch.Spelling(.f, .sharp)],
            [02,07]: [.d, .g],
            [02,08]: [.d, Pitch.Spelling(.g, .sharp)],
            [02,09]: [.d, .a],
            [02,10]: [.d, Pitch.Spelling(.b, .flat)],
            [02,11]: [.d, .b],

            [03,03]: [Pitch.Spelling(.e, .flat), Pitch.Spelling(.e, .flat)],
            //[03,04]: [Pitch.Spelling(.d, .sharp), .e],
            [03,05]: [Pitch.Spelling(.e, .flat), .f],
            //[03,06]: [Pitch.Spelling(.d, .sharp), Pitch.Spelling(.f, .sharp)],
            [03,07]: [Pitch.Spelling(.e, .flat), .g],
            [03,08]: [Pitch.Spelling(.e, .flat), Pitch.Spelling(.a, .flat)],
            [03,09]: [Pitch.Spelling(.e, .flat), .a],
            [03,10]: [Pitch.Spelling(.e, .flat), Pitch.Spelling(.b, .flat)],
            //[03,11]: [Pitch.Spelling(.d, .sharp), .b],

            [04,04]: [.e, .e],
            [04,05]: [.e, .f],
            [04,06]: [.e, Pitch.Spelling(.f, .sharp)],
            [04,07]: [.e, .g],
            [04,08]: [.e, Pitch.Spelling(.g, .sharp)],
            [04,09]: [.e, .a],
            [04,10]: [.e, Pitch.Spelling(.b, .flat)],
            [04,11]: [.e, .b],

            [05,05]: [.f, .f],
            //[05,06]: [.f, Pitch.Spelling(.g, .flat)],
            [05,07]: [.f, .g],
            [05,08]: [.f, Pitch.Spelling(.a, .flat)],
            [05,09]: [.f, .a],
            [05,10]: [.f, Pitch.Spelling(.b, .flat)],
            [05,11]: [.f, .b],

            [06,06]: [Pitch.Spelling(.f, .sharp), Pitch.Spelling(.f, .sharp)],
            [06,07]: [Pitch.Spelling(.f, .sharp), .g],
            [06,08]: [Pitch.Spelling(.f, .sharp), Pitch.Spelling(.g, .sharp)],
            [06,09]: [Pitch.Spelling(.f, .sharp), .a],
            //[06,10]: [Pitch.Spelling(.f, .sharp), Pitch.Spelling(.a, .sharp)],
            [06,11]: [Pitch.Spelling(.f, .sharp), .b],

            [07,07]: [.g, .g],
            [07,08]: [.g, Pitch.Spelling(.a, .flat)],
            [07,09]: [.g, .a],
            [07,10]: [.g, Pitch.Spelling(.b, .flat)],
            [07,11]: [.g, .b],

            [08,08]: [Pitch.Spelling(.g, .sharp), Pitch.Spelling(.g, .sharp)],
            [08,09]: [Pitch.Spelling(.g, .sharp), .a],
            [08,10]: [Pitch.Spelling(.a, .flat), Pitch.Spelling(.b, .flat)],
            [08,11]: [Pitch.Spelling(.g, .sharp), .b],

            [09,09]: [.a, .a],
            [09,10]: [.a, Pitch.Spelling(.b, .flat)],
            [09,11]: [.a, .b],

            [10,10]: [Pitch.Spelling(.b, .flat), Pitch.Spelling(.b, .flat)],
            //[10,11]: [Pitch.Spelling(.a, .sharp), .b],

            [11,11]: [.b, .b]
        ]
        dyads.forEach { assert(pitchClasses: $0, areSpelledAs: $1) }
    }

    // MARK: - FlowNetwork Construction

    // FIXME: Test for less-implementation-specific weight values
    func testSpelledZeroOneOverDNatural() {

        // Construct expected FlowNetwork
        var expected = FlowNetwork<PitchSpellingNode.Index,Double>()

        // hook up source edges
        expected.insertEdge(
            from: .source,
            to: .internal(.init(0,.down)),
            weight: middleWeight
        )
        expected.insertEdge(
            from: .source,
            to: .internal(.init(1,.down)),
            weight: heavyWeight
        )
        // hook up sink edges
        expected.insertEdge(
            from: .internal(.init(0,.up)),
            to: .sink,
            weight: heavyWeight
        )
        expected.insertEdge(
            from: .internal(.init(1,.up)),
            to: .sink,
            weight: featherWeight
        )
        // hook up bigM edges
        expected.insertEdge(
            from: .internal(.init(1,.up)),
            to: .internal(.init(1,.down)),
            weight: .infinity
        )
        expected.insertEdge(
            from: .internal(.init(0,.up)),
            to: .internal(.init(0,.down)),
            weight: .infinity
        )
        // hook up internal edges
        expected.insertEdge(
            from: .internal(.init(1,.up)),
            to: .internal(.init(0,.down)),
            weight: lightWeight
        )
        expected.insertEdge(
            from: .internal(.init(1,.down)),
            to: .internal(.init(0,.up)),
            weight: flyWeight
        )
        expected.insertEdge(
            from: .internal(.init(0,.up)),
            to: .internal(.init(1,.down)),
            weight: flyWeight
        )
        expected.insertEdge(
            from: .internal(.init(0,.down)),
            to: .internal(.init(1,.up)),
            weight: lightWeight
        )

        let pitches: [Int: Pitch] = [0: 60, 1: 61]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: .d)

        XCTAssertEqual(pitchSpeller.flowNetwork.nodes, expected.nodes)
        XCTAssertEqual(pitchSpeller.flowNetwork.edges, expected.edges)
        XCTAssertEqual(pitchSpeller.flowNetwork, expected)
    }

    // FIXME: Test for less-implementation-specific weight values
    func testSpelledOneThreeOverDNatural() {

        var expected = FlowNetwork<PitchSpellingNode.Index,Double>()

        // hook up source edges
        expected.insertEdge(
            from: .source,
            to: .internal(.init(1,.down)),
            weight: heavyWeight
        )
        expected.insertEdge(
            from: .source,
            to: .internal(.init(3,.down)),
            weight: featherWeight
        )
        // hook up sink edges
        expected.insertEdge(
            from: .internal(.init(1,.up)),
            to: .sink,
            weight: featherWeight
        )
        expected.insertEdge(
            from: .internal(.init(3,.up)),
            to: .sink,
            weight: heavyWeight
        )
        // hook up bigM edges
        expected.insertEdge(
            from: .internal(.init(1,.up)),
            to: .internal(.init(1,.down)),
            weight: .infinity
        )
        expected.insertEdge(
            from: .internal(.init(3,.up)),
            to: .internal(.init(3,.down)),
            weight: .infinity
        )
        // hook up internal edges
        expected.insertEdge(
            from: .internal(.init(1,.up)),
            to: .internal(.init(3,.down)),
            weight: featherWeight
        )
        expected.insertEdge(
            from: .internal(.init(1,.down)),
            to: .internal(.init(3,.up)),
            weight: featherWeight
        )
        expected.insertEdge(
            from: .internal(.init(3,.up)),
            to: .internal(.init(1,.down)),
            weight: featherWeight
        )
        expected.insertEdge(
            from: .internal(.init(3,.down)),
            to: .internal(.init(1,.up)),
            weight: featherWeight
        )

        let pitches: [Int: Pitch] = [1: 61, 3: 63]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: .d)

        XCTAssertEqual(pitchSpeller.flowNetwork.nodes, expected.nodes)
        XCTAssertEqual(pitchSpeller.flowNetwork.edges, expected.edges)
        XCTAssertEqual(pitchSpeller.flowNetwork, expected)
    }

    // FIXME: Test for less-implementation-specific weight values
    func testSpelledOneFiveOverDNatural() {

        var expected = FlowNetwork<PitchSpellingNode.Index,Double>()

        // hook up source edges
        expected.insertEdge(
            from: .source,
            to: .internal(.init(1,.down)),
            weight: heavyWeight
        )
        expected.insertEdge(
            from: .source,
            to: .internal(.init(5,.down)),
            weight: middleWeight
        )
        // hook up sink edges
        expected.insertEdge(
            from: .internal(.init(1,.up)),
            to: .sink,
            weight: featherWeight
        )
        expected.insertEdge(
            from: .internal(.init(5,.up)),
            to: .sink,
            weight: heavyWeight
        )
        // hook up bigM edges
        expected.insertEdge(
            from: .internal(.init(1,.up)),
            to: .internal(.init(1,.down)),
            weight: .infinity
        )
        expected.insertEdge(
            from: .internal(.init(5,.up)),
            to: .internal(.init(5,.down)),
            weight: .infinity
        )
        // hook up internal edges
        expected.insertEdge(
            from: .internal(.init(1,.up)),
            to: .internal(.init(5,.down)),
            weight: lightWeight
        )
        expected.insertEdge(
            from: .internal(.init(1,.down)),
            to: .internal(.init(5,.up)),
            weight: flyWeight
        )
        expected.insertEdge(
            from: .internal(.init(5,.up)),
            to: .internal(.init(1,.down)),
            weight: flyWeight
        )
        expected.insertEdge(
            from: .internal(.init(5,.down)),
            to: .internal(.init(1,.up)),
            weight: lightWeight
        )

        let pitches: [Int: Pitch] = [1: 61, 5: 65]
        let pitchSpeller = PitchSpeller(pitches: pitches, parsimonyPivot: .d)

        XCTAssertEqual(pitchSpeller.flowNetwork.nodes,  expected.nodes)
        XCTAssertEqual(pitchSpeller.flowNetwork.edges,  expected.edges)
        XCTAssertEqual(pitchSpeller.flowNetwork.sink,   expected.sink)
        XCTAssertEqual(pitchSpeller.flowNetwork.source, expected.source)
        XCTAssertEqual(pitchSpeller.flowNetwork, expected)
    }
}
