//
//  CategoryTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/21/18.
//

import XCTest
import Pitch
@testable import SpelledPitch

class PitchSpellingCategoryTests: XCTestCase {

    func testLetterNamePredecessor() {
        let letterName: LetterName = .a
        let expected: LetterName = .g
        XCTAssertEqual(letterName.predecessor, expected)
    }

    func testLetterNameSuccessor() {
        let letterName: LetterName = .b
        let expected: LetterName = .c
        XCTAssertEqual(letterName.successor, expected)
    }

    func testNeutralLetterName() {
        XCTAssertEqual(Pitch.Spelling.neutralLetterName(for: 0), .c)
        XCTAssertEqual(Pitch.Spelling.neutralLetterName(for: 5), .f)
        XCTAssertEqual(Pitch.Spelling.neutralLetterName(for: 9), .a)
        XCTAssertEqual(Pitch.Spelling.neutralLetterName(for: 1), .c)
        XCTAssertEqual(Pitch.Spelling.neutralLetterName(for: 10), .b)
        XCTAssertNil(Pitch.Spelling.neutralLetterName(for: 8))
    }

    // MARK: - Category "Zero"
    func testPCZeroNeutral_CNatural() {
        let expected = Pitch.Spelling(.c)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 0, modifierDirection: .neutral), expected)
    }

    func testPCZeroUp_BSharp() {
        let expected = Pitch.Spelling(.b, .sharp)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 0, modifierDirection: .up), expected)
    }

    func testPCZeroDown_DDoubleFlat() {
        let expected = Pitch.Spelling(.d, .doubleFlat)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 0, modifierDirection: .down), expected)
    }

    // MARK: - Category "One"
    func testPCOneNeutral_CSharp() {
        let expected = Pitch.Spelling(.c, .sharp)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 1, modifierDirection: .neutral), expected)
    }

    func testPCOneUp_BDoubleSharp() {
        let expected = Pitch.Spelling(.b, .doubleSharp)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 1, modifierDirection: .up), expected)
    }

    func testPCOneDown_DFlat() {
        let expected = Pitch.Spelling(.d, .flat)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 1, modifierDirection: .down), expected)
    }

    // MARK: - Category "Two"
    func testPCTwoNeutral_DNatural() {
        let expected = Pitch.Spelling(.d)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 2, modifierDirection: .neutral), expected)
    }

    func testPCTwoUp_CDoubleSharp() {
        let expected = Pitch.Spelling(.c, .doubleSharp)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 2, modifierDirection: .up), expected)
    }

    func testPCTwoDown_EDoubleFlat() {
        let expected = Pitch.Spelling(.e, .doubleFlat)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 2, modifierDirection: .down), expected)
    }

    // MARK: - Category "Three"
    func testPCThreeNeutral_EFlat() {
        let expected = Pitch.Spelling(.e, .flat)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 3, modifierDirection: .neutral), expected)
    }

    func testPCThreeUp_DSharp() {
        let expected = Pitch.Spelling(.d, .sharp)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 3, modifierDirection: .up), expected)
    }

    func testPCThreeDown_FDoubleFlat() {
        let expected = Pitch.Spelling(.f, .doubleFlat)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 3, modifierDirection: .down), expected)
    }

    // MARK: - Category "Four"
    func testPCFourNeutral_ENatural() {
        let expected = Pitch.Spelling(.e)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 4, modifierDirection: .neutral), expected)
    }

    func testPCFourUp_DDoubleSharp() {
        let expected = Pitch.Spelling(.d, .doubleSharp)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 4, modifierDirection: .up), expected)
    }

    func testPCFourDown_FFlat() {
        let expected = Pitch.Spelling(.f, .flat)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 4, modifierDirection: .down), expected)
    }

    // MARK: - Category "Five"
    func testPCEightNeutral_Nil() {
        XCTAssertNil(Pitch.Spelling(pitchClass: 8, modifierDirection: .neutral))
    }

    func testPCEightUp_GSharp() {
        let expected = Pitch.Spelling(.g, .sharp)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 8, modifierDirection: .up), expected)
    }

    func testPCEight_AFlat() {
        let expected = Pitch.Spelling(.a, .flat)
        XCTAssertEqual(Pitch.Spelling(pitchClass: 8, modifierDirection: .down), expected)
    }
}
