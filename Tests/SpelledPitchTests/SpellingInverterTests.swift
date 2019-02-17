//
//  SpellingInverterTests.swift
//  SpelledPitchTests
//
//  Created by Benjamin Wetherfield on 2/16/19.
//

import XCTest
import DataStructures
import Pitch
@testable import SpelledPitch

class SpellingInverterTests: XCTestCase {
    
    func testSpellingInverterPitchClass2() {
        let spellingInverterD = SpellingInverter(spellings: [1: Pitch.Spelling(.d)])
        let spellingInverterCx = SpellingInverter(spellings: [1: Pitch.Spelling(.c,.doubleSharp)])
        let spellingInverterEbb = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.doubleFlat)])
        XCTAssertTrue(spellingInverterD.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterD.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterCx.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterCx.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterEbb.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterEbb.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
}
