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

    // MARK: - CustomStringConvertible

    func testCNaturalDescription() {
        let cNatural = Pitch.Spelling(.c, .natural)
        XCTAssertEqual(cNatural.description, "c")
    }

    func testCSharpDescription() {
        let cSharp = Pitch.Spelling(.c, .sharp)
        XCTAssertEqual(cSharp.description, "c #")
    }

    func testCFlatDescription() {
        let cFlat = Pitch.Spelling(.c, .flat)
        XCTAssertEqual(cFlat.description, "c b")
    }

    func testCDoubleFlatDescription() {
        let cDoubleFlat = Pitch.Spelling(.c, .doubleFlat)
        XCTAssertEqual(cDoubleFlat.description, "c bb")
    }

    func testCDoubleSharpDescription() {
        let cDoubleSharp = Pitch.Spelling(.c, .doubleSharp)
        XCTAssertEqual(cDoubleSharp.description, "c x")
    }

    func testGQuadrupleSharpDescription() {
        let quadrupleSharp = Pitch.Spelling.Modifier.Pythagorean(4)
        let gQuadrupleSharp = Pitch.Spelling(.g, quadrupleSharp)
        XCTAssertEqual(gQuadrupleSharp.description, "g xx")
    }

    func testFQuintupleSharpDescription() {
        let quintupleSharp = Pitch.Spelling.Modifier.Pythagorean(5)
        let fQuintupleSharp = Pitch.Spelling(.f, quintupleSharp)
        XCTAssertEqual(fQuintupleSharp.description, "f xx#")
    }

    func testENonTupleFlatDescription() {
        let nontupleFlat = Pitch.Spelling.Modifier.Pythagorean(-9)
        let eNontupleFlat = Pitch.Spelling(.e, nontupleFlat)
        XCTAssertEqual(eNontupleFlat.description, "e bbbbbbbbb")
    }
}
