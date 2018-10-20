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
        let ps = Pitch.Spelling(.f)
        XCTAssertEqual(ps.modifier.adjustment, 0)
    }

    func testPitchClassCZero() {
        XCTAssertEqual(Pitch.Spelling(.c).pitchClass, 0)
    }

    func testPitchClassCSharpOne() {
        XCTAssertEqual(Pitch.Spelling(.c, .sharp).pitchClass, 1)
    }

    func testPitchClassDDoubleFlatZero() {
        XCTAssertEqual(Pitch.Spelling(.d, .doubleFlat).pitchClass, 0)
    }

    func testPitchClassCQuarterSharpZeroPointFive() {
        XCTAssertEqual(Pitch.Spelling(.c, .quarterSharp).pitchClass, 0.5)
    }

//    func testPitchClassCQuarterSharpDownZeroPointTwoFive() {
//        XCTAssertEqual(Pitch.Spelling(.c, .quarter, .sharp, .down).pitchClass, 0.25)
//    }
//
//    func testPitchClassCQuarterSharpUpZeroPointSevenFive() {
//        XCTAssertEqual(Pitch.Spelling(.c, .quarter, .sharp, .up).pitchClass, 0.75)
//    }
//
//    func testGThreeQuarterFlatUpFivePointSeventyFive() {
//        XCTAssertEqual(Pitch.Spelling(.g, .threeQuarter, .flat, .up).pitchClass, 5.75)
//    }
}
