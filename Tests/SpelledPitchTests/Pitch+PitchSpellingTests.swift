//
//  Pitch+PitchSpellingTests.swift
//  SpelledPitch
//
//  Created by James Bean on 5/9/16.
//
//

import XCTest
import Pitch
@testable import SpelledPitch

class Pitch_PitchSpellingTests: XCTestCase {

    func test60DefaultSpellingC() {
        let pitch = Pitch(noteNumber: 60.0)
        XCTAssert(pitch.defaultSpelling == PitchSpelling(.c))
    }
    
    func test61PitchSpellingsCSharpDFlat() {
        let pitch = Pitch(noteNumber: 61.0)
        XCTAssert(pitch.spellings == [PitchSpelling(.c, .sharp), PitchSpelling(.d, .flat)])
    }
    
    func test61DefaultSpellingD() {
        let pitch = Pitch(noteNumber: 62.0)
        XCTAssert(pitch.defaultSpelling == PitchSpelling(.d))
    }
}
