//
//  PitchSpellingTests.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import XCTest
import Pitch
@testable import SpelledPitch

class PitchSpellingTests: XCTestCase {

    func testInitJustLetterName() {
        let ps = PitchSpelling(letterName: .f)
        XCTAssert(ps.quarterStep == .natural)
        XCTAssert(ps.eighthStep == .none)
    }
    
    func testPitchClassCZero() {
        XCTAssertEqual(PitchSpelling(.c).pitchClass, 0)
    }
    
    func testPitchClassCSharpOne() {
        XCTAssertEqual(PitchSpelling(.c, .sharp).pitchClass, 1)
    }
    
    func testPitchClassDDoubleFlatZero() {
        XCTAssertEqual(PitchSpelling(.d, .doubleFlat).pitchClass, 0)
    }
    
    func testPitchClassCQuarterSharpZeroPointFive() {
        XCTAssertEqual(PitchSpelling(.c, .quarterSharp).pitchClass, 0.5)
    }
    
    func testPitchClassCQuarterSharpDownZeroPointTwoFive() {
        XCTAssertEqual(PitchSpelling(.c, .quarterSharp, .down).pitchClass, 0.25)
    }
    
    func testPitchClassCQuarterSharpUpZeroPointSevenFive() {
        XCTAssertEqual(PitchSpelling(.c, .quarterSharp, .up).pitchClass, 0.75)
    }
    
    func testGThreeQuarterFlatUpFivePointSeventyFive() {
        XCTAssertEqual(PitchSpelling(.g, .threeQuarterFlat, .up).pitchClass, 5.75)
    }
}
