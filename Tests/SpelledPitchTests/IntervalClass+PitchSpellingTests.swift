//
//  IntervalClass+PitchSpellingTests.swift
//  SpelledPitch
//
//  Created by James Bean on 5/26/16.
//
//

import XCTest
import Pitch

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

class IntervalClass_PitchSpellingTests: XCTestCase {

    func testOctaveLessComplexThanPerfectFifth() {
        let p5: UnorderedInterval<Pitch.Class> = 7
        let p8: UnorderedInterval<Pitch.Class> = 0
        XCTAssert(p8.spellingPriority < p5.spellingPriority)
    }

    func testPerfectFifthLessComplexThanMajorThird() {
        let p5: UnorderedInterval<Pitch.Class> = 7
        let M3: UnorderedInterval<Pitch.Class> = 4
        XCTAssert(p5.spellingPriority < M3.spellingPriority)
    }
}
