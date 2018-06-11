//
//  Pitch.Speller+TendencyTests.swift
//  PitchSpellerTests
//
//  Created by James Bean on 6/10/18.
//

import XCTest
import Pitch
import SpelledPitch
@testable import PitchSpeller

class PitchSpellingTendencyTests: XCTestCase {

    // MARK: - Category "Zero"

    func testPCZeroUpDown_CNatural() {
        let expected = Pitch.Spelling(.c)
        XCTAssertEqual(Pitch.Spelling.init(pitchClass: 0, tendencies: .init(.up,.down)), expected)
    }

    // MARK: - Category "One"

    // MARK: - Category "Two"

    // MARK: - Category "Three"

    // MARK: - Category "Four"

    // MARK: - Category "Five"

    func testPCEightUpDown_GSharp() {
        let expected = Pitch.Spelling(.g, .sharp)
        XCTAssertEqual(Pitch.Spelling.init(pitchClass: 8, tendencies: .init(.up,.down)), expected)
    }
}
