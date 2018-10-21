//
//  PitchSpellerTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 10/16/18.
//

import XCTest
import DataStructures
@testable import SpelledPitch

class PitchSpellerTests: XCTestCase {

    // MARK: - AssignedNode

    func testAssignedNodeComparable() {
        let a = PitchSpeller.AssignedNode(Cross(0,.down), .down)
        let b = PitchSpeller.AssignedNode(Cross(1,.up), .down)
        XCTAssertLessThan(a,b)
    }

    func testSpellCF() {
        let pitchSpeller = PitchSpeller(pitches: [0:60,1:65])
        let _ = pitchSpeller.spell()
        // FIXME: Add assertion
    }
}
