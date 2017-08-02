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
        let c = SpelledPitch(60, PitchSpelling(.c))
        XCTAssertEqual(c.octave, 5)
    }
    
    func testOctaveDAboveMiddleC() {
        let d = SpelledPitch(62, PitchSpelling(.d))
        XCTAssertEqual(d.octave, 5)
    }
    
    func testOctaveBBelowMiddleC() {
        let b = SpelledPitch(59, PitchSpelling(.b))
        XCTAssertEqual(b.octave, 4)
    }
    
    func testOctaveCFlat() {
        let cflat = SpelledPitch(59, PitchSpelling(.c, .flat))
        XCTAssertEqual(cflat.octave, 5)
    }
    
    func testOctaveBSharp() {
        let bsharp = SpelledPitch(60, PitchSpelling(.b, .sharp))
        XCTAssertEqual(bsharp.octave, 4)
    }
    
    func testOctaveCQuarterFlat() {
        let cqflat = SpelledPitch(59.5, PitchSpelling(.c, .quarterFlat))
        XCTAssertEqual(cqflat.octave, 5)
    }
    
    func testOctaveCNaturalDown() {
        let cdown = SpelledPitch(59.75, PitchSpelling(.c, .natural, .down))
        XCTAssertEqual(cdown.octave, 5)
    }
    
    func testBQuarterSharp() {
        let bqsharp = SpelledPitch(59.5, PitchSpelling(.b, .quarterSharp))
        XCTAssertEqual(bqsharp.octave, 4)
    }
    
    func testBSharpDown() {
        let bsharpdown = SpelledPitch(59.75, PitchSpelling(.b, .sharp, .down))
        XCTAssertEqual(bsharpdown.octave, 4)
    }
}
