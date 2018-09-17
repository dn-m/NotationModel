//
//  WetherfieldTests.swift
//  PitchSpellerTests
//
//  Created by James Bean on 5/29/18.
//

import XCTest
import Foundation
import Pitch
@testable import PitchSpeller

class WetherfieldTests: XCTestCase {
    
    func testInitMonadNodeCount() {
        let speller = PitchSpeller(pitches: [60], parsimonyPivot: Pitch.Spelling(.d))
        XCTAssertEqual(speller.flowNetwork.internalNodes.count, 2)
    }

    func testInitDyadNodeCount() {
        let speller = PitchSpeller(pitches: [60,61], parsimonyPivot: Pitch.Spelling(.d))
        XCTAssertEqual(speller.flowNetwork.internalNodes.count, 4)
    }

    func testEdgeUpdating() {
        let speller = PitchSpeller(pitches: [60,61,66], parsimonyPivot: Pitch.Spelling(.d))
        let flowNetwork = speller.flowNetwork
        flowNetwork.internalNodes.forEach { print($0) }
    }
}
