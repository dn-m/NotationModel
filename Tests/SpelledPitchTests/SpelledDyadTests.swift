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
        let higher = SpelledPitch<EDO12>(Pitch.Spelling<EDO12>(.c), 4)
        let lower = SpelledPitch<EDO12>(Pitch.Spelling<EDO12>(.a), 3)
        let spelledDyad = SpelledDyad(higher, lower)
        XCTAssertEqual(higher, spelledDyad.higher)
        XCTAssertEqual(lower, spelledDyad.lower)
    }

    func assertUnorderedIntervalDescriptor(
        for dyad: SpelledDyad<EDO12>,
        equals interval: UnorderedIntervalDescriptor?
    )
    {
        XCTAssertEqual(dyad.unorderedInterval, interval)
    }

    func assertCompoundIntervalDescriptor(
        for dyad: SpelledDyad<EDO12>,
        equals interval: CompoundIntervalDescriptor?
    )
    {
        XCTAssertEqual(dyad.orderedInterval, interval)
    }

    let cflat = SpelledPitch(Pitch.Spelling<EDO12>(.c, .flat(count: 1))), 4)
    let c = SpelledPitch(Pitch.Spelling<EDO12>(.c), 4)
    let ddoubleflat = SpelledPitch(Pitch.Spelling<EDO12>(.d, .flat(count: 1))), 4)
    let dflat = SpelledPitch(Pitch.Spelling<EDO12>(.d, .flat(count: 1))), 4)
    let csharp = SpelledPitch(Pitch.Spelling<EDO12>(.c, .sharp(count: 1)), 4)
    let cdoublesharp = SpelledPitch(Pitch.Spelling<EDO12>(.c, .sharp(count: 2)), 4)
    let dsharp = SpelledPitch(Pitch.Spelling<EDO12>(.d, .sharp(count: 1)), 4)
    let f = SpelledPitch(Pitch.Spelling<EDO12>(.f), 4)
    let fsharp = SpelledPitch(Pitch.Spelling<EDO12>(.f, .sharp(count: 1)), 4)
    let g = SpelledPitch(Pitch.Spelling<EDO12>(.g), 4)
    let gsharp = SpelledPitch(Pitch.Spelling<EDO12>(.g, .sharp(count: 1)), 4)
    let bdoubleflat = SpelledPitch(Pitch.Spelling<EDO12>(.b, .flat(count: 1))), 4)
    let bflat = SpelledPitch(Pitch.Spelling<EDO12>(.b, .flat(count: 1))), 4)
    let gdoublesharp = SpelledPitch(Pitch.Spelling<EDO12>(.g, .sharp(count: 2)), 5)

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
