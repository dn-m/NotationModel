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
    
    func testSpellingInverterPitchClass4() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.d,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.flat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
    
    func testSpellingInverterPitchClass5() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.sharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.g,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
    
    func testSpellingInverterPitchClass6() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.sharp)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.g,.flat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
    
    func testSpellingInverterPitchClass7() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.g,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
    
    func testSpellingInverterPitchClass9() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.g,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
    
    func testSpellingInverterPitchClass10() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.flat)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.sharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.c,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
    
    func testSpellingInverterPitchClass11() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.c,.flat)])
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterNeutral.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.up),.up))))
        XCTAssertTrue(spellingInverterUp.flowNetwork.contains(.internal(.init(.init(1,.down),.up))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.up),.down))))
        XCTAssertTrue(spellingInverterDown.flowNetwork.contains(.internal(.init(.init(1,.down),.down))))
    }
}
