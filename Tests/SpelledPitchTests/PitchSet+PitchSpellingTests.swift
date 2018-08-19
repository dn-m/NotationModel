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

//class PitchSet_PitchSpellingTests: XCTestCase {
//
//    func testEmptyEmpty() {
//        let pitchSet: Set<Pitch> = []
//        XCTAssertEqual(pitchSet.spelledWithDefaultSpelling, [])
//    }
//
//    func testMiddleC() {
//        let pitchSet: Set<Pitch> = [60]
//        XCTAssertEqual(
//            pitchSet.spelledWithDefaultSpelling,
//            [SpelledPitch(Pitch.Spelling(.c), 4)]
//        )
//    }
//
//    func testPitchSet() {
//        let pitchSet: Set<Pitch> = [60, 61, 70]
//        XCTAssertEqual(
//            pitchSet.spelledWithDefaultSpelling,
//            [
//                SpelledPitch(Pitch.Spelling(.c), 4),
//                SpelledPitch(Pitch.Spelling(.c, .sharp), 4),
//                SpelledPitch(Pitch.Spelling(.b, .flat), 4)
//            ]
//        )
//    }
//}
