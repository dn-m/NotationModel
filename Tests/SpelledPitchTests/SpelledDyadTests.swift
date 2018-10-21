//
//  SpelledDyadTests.swift
//  SpelledPitch
//
//  Created by James Bean on 8/11/16.
//

import XCTest
import Pitch
import SpelledPitch

class SpelledDyadTests: XCTestCase {

    func testInitSorted() {
        let higher = SpelledPitch(Pitch.Spelling(.c), 4)
        let lower = SpelledPitch(Pitch.Spelling(.a), 3)
        let spelledDyad = SpelledDyad(higher, lower)
        XCTAssertEqual(higher, spelledDyad.higher)
        XCTAssertEqual(lower, spelledDyad.lower)
    }

    func assertUnorderedIntervalDescriptor(
        for dyad: SpelledDyad,
        equals interval: UnorderedIntervalDescriptor?
    )
    {
        XCTAssertEqual(dyad.unorderedInterval, interval)
    }

    func assertCompoundIntervalDescriptor(
        for dyad: SpelledDyad,
        equals interval: CompoundIntervalDescriptor?
    )
    {
        XCTAssertEqual(dyad.orderedInterval, interval)
    }

    let cflat = SpelledPitch(Pitch.Spelling(.c, .flat), 4)
    let c = SpelledPitch(Pitch.Spelling(.c), 4)
    let ddoubleflat = SpelledPitch(Pitch.Spelling(.d, .doubleFlat), 4)
    let dflat = SpelledPitch(Pitch.Spelling(.d, .flat), 4)
    let csharp = SpelledPitch(Pitch.Spelling(.c, .sharp), 4)
    let cdoublesharp = SpelledPitch(Pitch.Spelling(.c, .doubleSharp), 4)
    let dsharp = SpelledPitch(Pitch.Spelling(.d, .sharp), 4)
    let f = SpelledPitch(Pitch.Spelling(.f), 4)
    let fsharp = SpelledPitch(Pitch.Spelling(.f, .sharp), 4)
    let g = SpelledPitch(Pitch.Spelling(.g), 4)
    let gsharp = SpelledPitch(Pitch.Spelling(.g, .sharp), 4)
    let bdoubleflat = SpelledPitch(Pitch.Spelling(.b, .doubleFlat), 4)
    let bflat = SpelledPitch(Pitch.Spelling(.b, .flat), 4)
    let gdoublesharp = SpelledPitch(Pitch.Spelling(.g, .doubleSharp), 5)

    func testRelativeNamedIntervalPerfectUnison() {
        let spelledDyad = SpelledDyad(c,c)
        assertUnorderedIntervalDescriptor(for: spelledDyad, equals: UnorderedIntervalDescriptor(.perfect, .unison))
    }

    func testRelativeNamedIntervalMinorSecond() {
        assertUnorderedIntervalDescriptor(for: SpelledDyad(c, dflat), equals: UnorderedIntervalDescriptor(.minor, .second))
    }

    func testRelativeNamedIntervalAugmentedFourth() {
        assertUnorderedIntervalDescriptor(
            for: SpelledDyad(c, fsharp),
            equals: UnorderedIntervalDescriptor(.single, .augmented, .fourth)
        )
    }

    func testRelativeNamedIntervalDiminishedFourth() {
        assertUnorderedIntervalDescriptor(
            for: SpelledDyad(fsharp, bflat),
            equals: UnorderedIntervalDescriptor(.single, .diminished, .fourth)
        )
    }

    func testRelativeNamedIntervalDoubleDiminishedFourth() {
        assertUnorderedIntervalDescriptor(
            for: SpelledDyad(fsharp, bdoubleflat),
            equals: .init(.double, .diminished, .fourth)
        )
    }

    func testRelativeNamedIntervalDiminishedSecond() {
        assertUnorderedIntervalDescriptor(
            for: SpelledDyad(c, ddoubleflat),
            equals: .init(.diminished, .second)
        )
    }

    func testRelativeNamedIntervalAugmentedSecond() {
        assertUnorderedIntervalDescriptor(
            for: SpelledDyad(c, dsharp),
            equals: .init(.augmented, .second)
        )
    }

    func testDiminishedThird() {
        assertUnorderedIntervalDescriptor(
            for: SpelledDyad(dsharp, f),
            equals: .init(.diminished, .third)
        )
    }

    func testRelativeNamedIntervalDoubleDiminishedSecond() {
        assertUnorderedIntervalDescriptor(
            for: SpelledDyad(csharp, ddoubleflat),
            equals: .init(.double, .diminished, .second)
        )
    }

    func testRelativeNamedIntervalPerfectFourth() {
        assertUnorderedIntervalDescriptor(for: SpelledDyad(c, g), equals: UnorderedIntervalDescriptor(.perfect, .fourth))
    }

    func testDoubleAugmentedSixth() {
        assertUnorderedIntervalDescriptor(
            for: SpelledDyad(bflat, gdoublesharp),
            equals: UnorderedIntervalDescriptor(.double, .diminished, .third)
        )
    }

    func testTripleAugmentedUnison() {
        assertUnorderedIntervalDescriptor(
            for: SpelledDyad(cdoublesharp, cflat),
            equals: UnorderedIntervalDescriptor(.triple, .augmented, .unison)
        )
    }
}
