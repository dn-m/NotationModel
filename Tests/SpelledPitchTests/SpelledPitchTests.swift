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
        let c = SpelledPitch(60, Pitch.Spelling(.c))
        XCTAssertEqual(c.octave, 5)
    }

    func testOctaveDAboveMiddleC() {
        let d = SpelledPitch(62, Pitch.Spelling(.d))
        XCTAssertEqual(d.octave, 5)
    }

    func testOctaveBBelowMiddleC() {
        let b = SpelledPitch(59, Pitch.Spelling(.b))
        XCTAssertEqual(b.octave, 4)
    }

    func testOctaveCFlat() {
        let cflat = SpelledPitch(59, Pitch.Spelling(.c, .flat))
        XCTAssertEqual(cflat.octave, 5)
    }

    func testOctaveBSharp() {
        let bsharp = SpelledPitch(60, Pitch.Spelling(.b, .sharp))
        XCTAssertEqual(bsharp.octave, 4)
    }

    func testOctaveCQuarterFlat() {
        let cqflat = SpelledPitch(59.5, Pitch.Spelling(.c, .quarterFlat))
        XCTAssertEqual(cqflat.octave, 5)
    }

    func testOctaveCNaturalDown() {
        let cdown = SpelledPitch(59.75, Pitch.Spelling(.c, .natural, .down))
        XCTAssertEqual(cdown.octave, 5)
    }

    func testBQuarterSharp() {
        let bqsharp = SpelledPitch(59.5, Pitch.Spelling(.b, .quarterSharp))
        XCTAssertEqual(bqsharp.octave, 4)
    }

    func testBSharpDown() {
        let bsharpdown = SpelledPitch(59.75, Pitch.Spelling(.b, .sharp, .down))
        XCTAssertEqual(bsharpdown.octave, 4)
    }
}
