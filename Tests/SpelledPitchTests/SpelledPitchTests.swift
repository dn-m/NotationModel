//
//  SpelledPitchTests.swift
//  SpelledPitch
//
//  Created by James Bean on 6/15/16.
//
//

import XCTest
import Pitch
import SpelledPitch

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
        let cdown = SpelledPitch(Pitch.Spelling(.c, .natural, .down), 4)
        XCTAssertEqual(cdown.pitch, 59.75)
    }

    func testBQuarterSharp() {
        let bqsharp = SpelledPitch(Pitch.Spelling(.b, .quarterSharp), 3)
        XCTAssertEqual(bqsharp.pitch, 59.5)
    }

    func testBSharpDown() {
        let bsharpdown = SpelledPitch(Pitch.Spelling(.b, .sharp, .down), 3)
        XCTAssertEqual(bsharpdown.pitch, 59.75)
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
}
