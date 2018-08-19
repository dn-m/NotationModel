//
//  SpelledPitchTests.swift
//  SpelledPitch
//
//  Createsd by James Bean on 6/15/16.
//
//

import XCTest
import Pitch
import SpelledPitch

class SpelledPitchTests: XCTestCase {

    func testOctaveMiddleC() {
        XCTAssertEqual(SpelledPitch<EDO48>.middleC.pitch, 60)
    }

    func testOctaveDAboveMiddleC() {
        let d = SpelledPitch(Pitch.Spelling<EDO24>(.d), 4)
        XCTAssertEqual(d.pitch, 62)
    }

    func testOctaveBBelowMiddleC() {
        let b = SpelledPitch(Pitch.Spelling<EDO12>(.b), 3)
        XCTAssertEqual(b.pitch, 59)
    }

    func testOctaveCFlat() {
        let cflat = SpelledPitch(Pitch.Spelling<EDO24>(.c, .flat(1)), 4)
        XCTAssertEqual(cflat.pitch, 59)
    }

    func testOctaveBSharp() {
        let bsharp = SpelledPitch(Pitch.Spelling<EDO48>(.b, .sharp(1)), 3)
        XCTAssertEqual(bsharp.pitch, 60)
    }

    func testOctaveCQuarterFlat() {
        let cqflat = SpelledPitch(Pitch.Spelling<EDO24>(.c, .quarter, .flat(1)), 4)
        XCTAssertEqual(cqflat.pitch, 59.5)
    }

    func testOctaveCNaturalDown() {
        let cdown = SpelledPitch(Pitch.Spelling(.c, .natural, .down), 4)
        XCTAssertEqual(cdown.pitch, 59.75)
    }

    func testBQuarterSharp() {
        let bqsharp = SpelledPitch(Pitch.Spelling<EDO24>(.b, .quarter, .sharp(1)), 3)
        XCTAssertEqual(bqsharp.pitch, 59.5)
    }

    func testBSharpDown() {
        let bsharpdown = SpelledPitch(Pitch.Spelling<EDO48>(.b, .sharp(1), .down), 3)
        XCTAssertEqual(bsharpdown.pitch, 59.75)
    }

    func testComparableSameOctave() {
        let d = SpelledPitch(Pitch.Spelling<EDO48>(.d), 4)
        let e = SpelledPitch(Pitch.Spelling<EDO48>(.e), 4)
        XCTAssert(d < e)
        XCTAssert(e > d)
    }

    func testComparableDifferentOctave() {
        let d = SpelledPitch(Pitch.Spelling<EDO24>(.d), 4)
        let e = SpelledPitch(Pitch.Spelling<EDO24>(.e), 5)
        XCTAssert(d < e)
        XCTAssert(e > d)
    }

    func testComparableMinorSixth() {
        let d = SpelledPitch<EDO12>(Pitch.Spelling(.d))
        let b = SpelledPitch<EDO12>(Pitch.Spelling(.b, .flat(1)))
        XCTAssert(d < b)
        XCTAssert(b > d)
    }

    func testComparableSameLetter() {
        let d = SpelledPitch(Pitch.Spelling<EDO12>(.d), 4)
        let dsharp = SpelledPitch(Pitch.Spelling<EDO12>(.d, .sharp(1)), 4)
        XCTAssert(d < dsharp)
        XCTAssert(dsharp > d)
    }

    func testExtrema() {
        let pitches: [Pitch] = [64,66,67,69,86]
        let spelled = pitches.map { $0.spelledWithDefaultSpelling }
        XCTAssertEqual(spelled.min(), SpelledPitch(Pitch.Spelling(.e), 4))
        XCTAssertEqual(spelled.max(), SpelledPitch(Pitch.Spelling(.d), 6))
    }
}
