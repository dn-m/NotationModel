//
//  PitchSpellerTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 10/16/18.
//

import XCTest
import DataStructures
import Pitch
@testable import SpelledPitch

class PitchSpellerTests: XCTestCase {

    func testSpellZeroOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 60], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.c))]
        XCTAssertEqual(result, expected)
    }

    func testSpellOneOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 61], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.c, .sharp))]
        XCTAssertEqual(result, expected)
    }

    func testSpellTwoOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 62], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.d))]
        XCTAssertEqual(result, expected)
    }

    func testSpellThreeOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 63], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.e, .flat))]
        XCTAssertEqual(result, expected)
    }

    func testSpellFourOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 64], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.e))]
        XCTAssertEqual(result, expected)
    }

    func testSpellFiveOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 65], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.f))]
        XCTAssertEqual(result, expected)
    }

    func testSpellSixOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 66], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.f, .sharp))]
        XCTAssertEqual(result, expected)
    }

    func testSpellSevenOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 67], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.g))]
        XCTAssertEqual(result, expected)
    }

    func testSpellNineOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 69], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.a))]
        XCTAssertEqual(result, expected)
    }

    func testSpellTenOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 70], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.b, .flat))]
        XCTAssertEqual(result, expected)
    }

    func testSpellElevenOverDNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 71], parsimonyPivot: Pitch.Spelling(.d))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.b))]
        XCTAssertEqual(result, expected)
    }
    
    func testSpellEightOverCNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 68], parsimonyPivot: Pitch.Spelling(.c))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.a, .flat))]
        XCTAssertEqual(result, expected)
    }
    
    func testSpellEightOverBNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 68], parsimonyPivot: Pitch.Spelling(.b))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.g, .sharp))]
        XCTAssertEqual(result, expected)
    }
    
    func testSpellEightOverANatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 68], parsimonyPivot: Pitch.Spelling(.a))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.g, .sharp))]
        XCTAssertEqual(result, expected)
    }
    
    func testSpellEightOverGNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 68], parsimonyPivot: Pitch.Spelling(.g))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.a, .flat))]
        XCTAssertEqual(result, expected)
    }
    
    func testSpellEightOverFNatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 68], parsimonyPivot: Pitch.Spelling(.f))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.a, .flat))]
        XCTAssertEqual(result, expected)
    }
    
    func testSpellEightOverENatural() {
        let pitchSpeller = PitchSpeller(pitches: [0: 68], parsimonyPivot: Pitch.Spelling(.e))
        let result = pitchSpeller.spell()
        let expected: [Int: SpelledPitch] = [0: SpelledPitch(Pitch.Spelling(.g, .sharp))]
        XCTAssertEqual(result, expected)
    }

    func testSpellCF() {
        let pitchSpeller = PitchSpeller(pitches: [0:60,1:65])
        let _ = pitchSpeller.spell()
        // FIXME: Add assertion
    }
}
