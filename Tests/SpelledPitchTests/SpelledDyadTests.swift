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

    func assertRelativeNamedInterval(
        for dyad: SpelledDyad,
        equals interval: RelativeNamedInterval?
    )
    {
        XCTAssertEqual(dyad.relativeInterval, interval)
    }

    func assertAbsoluteInterval(
        for dyad: SpelledDyad,
        equals interval: AbsoluteNamedInterval?
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
        assertRelativeNamedInterval(for: spelledDyad, equals: RelativeNamedInterval(.perfect, .unison))
    }

    func testRelativeNamedIntervalMinorSecond() {
        assertRelativeNamedInterval(for: SpelledDyad(c, dflat), equals: RelativeNamedInterval(.minor, .second))
    }

    func testRelativeNamedIntervalAugmentedFourth() {
        assertRelativeNamedInterval(
            for: SpelledDyad(c, fsharp),
            equals: RelativeNamedInterval(.augmented, .fourth)
        )
    }

    func testRelativeNamedIntervalDiminishedFourth() {
        assertRelativeNamedInterval(
            for: SpelledDyad(fsharp, bflat),
            equals: RelativeNamedInterval(.diminished, .fourth)
        )
    }

    func testRelativeNamedIntervalDoubleDiminishedFourth() {
        let quality = RelativeNamedInterval.Quality.diminished[.double]!
        assertRelativeNamedInterval(
            for: SpelledDyad(fsharp, bdoubleflat),
            equals: RelativeNamedInterval(quality, .fourth)
        )
    }

    func testRelativeNamedIntervalDiminishedSecond() {
        assertRelativeNamedInterval(
            for: SpelledDyad(c, ddoubleflat),
            equals: RelativeNamedInterval(.diminished, .second)
        )
    }

    func testRelativeNamedIntervalAugmentedSecond() {
        assertRelativeNamedInterval(
            for: SpelledDyad(c, dsharp),
            equals: RelativeNamedInterval(.augmented, .second)
        )
    }

    func testDiminishedThird() {
        assertRelativeNamedInterval(
            for: SpelledDyad(dsharp, f),
            equals: RelativeNamedInterval(.diminished, .third)
        )
    }


//    func testRelativeNamedIntervalDoubleDiminishedSecond() {
//        assertRelativeNamedInterval(
//            for: SpelledDyad(csharp, ddoubleflat),
//            equals: RelativeNamedInterval(.double, .diminished, .second)
//        )
//    }


//    func testRelativeNamedIntervalPerfectFifth() {
//        assertRelativeNamedInterval(for: SpelledDyad(c, g), equals: RelativeNamedInterval(.perfect, .fifth))
//    }
//
//    func testRelativeNamedIntervalAugmentedFifth() {
//        assertRelativeNamedInterval(
//            for: SpelledDyad(c,gsharp),
//            equals: RelativeNamedInterval(.augmented, .fifth)
//        )
//    }

//    func testDoubleAugmentedSixth() {
//        assertRelativeNamedInterval(
//            for: SpelledDyad(bflat, gdoublesharp),
//            equals: RelativeNamedInterval(.double, .augmented, .sixth)
//        )
//    }
//
//    func testTripleDiminishedUnison() {
//        assertRelativeNamedInterval(
//            for: SpelledDyad(cdoublesharp, cflat),
//            equals: RelativeNamedInterval(.triple, .augmented, .unison)
//        )
//    }

}

