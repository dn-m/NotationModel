//
//  Pitch.Spelling.LetterName.Tests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 6/6/18.
//

import XCTest
import Pitch
import SpelledPitch

class Pitch_Spelling_LetterNameTests: XCTestCase {

    // Category "Zero"

    func testZeroNaturalCNatural() {
        let pitchClass: Pitch.Class = 0
        let modifier: Pitch.Spelling.QuarterStepModifier = .natural
        let expected: Pitch.Spelling.LetterName = .c
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testZeroSharpBSharp() {
        let pitchClass: Pitch.Class = 0
        let modifier: Pitch.Spelling.QuarterStepModifier = .sharp
        let expected: Pitch.Spelling.LetterName = .b
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testZeroDoubleFlatDDoubleFlat() {
        let pitchClass: Pitch.Class = 0
        let modifier: Pitch.Spelling.QuarterStepModifier = .doubleFlat
        let expected: Pitch.Spelling.LetterName = .d
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    // Category "One"

    func testOneFlatDFlat() {
        let pitchClass: Pitch.Class = 1
        let modifier: Pitch.Spelling.QuarterStepModifier = .flat
        let expected: Pitch.Spelling.LetterName = .d
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testOneSharpCSharp() {
        let pitchClass: Pitch.Class = 1
        let modifier: Pitch.Spelling.QuarterStepModifier = .sharp
        let expected: Pitch.Spelling.LetterName = .c
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testOneDoubleSharpBDoubleSharp() {
        let pitchClass: Pitch.Class = 1
        let modifier: Pitch.Spelling.QuarterStepModifier = .doubleSharp
        let expected: Pitch.Spelling.LetterName = .b
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testSixFlatGFlat() {
        let pitchClass: Pitch.Class = 6
        let modifier: Pitch.Spelling.QuarterStepModifier = .flat
        let expected: Pitch.Spelling.LetterName = .g
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testSixDoubleSharpEDoubleSharp() {
        let pitchClass: Pitch.Class = 6
        let modifier: Pitch.Spelling.QuarterStepModifier = .doubleSharp
        let expected: Pitch.Spelling.LetterName = .e
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    // Category "Two"

    func testTwoNaturalDNatural() {
        let pitchClass: Pitch.Class = 2
        let modifier: Pitch.Spelling.QuarterStepModifier = .natural
        let expected: Pitch.Spelling.LetterName = .d
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testTwoDoubleFlatEDoubleFlat() {
        let pitchClass: Pitch.Class = 2
        let modifier: Pitch.Spelling.QuarterStepModifier = .doubleFlat
        let expected: Pitch.Spelling.LetterName = .e
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testTwoDoubleSharpCDoubleSharp() {
        let pitchClass: Pitch.Class = 2
        let modifier: Pitch.Spelling.QuarterStepModifier = .doubleSharp
        let expected: Pitch.Spelling.LetterName = .c
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testSevenNaturalGNatural() {
        let pitchClass: Pitch.Class = 7
        let modifier: Pitch.Spelling.QuarterStepModifier = .natural
        let expected: Pitch.Spelling.LetterName = .g
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testNineDoubleSharpGDoublSharp() {
        let pitchClass: Pitch.Class = 9
        let modifier: Pitch.Spelling.QuarterStepModifier = .doubleSharp
        let expected: Pitch.Spelling.LetterName = .g
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    // Category "Three"

    func testThreeFlatEFlat() {
        let pitchClass: Pitch.Class = 3
        let modifier: Pitch.Spelling.QuarterStepModifier = .flat
        let expected: Pitch.Spelling.LetterName = .e
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testTenFlatBFlat() {
        let pitchClass: Pitch.Class = 10
        let modifier: Pitch.Spelling.QuarterStepModifier = .flat
        let expected: Pitch.Spelling.LetterName = .b
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testTenDoubleFlatCDoubleFlat() {
        let pitchClass: Pitch.Class = 10
        let modifier: Pitch.Spelling.QuarterStepModifier = .doubleFlat
        let expected: Pitch.Spelling.LetterName = .c
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    // Category "Four"

    func testFourNaturalENatural() {
        let pitchClass: Pitch.Class = 4
        let modifier: Pitch.Spelling.QuarterStepModifier = .natural
        let expected: Pitch.Spelling.LetterName = .e
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testFourFlatFFlat() {
        let pitchClass: Pitch.Class = 4
        let modifier: Pitch.Spelling.QuarterStepModifier = .flat
        let expected: Pitch.Spelling.LetterName = .f
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testElevenDoubleSharpADoubleSharp() {
        let pitchClass: Pitch.Class = 11
        let modifier: Pitch.Spelling.QuarterStepModifier = .doubleSharp
        let expected: Pitch.Spelling.LetterName = .a
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testElevenFlatCFlat() {
        let pitchClass: Pitch.Class = 11
        let modifier: Pitch.Spelling.QuarterStepModifier = .flat
        let expected: Pitch.Spelling.LetterName = .c
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    // Category "Five"

    func testEightFlatAFlat() {
        let pitchClass: Pitch.Class = 8
        let modifier: Pitch.Spelling.QuarterStepModifier = .flat
        let expected: Pitch.Spelling.LetterName = .a
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }

    func testEightSharpGSharp() {
        let pitchClass: Pitch.Class = 8
        let modifier: Pitch.Spelling.QuarterStepModifier = .sharp
        let expected: Pitch.Spelling.LetterName = .g
        XCTAssertEqual(Pitch.Spelling.LetterName(pitchClass: pitchClass, modifier: modifier), expected)
    }
}
