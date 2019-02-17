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
    
    func testSpellingInverterPitchClass0() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.c)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.sharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.d,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
    
    func testSpellingInverterPitchClass1() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.c, .sharp)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.d,.flat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
    
    func testSpellingInverterPitchClass2() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.d)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.c,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
    
    func testSpellingInverterPitchClass3() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.flat)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.d,.sharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
}
