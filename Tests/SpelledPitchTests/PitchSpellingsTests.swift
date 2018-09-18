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
        stride(from: 0.0, to: 12.0, by: 0.25).map(NoteNumber.init).map(Pitch.Class.init).forEach {
            XCTAssertNotNil(EDO48.defaultSpelling(forPitchClass: $0))
        }
    }

    func testMiddleCPitchSpelling() {
        XCTAssertEqual(
            EDO48.defaultSpelling(forPitchClass: 0)!,
            Pitch.Spelling(.c)
        )
    }
}
