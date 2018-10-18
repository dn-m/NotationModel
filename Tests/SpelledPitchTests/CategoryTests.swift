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
        XCTAssertEqual(LetterName.neutral(for: 0), .c)
        XCTAssertEqual(LetterName.neutral(for: 5), .f)
        XCTAssertEqual(LetterName.neutral(for: 9), .a)
        XCTAssertEqual(LetterName.neutral(for: 1), .c)
        XCTAssertEqual(LetterName.neutral(for: 10), .b)
        XCTAssertNil(LetterName.neutral(for: 8))
    }

    // MARK: - Category "Zero"
    func testPCZeroNeutral_CNatural() {
        let expected = Pitch.Spelling<EDO12>(.c)
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 0, modifierDirection: .neutral), expected)
    }

    func testPCZeroUp_BSharp() {
        let expected = Pitch.Spelling<EDO12>(.b, .sharp(count: 1))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 0, modifierDirection: .up), expected)
    }

    func testPCZeroDown_DDoubleFlat() {
        let expected = Pitch.Spelling<EDO12>(.d, .flat(2))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 0, modifierDirection: .down), expected)
    }

    // MARK: - Category "One"
    func testPCOneNeutral_CSharp() {
        let expected = Pitch.Spelling<EDO12>(.c, .sharp(count: 1))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 1, modifierDirection: .neutral), expected)
    }

    func testPCOneUp_BDoubleSharp() {
        let expected = Pitch.Spelling<EDO12>(.b, .sharp(count: 2))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 1, modifierDirection: .up), expected)
    }

    func testPCOneDown_DFlat() {
        let expected = Pitch.Spelling<EDO12>(.d, .flat(1))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 1, modifierDirection: .down), expected)
    }

    // MARK: - Category "Two"
    func testPCTwoNeutral_DNatural() {
        let expected = Pitch.Spelling<EDO12>(.d)
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 2, modifierDirection: .neutral), expected)
    }

    func testPCTwoUp_CDoubleSharp() {
        let expected = Pitch.Spelling<EDO12>(.c, .sharp(count: 2))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 2, modifierDirection: .up), expected)
    }

    func testPCTwoDown_EDoubleFlat() {
        let expected = Pitch.Spelling<EDO12>(.e, .flat(2))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 2, modifierDirection: .down), expected)
    }

    // MARK: - Category "Three"
    func testPCThreeNeutral_EFlat() {
        let expected = Pitch.Spelling<EDO12>(.e, .flat(1))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 3, modifierDirection: .neutral), expected)
    }

    func testPCThreeUp_DSharp() {
        let expected = Pitch.Spelling<EDO12>(.d, .sharp(count: 1))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 3, modifierDirection: .up), expected)
    }

    func testPCThreeDown_FDoubleFlat() {
        let expected = Pitch.Spelling<EDO12>(.f, .flat(2))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 3, modifierDirection: .down), expected)
    }

    // MARK: - Category "Four"
    func testPCFourNeutral_ENatural() {
        let expected = Pitch.Spelling<EDO12>(.e)
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 4, modifierDirection: .neutral), expected)
    }

    func testPCFourUp_DDoubleSharp() {
        let expected = Pitch.Spelling<EDO12>(.d, .sharp(count: 2))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 4, modifierDirection: .up), expected)
    }

    func testPCFourDown_FFlat() {
        let expected = Pitch.Spelling<EDO12>(.f, .flat(1))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 4, modifierDirection: .down), expected)
    }

    // MARK: - Category "Five"
    func testPCEightNeutral_Nil() {
        XCTAssertNil(Pitch.Spelling<EDO12>(pitchClass: 8, modifierDirection: .neutral))
    }

    func testPCEightUp_GSharp() {
        let expected = Pitch.Spelling<EDO12>(.g, .sharp(count: 1))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 8, modifierDirection: .up), expected)
    }

    func testPCEight_AFlat() {
        let expected = Pitch.Spelling<EDO12>(.a, .flat(1))
        XCTAssertEqual(Pitch.Spelling<EDO12>(pitchClass: 8, modifierDirection: .down), expected)
    }
}
