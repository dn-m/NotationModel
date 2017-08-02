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
        XCTAssertEqual(pitchSet.spelledWithDefaultSpelling(), [])
    }
    
    func testMiddleC() {
        let pitchSet: Set<Pitch> = [60]
        XCTAssertEqual(
            pitchSet.spelledWithDefaultSpelling(),
            [SpelledPitch(60, PitchSpelling(.c))]
        )
    }
    
    func testPitchSet() {
        let pitchSet: Set<Pitch> = [60, 61, 70]
        XCTAssertEqual(
            pitchSet.spelledWithDefaultSpelling(),
            [
                SpelledPitch(60, PitchSpelling(.c)),
                SpelledPitch(61, PitchSpelling(.c, .sharp)),
                SpelledPitch(70, PitchSpelling(.b, .flat))
            ]
        )
    }
}
