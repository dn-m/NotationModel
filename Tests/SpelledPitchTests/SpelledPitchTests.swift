//
//  SpelledPitchTests.swift
//  SpelledPitch
//
//  Created by James Bean on 6/15/16.
//
//

import XCTest
import Pitch
@testable import SpelledPitch

class SpelledPitchTests: XCTestCase {

    func testOctaveMiddleC() {
        XCTAssertEqual(SpelledPitch.middleC.pitch, 60)
    }

    func testOctaveDAboveMiddleC() {
        let d = SpelledPitch(Pitch.Spelling(.d), 4)
        XCTAssertEqual(d.pitch, 62)
    }

    func testOctaveBBelowMiddleC() {
        let b = SpelledPitch(Pitch.Spelling(.b), 3)
        XCTAssertEqual(b.pitch, 59)
    }

    func testOctaveCFlat() {
        let cflat = SpelledPitch(Pitch.Spelling(.c, .flat), 4)
        XCTAssertEqual(cflat.pitch, 59)
    }

    func testOctaveBSharp() {
        let bsharp = SpelledPitch(Pitch.Spelling(.b, .sharp), 3)
        XCTAssertEqual(bsharp.pitch, 60)
    }

    func testOctaveCQuarterFlat() {
        let cqflat = SpelledPitch(Pitch.Spelling(.c, .quarterFlat), 4)
        XCTAssertEqual(cqflat.pitch, 59.5)
    }

    func testOctaveCNaturalDown() {
        let cdown = SpelledPitch(Pitch.Spelling(.c, .natural, .ptolemaic(-1)), 4)
        XCTAssertEqual(cdown.pitch, 59.785)
    }

    func testBQuarterSharp() {
        let bqsharp = SpelledPitch(Pitch.Spelling(.b, .quarterSharp), 3)
        XCTAssertEqual(bqsharp.pitch, 59.5)
    }

    func testBSharpPtolemaicDown() {
        let bsharpdown = SpelledPitch(Pitch.Spelling(.b, .sharp, .ptolemaic(-1)), 3)
        XCTAssertEqual(bsharpdown.pitch, 59.785)
    }

    func testComparableSameOctave() {
        let d = SpelledPitch(Pitch.Spelling(.d), 4)
        let e = SpelledPitch(Pitch.Spelling(.e), 4)
        XCTAssert(d < e)
        XCTAssert(e > d)
    }

    func testComparableDifferentOctave() {
        let d = SpelledPitch(Pitch.Spelling(.d), 4)
        let e = SpelledPitch(Pitch.Spelling(.e), 5)
        XCTAssert(d < e)
        XCTAssert(e > d)
    }

    func testComparableMinorSixth() {
        let d = SpelledPitch(Pitch.Spelling(.d))
        let b = SpelledPitch(Pitch.Spelling(.b, .flat))
        XCTAssert(d < b)
        XCTAssert(b > d)
    }

    func testComparableSameLetter() {
        let d = SpelledPitch(Pitch.Spelling(.d), 4)
        let dsharp = SpelledPitch(Pitch.Spelling(.d, .sharp), 4)
        XCTAssert(d < dsharp)
        XCTAssert(dsharp > d)
    }

    func testExtrema() {
        let pitches: [Pitch] = [64,66,67,69,86]
        let spelled = pitches.map { $0.spelledWithDefaultSpelling }
        XCTAssertEqual(spelled.min(), SpelledPitch(Pitch.Spelling(.e), 4))
        XCTAssertEqual(spelled.max(), SpelledPitch(Pitch.Spelling(.d), 6))
    }

    // MARK: - Transposition

    func testDisplacedByUnisonIsSelf() {
        let spelledPitch = SpelledPitch.middleC
        let interval = OrderedIntervalDescriptor.unison
        let result = spelledPitch.displaced(by: interval)
        XCTAssertEqual(result, spelledPitch)
    }

