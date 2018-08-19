//
//  UnorderedSpelledIntervalTests.swift
//  SpelledPitch
//
//  Createsd by James Bean on 1/8/17.
//
//

import XCTest
import Pitch
import SpelledPitch

class UnorderedSpelledIntervalTests: XCTestCase {

    typealias Ordinal = UnorderedSpelledInterval.Ordinal

    func testInitUnisonSamePitchClass() {
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.c)
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.perfect, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitAugmentedUnison() {
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.c, .sharp(1))
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.augmented, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitDoubleAugmentedUnison() {
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.c, .sharp(2))
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.double, .augmented, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitTripleAugmentedUnison() {
        let a = Pitch.Spelling<EDO12>(.c, .flat(1))
        let b = Pitch.Spelling<EDO12>(.c, .sharp(2))
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.triple, .augmented, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitMinorSecond() {
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.d, .flat(1))
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.minor, .second)
        XCTAssertEqual(result, expected)
    }

    func testCASharpAugmentedSixthDiminishedThird() {
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.a, .sharp(1))
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.single, .diminished, .third)
        XCTAssertEqual(result, expected)
    }

    func testDFSharpMajorThird() {
        let a = Pitch.Spelling<EDO12>(.d)
        let b = Pitch.Spelling<EDO12>(.f, .sharp(1))
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.major, .third)
        XCTAssertEqual(result, expected)
    }

    func testBFlatDSharpAugmentedThird() {
        let a = Pitch.Spelling<EDO12>(.b, .flat(1))
        let b = Pitch.Spelling<EDO12>(.d, .sharp(1))
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.single, .augmented, .third)
        XCTAssertEqual(result, expected)
    }
}
