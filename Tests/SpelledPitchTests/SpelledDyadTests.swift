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
        let higher = SpelledPitch(60, Pitch.Spelling(.c))
        let lower = SpelledPitch(57, Pitch.Spelling(.a))
        let spelledDyad = SpelledDyad(higher, lower)
        XCTAssertEqual(higher, spelledDyad.higher)
        XCTAssertEqual(lower, spelledDyad.lower)
    }

    func assertNamedUnorderedInterval(
        for dyad: SpelledDyad,
        equals interval: NamedUnorderedInterval?
    )
    {
        XCTAssertEqual(dyad.relativeInterval, interval)
    }

    func assertNamedOrderedInterval(
        for dyad: SpelledDyad,
        equals interval: NamedOrderedInterval?
    )
    {
        XCTAssertEqual(dyad.absoluteInterval, interval)
    }

    let cflat = SpelledPitch(59, Pitch.Spelling(.c, .flat))
    let c = SpelledPitch(60, Pitch.Spelling(.c))
    let ddoubleflat = SpelledPitch(60, Pitch.Spelling(.d, .doubleFlat))
    let dflat = SpelledPitch(61, Pitch.Spelling(.d, .flat))
    let csharp = SpelledPitch(61, Pitch.Spelling(.c, .sharp))
    let cdoublesharp = SpelledPitch(62, Pitch.Spelling(.c, .doubleSharp))
    let dsharp = SpelledPitch(63, Pitch.Spelling(.d, .sharp))
    let f = SpelledPitch(65, Pitch.Spelling(.f))
    let fsharp = SpelledPitch(66, Pitch.Spelling(.f, .sharp))
    let g = SpelledPitch(67, Pitch.Spelling(.g))
    let gsharp = SpelledPitch(68, Pitch.Spelling(.g, .sharp))
    let bdoubleflat = SpelledPitch(69, Pitch.Spelling(.b, .doubleFlat))
    let bflat = SpelledPitch(70, Pitch.Spelling(.b, .flat))
    let gdoublesharp = SpelledPitch(81, Pitch.Spelling(.g, .doubleSharp))

    func testRelativeNamedIntervalPerfectUnison() {
        let spelledDyad = SpelledDyad(c,c)
        assertNamedUnorderedInterval(for: spelledDyad, equals: NamedUnorderedInterval(.perfect, .unison))
    }

    func testRelativeNamedIntervalMinorSecond() {
        assertNamedUnorderedInterval(for: SpelledDyad(c, dflat), equals: NamedUnorderedInterval(.minor, .second))
    }

    func testRelativeNamedIntervalAugmentedFourth() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(c, fsharp),
            equals: NamedUnorderedInterval(.single, .augmented, .fourth)
        )
    }

    func testRelativeNamedIntervalDiminishedFourth() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(fsharp, bflat),
            equals: NamedUnorderedInterval(.single, .diminished, .fourth)
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
        assertNamedUnorderedInterval(for: SpelledDyad(c, g), equals: NamedUnorderedInterval(.perfect, .fourth))
    }

    func testDoubleAugmentedSixth() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(bflat, gdoublesharp),
            equals: NamedUnorderedInterval(.double, .diminished, .third)
        )
    }

    func testTripleAugmentedUnison() {
        assertNamedUnorderedInterval(
            for: SpelledDyad(cdoublesharp, cflat),
            equals: NamedUnorderedInterval(.triple, .augmented, .unison)
        )
    }
}
