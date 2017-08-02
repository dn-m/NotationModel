//
//  ClefTests.swift
//  StaffModel
//
//  Created by James Bean on 1/16/17.
//
//

import XCTest
import Pitch
import SpelledPitch
@testable import StaffModel

class ClefTests: XCTestCase {

    func testStaffSlothMiddleC() {
        let middleC = SpelledPitch(60, Pitch.Spelling(.c))
        XCTAssertEqual(slot(.bass, middleC), 6)
        XCTAssertEqual(slot(.tenor, middleC), 2)
        XCTAssertEqual(slot(.alto, middleC), 0)
        XCTAssertEqual(slot(.treble, middleC), -6)
    }
    
    func testStaffSlotEFlatAboveMiddleC() {
        let eFlat = SpelledPitch(63, Pitch.Spelling(.e, .flat))
        XCTAssertEqual(slot(.bass, eFlat), 8)
        XCTAssertEqual(slot(.tenor, eFlat), 4)
        XCTAssertEqual(slot(.alto, eFlat), 2)
        XCTAssertEqual(slot(.treble, eFlat), -4)
    }
    
    func testStaffSlotASharpTwoOctavesBelowMiddleC() {
        let eFlat = SpelledPitch(46, Pitch.Spelling(.a, .sharp))
        XCTAssertEqual(slot(.bass, eFlat), -3)
        XCTAssertEqual(slot(.tenor, eFlat), -7)
        XCTAssertEqual(slot(.alto, eFlat), -9)
        XCTAssertEqual(slot(.treble, eFlat), -15)
    }
    
    func testStaffSlotDSharpTwoOctavesAboveMiddleC() {
        let dSharp = SpelledPitch(87, Pitch.Spelling(.d, .sharp))
        XCTAssertEqual(slot(.bass, dSharp), 21)
        XCTAssertEqual(slot(.tenor, dSharp), 17)
        XCTAssertEqual(slot(.alto, dSharp), 15)
        XCTAssertEqual(slot(.treble, dSharp), 9)
    }
}
