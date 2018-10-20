//
//  CompoundIntervalDescriptorTests.swift
//  SpelledPitch
//
//  Created by James Bean on 8/17/18.
//

import XCTest
import Pitch
import SpelledPitch

class CompoundIntervalDescriptorTests: XCTestCase {

    func testInitTwoSpelledPitchesUnison() {
        let a = SpelledPitch.middleC
        let b = SpelledPitch.middleC
        let interval = CompoundIntervalDescriptor(a,b)
        let expected = CompoundIntervalDescriptor(.unison)
        XCTAssertEqual(interval, expected)
    }

    func testInitTwoSpelledPitchesAscendingMinorSecond() {
        let a = SpelledPitch(Pitch.Spelling(.f))
        let b = SpelledPitch(Pitch.Spelling(.f, .sharp))
        let interval = CompoundIntervalDescriptor(a,b)
        let expected = CompoundIntervalDescriptor(.init(.augmented, .unison))
        XCTAssertEqual(interval, expected)
    }

    func testInitTwoSpelledPitchesDescendingMajorSecond() {
        let a = SpelledPitch(Pitch.Spelling(.g))
        let b = SpelledPitch(Pitch.Spelling(.f))
        let interval = CompoundIntervalDescriptor(a,b)
        let expected = CompoundIntervalDescriptor(.init(.descending, .major, .second))
        XCTAssertEqual(interval, expected)
    }

    func testInitTwoSpelledPitchesAscendingMinorSixth() {
        let a = SpelledPitch(Pitch.Spelling(.d))
        let b = SpelledPitch(Pitch.Spelling(.b, .flat))
        let interval = CompoundIntervalDescriptor(a,b)
        let expected = CompoundIntervalDescriptor(.init(.ascending, .minor, .sixth))
        XCTAssertEqual(interval, expected)
    }

    func testInitTwoSpelledPitchesAscendingMajorTenth() {
        let a = SpelledPitch(Pitch.Spelling(.d), 4)
        let b = SpelledPitch(Pitch.Spelling(.f, .sharp), 5)
        let interval = CompoundIntervalDescriptor(a,b)
        let expected = CompoundIntervalDescriptor(.init(.major, .third), displacedBy: 1)
        XCTAssertEqual(interval, expected)
    }

    func testInitTwoSpelledPitchesDescendingPerfectEleventh() {
        let a = SpelledPitch(Pitch.Spelling(.e), 4)
        let b = SpelledPitch(Pitch.Spelling(.b), 3)
        let interval = CompoundIntervalDescriptor(a,b)
        let expected = CompoundIntervalDescriptor(.init(.descending, .perfect, .fourth), displacedBy: 1)
        XCTAssertEqual(interval, expected)
    }
}
