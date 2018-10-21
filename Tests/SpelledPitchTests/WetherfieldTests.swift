//
//  WetherfieldTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/21/18.
//

import XCTest
import Foundation
import Pitch
@testable import SpelledPitch

class WetherfieldTests: XCTestCase {

    func testInitMonadNodeCount() {
        let speller = PitchSpeller(pitches: [0:60], parsimonyPivot: Pitch.Spelling(.d))
        XCTAssertEqual(speller.flowNetwork.internalNodes.count, 2)
    }

    func testInitDyadNodeCount() {
        let speller = PitchSpeller(pitches: [0:60,1:61], parsimonyPivot: Pitch.Spelling(.d))
        XCTAssertEqual(speller.flowNetwork.internalNodes.count, 4)
    }
}
