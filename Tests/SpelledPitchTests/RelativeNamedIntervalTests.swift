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

    typealias Ordinal = RelativeNamedInterval.Ordinal

    func testInitUnisonSamePitchClass() {
        let a = SpelledPitchClass(0, Pitch.Spelling(.c))
        let b = SpelledPitchClass(0, Pitch.Spelling(.c))
        let result = RelativeNamedInterval(a,b)
        let expected = RelativeNamedInterval(.perfect, .unison)
        XCTAssertEqual(result, expected)
    }

    func testCASharpAugmentedSixthDiminishedThird() {
        let a = SpelledPitchClass(0, Pitch.Spelling(.c))
        let b = SpelledPitchClass(10, Pitch.Spelling(.a, .sharp))
        let result = RelativeNamedInterval(a,b)
        let expected = RelativeNamedInterval(.single, .diminished, .third)
        XCTAssertEqual(result, expected)
    }

    func testDFSharpMajorThird() {
        let a = SpelledPitchClass(2, Pitch.Spelling(.d))
        let b = SpelledPitchClass(6, Pitch.Spelling(.f, .sharp))
        let result = RelativeNamedInterval(a,b)
        let expected = RelativeNamedInterval(.major, .third)
        XCTAssertEqual(result, expected)
    }

    func testBFlatDSharpAugmentedThird() {
        let a = SpelledPitchClass(10, Pitch.Spelling(.b, .flat))
        let b = SpelledPitchClass(3, Pitch.Spelling(.d, .sharp))
        let result = RelativeNamedInterval(a,b)
        let expected = RelativeNamedInterval(.single, .augmented, .third)
        XCTAssertEqual(result, expected)
    }
}
