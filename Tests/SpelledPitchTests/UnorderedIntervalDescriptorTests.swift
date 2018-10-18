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
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.c)
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.perfect, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitAugmentedUnison() {
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.c, .sharp(count: 1))
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.augmented, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitDoubleAugmentedUnison() {
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.c, .sharp(count: 2))
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.double, .augmented, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitTripleAugmentedUnison() {
        let a = Pitch.Spelling<EDO12>(.c, .flat))
        let b = Pitch.Spelling<EDO12>(.c, .sharp(count: 2))
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.triple, .augmented, .unison)
        XCTAssertEqual(result, expected)
    }

    func testInitMinorSecond() {
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.d, .flat))
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.minor, .second)
        XCTAssertEqual(result, expected)
    }

    func testCASharpAugmentedSixthDiminishedThird() {
        let a = Pitch.Spelling<EDO12>(.c)
        let b = Pitch.Spelling<EDO12>(.a, .sharp(count: 1))
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.single, .diminished, .third)
        XCTAssertEqual(result, expected)
    }

    func testDFSharpMajorThird() {
        let a = Pitch.Spelling<EDO12>(.d)
        let b = Pitch.Spelling<EDO12>(.f, .sharp(count: 1))
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.major, .third)
        XCTAssertEqual(result, expected)
    }

    func testBFlatDSharpAugmentedThird() {
        let a = Pitch.Spelling<EDO12>(.b, .flat))
        let b = Pitch.Spelling<EDO12>(.d, .sharp(count: 1))
        let result = UnorderedIntervalDescriptor(a,b)
        let expected = UnorderedIntervalDescriptor(.single, .augmented, .third)
        XCTAssertEqual(result, expected)
    }
}
