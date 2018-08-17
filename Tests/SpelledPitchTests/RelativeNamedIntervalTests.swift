//
//  RelativeNamedIntervalTests.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import XCTest
import Pitch
import SpelledPitch

class RelativeNamedIntervalTests: XCTestCase {

    typealias Ordinal = NamedUnorderedInterval.Ordinal

    func testInitUnisonSamePitchClass() {
        let a = Pitch.Spelling(.c)
        let b = Pitch.Spelling(.c)
        let result = NamedUnorderedInterval(a,b)
        let expected = NamedUnorderedInterval(.perfect, .unison)
        XCTAssertEqual(result, expected)
    }

    func testCASharpAugmentedSixthDiminishedThird() {
        let a = Pitch.Spelling(.c)
        let b = Pitch.Spelling(.a, .sharp)
        let result = NamedUnorderedInterval(a,b)
        let expected = NamedUnorderedInterval(.single, .diminished, .third)
        XCTAssertEqual(result, expected)
    }

    func testDFSharpMajorThird() {
        let a = Pitch.Spelling(.d)
        let b = Pitch.Spelling(.f, .sharp)
        let result = NamedUnorderedInterval(a,b)
        let expected = NamedUnorderedInterval(.major, .third)
        XCTAssertEqual(result, expected)
    }

    func testBFlatDSharpAugmentedThird() {
        let a = Pitch.Spelling(.b, .flat)
        let b = Pitch.Spelling(.d, .sharp)
        let result = NamedUnorderedInterval(a,b)
        let expected = NamedUnorderedInterval(.single, .augmented, .third)
        XCTAssertEqual(result, expected)
    }
}
