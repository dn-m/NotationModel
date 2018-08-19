//
//  SpelledDyadTests.swift
//  SpelledPitch
//
//  Createsd by James Bean on 8/11/16.
//

import XCTest
import Pitch
import SpelledPitch

class SpelledDyadTests: XCTestCase {

    func testInitSorted() {
        let higher = SpelledPitch<EDO12>(Pitch.Spelling<EDO12>(.c), 4)
        let lower = SpelledPitch<EDO12>(Pitch.Spelling<EDO12>(.a), 3)
        let spelledDyad = SpelledDyad(higher, lower)
        XCTAssertEqual(higher, spelledDyad.higher)
        XCTAssertEqual(lower, spelledDyad.lower)
    }

    func assertUnorderedSpelledInterval(
        for dyad: SpelledDyad<EDO12>,
        equals interval: UnorderedSpelledInterval?
    )
    {
        XCTAssertEqual(dyad.unorderedInterval, interval)
    }

    func assertCompoundSpelledInterval(
        for dyad: SpelledDyad<EDO12>,
        equals interval: CompoundSpelledInterval?
    )
    {
        XCTAssertEqual(dyad.orderedInterval, interval)
    }

    let cflat = SpelledPitch(Pitch.Spelling<EDO12>(.c, .flat(1)), 4)
    let c = SpelledPitch(Pitch.Spelling<EDO12>(.c), 4)
    let ddoubleflat = SpelledPitch(Pitch.Spelling<EDO12>(.d, .flat(2)), 4)
    let dflat = SpelledPitch(Pitch.Spelling<EDO12>(.d, .flat(1)), 4)
    let csharp = SpelledPitch(Pitch.Spelling<EDO12>(.c, .sharp(1)), 4)
    let cdoublesharp = SpelledPitch(Pitch.Spelling<EDO12>(.c, .sharp(2)), 4)
    let dsharp = SpelledPitch(Pitch.Spelling<EDO12>(.d, .sharp(1)), 4)
    let f = SpelledPitch(Pitch.Spelling<EDO12>(.f), 4)
    let fsharp = SpelledPitch(Pitch.Spelling<EDO12>(.f, .sharp(1)), 4)
    let g = SpelledPitch(Pitch.Spelling<EDO12>(.g), 4)
    let gsharp = SpelledPitch(Pitch.Spelling<EDO12>(.g, .sharp(1)), 4)
    let bdoubleflat = SpelledPitch(Pitch.Spelling<EDO12>(.b, .flat(2)), 4)
    let bflat = SpelledPitch(Pitch.Spelling<EDO12>(.b, .flat(1)), 4)
    let gdoublesharp = SpelledPitch(Pitch.Spelling<EDO12>(.g, .sharp(2)), 5)

    func testRelativeNamedIntervalPerfectUnison() {
        let spelledDyad = SpelledDyad(c,c)
        assertUnorderedSpelledInterval(for: spelledDyad, equals: UnorderedSpelledInterval(.perfect, .unison))
    }

    func testRelativeNamedIntervalMinorSecond() {
        assertUnorderedSpelledInterval(for: SpelledDyad(c, dflat), equals: UnorderedSpelledInterval(.minor, .second))
    }

    func testRelativeNamedIntervalAugmentedFourth() {
        assertUnorderedSpelledInterval(
            for: SpelledDyad(c, fsharp),
            equals: UnorderedSpelledInterval(.single, .augmented, .fourth)
        )
    }

    func testRelativeNamedIntervalDiminishedFourth() {
        assertUnorderedSpelledInterval(
            for: SpelledDyad(fsharp, bflat),
            equals: UnorderedSpelledInterval(.single, .diminished, .fourth)
        )
    }

    func testRelativeNamedIntervalDoubleDiminishedFourth() {
        assertUnorderedSpelledInterval(
            for: SpelledDyad(fsharp, bdoubleflat),
            equals: .init(.double, .diminished, .fourth)
        )
    }

    func testRelativeNamedIntervalDiminishedSecond() {
        assertUnorderedSpelledInterval(
            for: SpelledDyad(c, ddoubleflat),
            equals: .init(.diminished, .second)
        )
    }

    func testRelativeNamedIntervalAugmentedSecond() {
        assertUnorderedSpelledInterval(
            for: SpelledDyad(c, dsharp),
            equals: .init(.augmented, .second)
        )
    }

    func testDiminishedThird() {
        assertUnorderedSpelledInterval(
            for: SpelledDyad(dsharp, f),
            equals: .init(.diminished, .third)
        )
    }

    func testRelativeNamedIntervalDoubleDiminishedSecond() {
        assertUnorderedSpelledInterval(
            for: SpelledDyad(csharp, ddoubleflat),
            equals: .init(.double, .diminished, .second)
        )
    }

    func testRelativeNamedIntervalPerfectFourth() {
        assertUnorderedSpelledInterval(for: SpelledDyad(c, g), equals: UnorderedSpelledInterval(.perfect, .fourth))
    }

    func testDoubleAugmentedSixth() {
        assertUnorderedSpelledInterval(
            for: SpelledDyad(bflat, gdoublesharp),
            equals: UnorderedSpelledInterval(.double, .diminished, .third)
        )
    }

    func testTripleAugmentedUnison() {
        assertUnorderedSpelledInterval(
            for: SpelledDyad(cdoublesharp, cflat),
            equals: UnorderedSpelledInterval(.triple, .augmented, .unison)
        )
    }
}
