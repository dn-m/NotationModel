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

    func testStaffSlotMiddleC() {
        let middleC = SpelledPitch<EDO48>.middleC
        XCTAssertEqual(slot(.bass, middleC), 6)
        XCTAssertEqual(slot(.tenor, middleC), 2)
        XCTAssertEqual(slot(.alto, middleC), 0)
        XCTAssertEqual(slot(.treble, middleC), -6)
    }
    
    func testStaffSlotEFlatAboveMiddleC() {
        let eFlat = SpelledPitch<EDO48>(Pitch.Spelling(.e, .flat)), 4)
        XCTAssertEqual(slot(.bass, eFlat), 8)
        XCTAssertEqual(slot(.tenor, eFlat), 4)
        XCTAssertEqual(slot(.alto, eFlat), 2)
        XCTAssertEqual(slot(.treble, eFlat), -4)
    }

    func testStaffSlotASharpTwoOctavesBelowMiddleC() {
        let aSharp = SpelledPitch<EDO48>(Pitch.Spelling(.a, .sharp(count: 1)), 2)
        XCTAssertEqual(slot(.bass, aSharp), -3)
        XCTAssertEqual(slot(.tenor, aSharp), -7)
        XCTAssertEqual(slot(.alto, aSharp), -9)
        XCTAssertEqual(slot(.treble, aSharp), -15)
    }

    func testStaffSlotDSharpTwoOctavesAboveMiddleC() {
        let dSharp = SpelledPitch<EDO48>(Pitch.Spelling(.d, .sharp(count: 1)), 6)
        XCTAssertEqual(slot(.bass, dSharp), 21)
        XCTAssertEqual(slot(.tenor, dSharp), 17)
        XCTAssertEqual(slot(.alto, dSharp), 15)
        XCTAssertEqual(slot(.treble, dSharp), 9)
    }
}
