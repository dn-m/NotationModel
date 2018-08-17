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

    func assertNamedUnorderedInterval(
        for dyad: SpelledDyad,
        equals interval: UnorderedSpelledInterval?
    )
    {
        XCTAssertEqual(dyad.unorderedInterval, interval)
    }

    func assertNamedOrderedInterval(
        for dyad: SpelledDyad,
        equals interval: NamedOrderedInterval?
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
        assertNamedUnorderedInterval(for: spelledDyad, equals: UnorderedSpelledInterval(.perfect, .unison))
    }

    func testRelativeNamedIntervalMinorSecond() {
        assertNamedUnorderedInterval(for: SpelledDyad(c, dflat), equals: UnorderedSpelledInterval(.minor, .second))
    }

    func testRelativeNamedIntervalAugmentedFourth() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(c, fsharp),
            equals: UnorderedSpelledInterval(.single, .augmented, .fourth)
        )
    }

    func testRelativeNamedIntervalDiminishedFourth() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(fsharp, bflat),
            equals: UnorderedSpelledInterval(.single, .diminished, .fourth)
        )
    }

    func testRelativeNamedIntervalDoubleDiminishedFourth() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(fsharp, bdoubleflat),
            equals: .init(.double, .diminished, .fourth)
        )
    }

    func testRelativeNamedIntervalDiminishedSecond() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(c, ddoubleflat),
            equals: .init(.diminished, .second)
        )
    }

    func testRelativeNamedIntervalAugmentedSecond() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(c, dsharp),
            equals: .init(.augmented, .second)
        )
    }

    func testDiminishedThird() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(dsharp, f),
            equals: .init(.diminished, .third)
        )
    }

    func testRelativeNamedIntervalDoubleDiminishedSecond() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(csharp, ddoubleflat),
            equals: .init(.double, .diminished, .second)
        )
    }

    func testRelativeNamedIntervalPerfectFourth() {
        assertNamedUnorderedInterval(for: SpelledDyad(c, g), equals: UnorderedSpelledInterval(.perfect, .fourth))
    }

    func testDoubleAugmentedSixth() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(bflat, gdoublesharp),
            equals: UnorderedSpelledInterval(.double, .diminished, .third)
        )
    }

    func testTripleAugmentedUnison() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(cdoublesharp, cflat),
            equals: UnorderedSpelledInterval(.triple, .augmented, .unison)
        )
    }
}
