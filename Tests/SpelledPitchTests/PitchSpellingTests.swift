//
//  PitchSpellingTests.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import Pitch
import SpelledPitch

class PitchSpellingTests: XCTestCase {

    func testInitJustLetterName() {
        let ps = Pitch.Spelling<EDO12>(.f)
        XCTAssertEqual(ps.modifier.adjustment, 0)
    }

    func testPitchClassCZero() {
        XCTAssertEqual(Pitch.Spelling<EDO24>(.c).pitchClass, 0)
    }

    func testPitchClassCSharpOne() {
        XCTAssertEqual(Pitch.Spelling<EDO48>(.c, .sharp(count: 1)).pitchClass, 1)
    }

    func testPitchClassDDoubleFlatZero() {
        XCTAssertEqual(Pitch.Spelling<EDO24>(.d, .flat)).pitchClass, 0)
    }

    func testPitchClassCQuarterSharpZeroPointFive() {
        XCTAssertEqual(Pitch.Spelling<EDO24>(.c, .quarter, .sharp(count: 1)).pitchClass, 0.5)
    }

    func testPitchClassCQuarterSharpDownZeroPointTwoFive() {
        XCTAssertEqual(Pitch.Spelling(.c, .quarter, .sharp(count: 1), .down).pitchClass, 0.25)
    }

    func testPitchClassCQuarterSharpUpZeroPointSevenFive() {
        XCTAssertEqual(Pitch.Spelling(.c, .quarter, .sharp(count: 1), .up).pitchClass, 0.75)
    }

    func testGThreeQuarterFlatUpFivePointSeventyFive() {
        XCTAssertEqual(Pitch.Spelling(.g, .threeQuarter, .flat), .up).pitchClass, 5.75)
    }
}