    func testCNaturalDisplacedByMajorSecondDNatural() {
        let spelledPitch = SpelledPitch.middleC
        let interval = OrderedIntervalDescriptor(.major, .second)
        let result = spelledPitch.displaced(by: interval)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.d)))
    }

    func testCNaturalDisplacedByMinorThirdEFlat() {
        let spelledPitch = SpelledPitch.middleC
        let m3 = OrderedIntervalDescriptor(.minor, .third)
        let result = spelledPitch.displaced(by: m3)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.e, .flat)))
    }

    func testBNaturalPlusMajorThird() {
        let bNatural = SpelledPitch(Pitch.Spelling(.b), 4)
        let M3 = OrderedIntervalDescriptor(.major, .third)
        let result = bNatural.displaced(by: M3)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.d, .sharp), 5))
    }

    func testENaturalPlusMajorSecond() {
        let eNatural = SpelledPitch(Pitch.Spelling(.e))
        let M2 = OrderedIntervalDescriptor(.major, .second)
        let result = eNatural.displaced(by: M2)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.f, .sharp)))
    }

    func testCSharpPlusMinorSecondDNatural() {
        let cSharp = SpelledPitch(Pitch.Spelling(.c, .sharp))
        let m2 = OrderedIntervalDescriptor(.minor, .second)
        let result = cSharp.displaced(by: m2)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.d, .natural)))
    }

    func testCSharpPlusMajorSecondDSharp() {
        let cSharp = SpelledPitch(Pitch.Spelling(.c, .sharp))
        let M2 = OrderedIntervalDescriptor(.major, .second)
        let result = cSharp.displaced(by: M2)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.d, .sharp)))
    }

    func testCSharpMajorThirdESharp() {
        let cSharp = SpelledPitch(Pitch.Spelling(.c, .sharp))
        let M3 = OrderedIntervalDescriptor(.major, .third)
        let result = cSharp.displaced(by: M3)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.e, .sharp)))
    }

    func testFSharpPlusMajorThirdASharp() {
        let fSharp = SpelledPitch(Pitch.Spelling(.f, .sharp))
        let M3 = OrderedIntervalDescriptor(.major, .third)
        let result = fSharp.displaced(by: M3)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.a, .sharp)))
    }

    func testCDoubleSharpPlusAugmentedFourth() {
        let cDoubleSharp = SpelledPitch(Pitch.Spelling(.c, .doubleSharp))
        let A4 = OrderedIntervalDescriptor(.augmented, .fourth)
        let result = cDoubleSharp.displaced(by: A4)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.f, .init(3))))
    }

    func testANaturalPlusPerfectFourthOctave() {
        let aNatural = SpelledPitch(Pitch.Spelling(.a), 5)
        let P4 = OrderedIntervalDescriptor(.perfect, .fourth)
        let result = aNatural.displaced(by: P4)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.d, .natural), 6))
    }

    func testCNaturalPlusMinorSeventh() {
        let cNatural = SpelledPitch(Pitch.Spelling(.c))
        let m7 = OrderedIntervalDescriptor(.minor, .seventh)
        let result = cNatural.displaced(by: m7)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.b, .flat)))
    }

    func testCNaturalPlusDescendingMajorSecond() {
        let cNatural = SpelledPitch(Pitch.Spelling(.c), 4)
        let dM2 = OrderedIntervalDescriptor(.descending, .major, .second)
        let result = cNatural.displaced(by: dM2)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.b, .flat), 3))
    }

    func testGSharpPlusDescendingMajorSeventh() {
        let gSharp = SpelledPitch(Pitch.Spelling(.g, .sharp), 3)
        let dM7 = OrderedIntervalDescriptor(.descending, .major, .seventh)
        let result = gSharp.displaced(by: dM7)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.a), 2))
    }

    func testFNaturalPlusDescendingMajorSecondNoOctaveChange() {
        let fNatural = SpelledPitch(Pitch.Spelling(.f), 7)
        let dM2 = OrderedIntervalDescriptor(.descending, .major, .second)
        let result = fNatural.displaced(by: dM2)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.e, .flat), 7))
    }

    func testFNaturalPlusMinorSeventh() {
        let fNatural = SpelledPitch(Pitch.Spelling(.f), 2)
        let m7 = OrderedIntervalDescriptor(.minor, .seventh)
        let result = fNatural.displaced(by: m7)
        XCTAssertEqual(result, SpelledPitch(Pitch.Spelling(.e, .flat), 3))
    }
}
