//
//  UnorderedSpelledIntervalTests.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import XCTest
import Pitch
import SpelledPitch

class UnorderedSpelledIntervalTests: XCTestCase {

    typealias Ordinal = UnorderedSpelledInterval.Ordinal

    func testInitUnisonSamePitchClass() {
        let a = Pitch.Spelling(.c)
        let b = Pitch.Spelling(.c)
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.perfect, .unison)
        XCTAssertEqual(result, expected)
    }

    func testCASharpAugmentedSixthDiminishedThird() {
        let a = Pitch.Spelling(.c)
        let b = Pitch.Spelling(.a, .sharp)
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.single, .diminished, .third)
        XCTAssertEqual(result, expected)
    }

    func testDFSharpMajorThird() {
        let a = Pitch.Spelling(.d)
        let b = Pitch.Spelling(.f, .sharp)
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.major, .third)
        XCTAssertEqual(result, expected)
    }

    func testBFlatDSharpAugmentedThird() {
        let a = Pitch.Spelling(.b, .flat)
        let b = Pitch.Spelling(.d, .sharp)
        let result = UnorderedSpelledInterval(a,b)
        let expected = UnorderedSpelledInterval(.single, .augmented, .third)
        XCTAssertEqual(result, expected)
    }
}
