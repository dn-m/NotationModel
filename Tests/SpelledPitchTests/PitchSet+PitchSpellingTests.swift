//
//  PitchSet+PitchSpellingTests.swift
//  SpelledPitch
//
//  Created by James Bean on 1/19/17.
//
//

import XCTest
import Pitch
import SpelledPitch

class PitchSet_PitchSpellingTests: XCTestCase {

    func testEmptyEmpty() {
        let pitchSet: Set<Pitch> = []
        XCTAssertEqual(pitchSet.spelledWithDefaultSpelling, [])
    }

    func testMiddleC() {
        let pitchSet: Set<Pitch> = [60]
        XCTAssertEqual(
            pitchSet.spelledWithDefaultSpelling,
            [SpelledPitch(60, Pitch.Spelling(.c))]
        )
    }

    func testPitchSet() {
        let pitchSet: Set<Pitch> = [60, 61, 70]
        XCTAssertEqual(
            pitchSet.spelledWithDefaultSpelling,
            [
                SpelledPitch(60, Pitch.Spelling(.c)),
                SpelledPitch(61, Pitch.Spelling(.c, .sharp)),
                SpelledPitch(70, Pitch.Spelling(.b, .flat))
            ]
        )
    }
}
