//
//  PitchSpellingsTests.swift
//  SpelledPitch
//
//  Created by James Bean on 5/2/16.
//
//

import XCTest
import Pitch
import SpelledPitch

class PitchSpellingsTests: XCTestCase {

    func testDefaultPitchSpellingsForEighthToneResolution() {
        stride(from: Double(0), to: 12.0, by: 0.25).forEach {
            XCTAssertNotNil(
                EDO48.defaultSpelling(forPitchClass: Pitch.Class(noteNumber: NoteNumber($0)))
            )
        }
    }

    func testMiddleCPitchSpelling() {
        XCTAssertEqual(
            EDO48.defaultSpelling(forPitchClass: Pitch.middleC.class)!,
            Pitch.Spelling(.c)
        )
    }
}
