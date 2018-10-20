//
//  UnorderedIntervalDescriptorTests.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import XCTest
import Pitch
import SpelledPitch

class UnorderedIntervalDescriptorTests: XCTestCase {

    typealias Ordinal = UnorderedIntervalDescriptor.Ordinal

    func testInitUnisonSamePitchClass() {
        let a = Pitch.Spelling(.c)
        let b = Pitch.Spelling(.c)
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.perfect, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitAugmentedUnison() {
        let a = Pitch.Spelling(.c)
        let b = Pitch.Spelling(.c, .sharp)
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.augmented, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitDoubleAugmentedUnison() {
        let a = Pitch.Spelling(.c)
        let b = Pitch.Spelling(.c, .doubleSharp)
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.double, .augmented, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitTripleAugmentedUnison() {
        let a = Pitch.Spelling(.c, .flat)
        let b = Pitch.Spelling(.c, .doubleSharp)
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.triple, .augmented, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitMinorSecond() {
        let a = Pitch.Spelling(.c)
        let b = Pitch.Spelling(.d, .flat)
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.minor, .second)
        XCTAssertEqual(result, expected)
    }

    func testCASharpAugmentedSixthDiminishedThird() {
        let a = Pitch.Spelling(.c)
        let b = Pitch.Spelling(.a, .sharp)
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.single, .diminished, .third)
        XCTAssertEqual(result, expected)
    }

    func testDFSharpMajorThird() {
        let a = Pitch.Spelling(.d)
        let b = Pitch.Spelling(.f, .sharp)
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.major, .third)
        XCTAssertEqual(result, expected)
    }

    func testBFlatDSharpAugmentedThird() {
        let a = Pitch.Spelling(.b, .flat)
        let b = Pitch.Spelling(.d, .sharp)
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.single, .augmented, .third)
        XCTAssertEqual(result, expected)
    }
}
