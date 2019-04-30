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
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass1() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.c, .sharp)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.d,.flat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass2() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.d)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.c,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass3() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.flat)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.d,.sharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass4() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.d,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.flat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass5() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.sharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.g,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass6() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.sharp)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.e,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.g,.flat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass7() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.g,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.f,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass8() {
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.flat)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.g,.sharp)])
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
    }
    
    func testSpellingInverterPitchClass9() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.g,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass10() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.flat)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.sharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.c,.doubleFlat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterPitchClass11() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.c,.flat)])
        XCTAssertTrue(spellingInverterNeutral.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterNeutral.contains((1,.down),.down))
        XCTAssertTrue(spellingInverterUp.contains((1,.up),.up))
        XCTAssertTrue(spellingInverterUp.contains((1,.down),.up))
        XCTAssertTrue(spellingInverterDown.contains((1,.up),.down))
        XCTAssertTrue(spellingInverterDown.contains((1,.down),.down))
    }
    
    func testSpellingInverterEdgesPitchClass11() {
        let spellingInverterNeutral = SpellingInverter(spellings: [1: Pitch.Spelling(.b,.natural)])
        let spellingInverterUp = SpellingInverter(spellings: [1: Pitch.Spelling(.a,.doubleSharp)])
        let spellingInverterDown = SpellingInverter(spellings: [1: Pitch.Spelling(.c,.flat)])
        XCTAssertTrue(spellingInverterNeutral.containsEdge(from: (1, .up), to: (1, .down)))
        XCTAssertTrue(spellingInverterUp.containsEdge(from: (1, .up), to: (1, .down)))
        XCTAssertTrue(spellingInverterDown.containsEdge(from: (1, .up), to: (1, .down)))
        XCTAssertTrue(spellingInverterNeutral.containsSourceEdge(to: (1, .down)))
        XCTAssertTrue(spellingInverterUp.containsSourceEdge(to: (1, .down)))
        XCTAssertTrue(spellingInverterDown.containsSourceEdge(to: (1, .down)))
        XCTAssertTrue(spellingInverterNeutral.containsSinkEdge(from: (1,.up)))
        XCTAssertTrue(spellingInverterUp.containsSinkEdge(from: (1,.up)))
        XCTAssertTrue(spellingInverterDown.containsSinkEdge(from: (1,.up)))
    }
    
    func testSpellingInverterAdjacenciesFSharpASharp() {
        let spellingInverter = SpellingInverter(spellings: [
            1: Pitch.Spelling(.f,.sharp),
            2: Pitch.Spelling(.a, .sharp)
            ])
        XCTAssertTrue(spellingInverter.containsEdge(from: (1, .up), to: (1, .down)))
        XCTAssertTrue(spellingInverter.containsSourceEdge(to: (1, .down)))
        XCTAssertTrue(spellingInverter.containsSinkEdge(from: (1,.up)))
        
        XCTAssertTrue(spellingInverter.containsEdge(from: (2, .up), to: (2, .down)))
        XCTAssertFalse(spellingInverter.containsEdge(from: (2, .down), to: (2, .up)))
        XCTAssertTrue(spellingInverter.containsSourceEdge(to: (2, .down)))
        XCTAssertTrue(spellingInverter.containsSinkEdge(from: (2,.up)))
        
        XCTAssertTrue(spellingInverter.containsEdge(from: (1, .up), to: (2, .down)))
        XCTAssertTrue(spellingInverter.containsEdge(from: (2, .up), to: (1, .down)))
        XCTAssertTrue(spellingInverter.containsEdge(from: (1, .down), to: (2, .up)))
        XCTAssertTrue(spellingInverter.containsEdge(from: (2, .down), to: (1, .up)))

        XCTAssertFalse(spellingInverter.containsEdge(from: (1, .up), to: (2, .up)))
        XCTAssertFalse(spellingInverter.containsEdge(from: (2, .up), to: (1, .up)))
        XCTAssertFalse(spellingInverter.containsEdge(from: (1, .down), to: (2, .down)))
        XCTAssertFalse(spellingInverter.containsEdge(from: (2, .down), to: (1, .down)))
    }
    
    func testDependenciesFSharpASharp() {
        let spellingInverter = SpellingInverter(spellings: [
            1: Pitch.Spelling(.f,.sharp),
            2: Pitch.Spelling(.a, .sharp)
            ])
        let dependencies = spellingInverter.findDependencies()
        XCTAssertEqual(dependencies[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .down)),
            .internal(Cross<Pitch.Class, Tendency>(10, .up))
        )], Set([]))
        XCTAssertEqual(dependencies[SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(10, .down))
        )], Set([]))
        
        XCTAssertEqual(dependencies[SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(6, .down))
        )], Set([SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .down)),
            .internal(Cross<Pitch.Class, Tendency>(10, .up))
            )]
        ))
        XCTAssertEqual(dependencies[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(10, .up)),
            .sink
        )], Set([SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .down)),
            .internal(Cross<Pitch.Class, Tendency>(10, .up))
            )]
        ))
        
        XCTAssertEqual(dependencies[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(10, .down)),
            .internal(Cross<Pitch.Class, Tendency>(6, .up))
        )], Set([SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(10, .down))
            )]
        ))
        XCTAssertEqual(dependencies[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .up)),
            .sink
        )], Set([SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(10, .down))
            )]
        ))
    }
    
    func testWeightsFSharpASharp() {
        let spellingInverter = SpellingInverter(spellings: [
            1: Pitch.Spelling(.f,.sharp),
            2: Pitch.Spelling(.a, .sharp)
            ])
        let weights = spellingInverter.generateWeights()
        XCTAssertEqual(weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .down)),
            .internal(Cross<Pitch.Class, Tendency>(10, .up))
        )], 1)
        XCTAssertEqual(weights[SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(10, .down))
        )], 1)
        
        XCTAssertEqual(weights[SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(6, .down))
        )], 2)
        XCTAssertEqual(weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(10, .up)),
            .sink
        )], 2)
        
        XCTAssertEqual(weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(10, .down)),
            .internal(Cross<Pitch.Class, Tendency>(6, .up))
        )], 2)
        XCTAssertEqual(weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .up)),
            .sink
        )], 2)
    }
    
    func testCycleCheckFSharpASharpGFlatBFlat() {
        var spellingInverter = SpellingInverter(spellings: [
            1: Pitch.Spelling(.f,.sharp),
            2: Pitch.Spelling(.a,.sharp),
            3: Pitch.Spelling(.g,.flat),
            4: Pitch.Spelling(.b,.flat)
            ])
        let scheme = GraphScheme<FlowNode<Int>> { edge in
            (edge.contains(.internal(1)) && edge.contains(.internal(2)))
                || (edge.contains(.internal(3)) && edge.contains(.internal(4)))
            || edge.contains(.sink) || edge.contains(.source)
        }
        spellingInverter.mask(scheme)
        XCTAssertTrue(spellingInverter.findCycle(spellingInverter.findDependencies()))
    }
}
