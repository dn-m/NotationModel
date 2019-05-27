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
        XCTAssertEqual(dependencies.adjacencies[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .down)),
            .internal(Cross<Pitch.Class, Tendency>(10, .up))
        )], Set([]))
        XCTAssertEqual(dependencies.adjacencies[SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(10, .down))
        )], Set([]))
        
        XCTAssertEqual(dependencies.adjacencies[SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(6, .down))
        )], Set([SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .down)),
            .internal(Cross<Pitch.Class, Tendency>(10, .up))
            )]
        ))
        XCTAssertEqual(dependencies.adjacencies[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(10, .up)),
            .sink
        )], Set([SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .down)),
            .internal(Cross<Pitch.Class, Tendency>(10, .up))
            )]
        ))
        
        XCTAssertEqual(dependencies.adjacencies[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(10, .down)),
            .internal(Cross<Pitch.Class, Tendency>(6, .up))
        )], Set([SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(10, .down))
            )]
        ))
        XCTAssertEqual(dependencies.adjacencies[SpellingInverter.PitchedEdge(
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
        XCTAssertTrue(spellingInverter.findDependencies().containsCycle())
    }
    
    func testCycleCheckFSharpASharpGFlatBFlatSubGraphs() {
        var spellingInverter = SpellingInverter(spellings: [
            1: Pitch.Spelling(.f,.sharp),
            2: Pitch.Spelling(.a,.sharp),
            3: Pitch.Spelling(.g,.flat),
            4: Pitch.Spelling(.b,.flat)
            ])
        spellingInverter.partition([1:0, 2:0, 3:1, 4:1])
        XCTAssertTrue(spellingInverter.findDependencies().containsCycle())
    }
    
    func testConsistentBasicExample() {
        var spellingInverter = SpellingInverter(spellings: [
            1: Pitch.Spelling(.f, .sharp),
            2: Pitch.Spelling(.a, .sharp),
            3: Pitch.Spelling(.f, .sharp),
            4: Pitch.Spelling(.a, .sharp),
            5: Pitch.Spelling(.c, .sharp)
            ])
        spellingInverter.partition([
            1: 0,
            2: 0,
            3: 1,
            4: 1,
            5: 1
            ])
        XCTAssertFalse(spellingInverter.findDependencies().containsCycle())
    }
    
    func testSemitones() {
        let semitones: [Pitch.Spelling] = [
            .c,
            Pitch.Spelling(.d, .flat),
            Pitch.Spelling(.c, .sharp),
            .d,
            .d,
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.d, .sharp),
            .e,
            .e,
            .f,
            .f,
            Pitch.Spelling(.g, .flat),
            Pitch.Spelling(.f, .sharp),
            .g,
            .g,
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.g, .sharp),
            .a,
            .a,
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.a, .sharp),
            .b,
            .b,
            .c
        ]
        var spellingInverter = SpellingInverter(spellings: semitones)
        let pairing = GraphScheme<FlowNode<Int>> { edge in
            switch (edge.a, edge.b) {
            case let (.internal(a), .internal(b)):
                return ((a % 2 == 0) && (b % 2 == 1) && (b - 1 == a)) ||
                    ((a % 2 == 1) && (b % 2 == 0) && (a - 1 == b))
            default: return true
            }
        }
        spellingInverter.mask(pairing)
        XCTAssertFalse(spellingInverter.findDependencies().containsCycle())
    }
    
    func testTones() {
        let tones: [Pitch.Spelling] = [
            .c,
            .d,
            Pitch.Spelling(.d, .flat),
            Pitch.Spelling(.e, .flat),
            .d,
            .e,
            Pitch.Spelling(.e, .flat),
            .f,
            .e,
            Pitch.Spelling(.f, .sharp),
            .f,
            .g,
            Pitch.Spelling(.g, .flat),
            Pitch.Spelling(.a, .flat),
            .g,
            .a,
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.b, .flat),
            .a,
            .b,
            Pitch.Spelling(.b, .flat),
            .c,
            .b,
            Pitch.Spelling(.c, .sharp)
        ]
        var spellingInverter = SpellingInverter(spellings: tones)
        let pairing = GraphScheme<FlowNode<Int>> { edge in
            switch (edge.a, edge.b) {
            case let (.internal(a), .internal(b)):
                return ((a % 2 == 0) && (b % 2 == 1) && (b - 1 == a)) ||
                    ((a % 2 == 1) && (b % 2 == 0) && (a - 1 == b))
            default: return true
            }
        }
        spellingInverter.mask(pairing)
        XCTAssertFalse(spellingInverter.findDependencies().containsCycle())
    }
    
    func testMinorThirds() {
        let minorThirds: [Pitch.Spelling] = [
            .c,
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.c, .sharp),
            .e,
            .d,
            .f,
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.g, .flat),
            .e,
            .g,
            .f,
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.f, .sharp),
            .a,
            .g,
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.g, .sharp),
            .b,
            .a,
            .c,
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.d, .flat),
            .b,
            .d
        ]
        var spellingInverter = SpellingInverter(spellings: minorThirds)
        let pairing = GraphScheme<FlowNode<Int>> { edge in
            switch (edge.a, edge.b) {
            case let (.internal(a), .internal(b)):
                return ((a % 2 == 0) && (b % 2 == 1) && (b - 1 == a)) ||
                    ((a % 2 == 1) && (b % 2 == 0) && (a - 1 == b))
            default: return true
            }
        }
        spellingInverter.mask(pairing)
        XCTAssertFalse(spellingInverter.findDependencies().containsCycle())
    }
    
    func testMajorThirds() {
        let majorThirds: [Pitch.Spelling] = [
            .c,
            .e,
            Pitch.Spelling(.d, .flat),
            .f,
            .d,
            Pitch.Spelling(.f, .sharp),
            Pitch.Spelling(.e, .flat),
            .g,
            .e,
            Pitch.Spelling(.g, .sharp),
            .f,
            .a,
            Pitch.Spelling(.g, .flat),
            Pitch.Spelling(.b, .flat),
            .g,
            .b,
            Pitch.Spelling(.a, .flat),
            .c,
            .a,
            Pitch.Spelling(.c, .sharp),
            Pitch.Spelling(.b, .flat),
            .d,
            .b,
            Pitch.Spelling(.d, .sharp)
        ]
        var spellingInverter = SpellingInverter(spellings: majorThirds)
        let pairing = GraphScheme<FlowNode<Int>> { edge in
            switch (edge.a, edge.b) {
            case let (.internal(a), .internal(b)):
                return ((a % 2 == 0) && (b % 2 == 1) && (b - 1 == a)) ||
                    ((a % 2 == 1) && (b % 2 == 0) && (a - 1 == b))
            default: return true
            }
        }
        spellingInverter.mask(pairing)
        XCTAssertFalse(spellingInverter.findDependencies().containsCycle())
    }
    
    func testPerfectFourths() {
        let perfectFourths: [Pitch.Spelling] = [
            .c,
            .f,
            Pitch.Spelling(.d, .flat),
            Pitch.Spelling(.g, .flat),
            .d,
            .g,
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.a, .flat),
            .e,
            .a,
            .f,
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.f, .sharp),
            .b,
            .g,
            .c,
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.d, .flat),
            .a,
            .d,
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.e, .flat),
            .b,
            .e
        ]
        var spellingInverter = SpellingInverter(spellings: perfectFourths)
        let pairing = GraphScheme<FlowNode<Int>> { edge in
            switch (edge.a, edge.b) {
            case let (.internal(a), .internal(b)):
                return ((a % 2 == 0) && (b % 2 == 1) && (b - 1 == a)) ||
                    ((a % 2 == 1) && (b % 2 == 0) && (a - 1 == b))
            default: return true
            }
        }
        spellingInverter.mask(pairing)
        XCTAssertFalse(spellingInverter.findDependencies().containsCycle())
    }
    
    func testLargeSetOfDyadsWithoutCycles() {
        let semitones: [Pitch.Spelling] = [
            .c,
            Pitch.Spelling(.d, .flat),
            Pitch.Spelling(.c, .sharp),
            .d,
            .d,
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.d, .sharp),
            .e,
            .e,
            .f,
            .f,
            Pitch.Spelling(.g, .flat),
            Pitch.Spelling(.f, .sharp),
            .g,
            .g,
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.g, .sharp),
            .a,
            .a,
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.a, .sharp),
            .b,
            .b,
            .c
        ]
        let tones: [Pitch.Spelling] = [
            .c,
            .d,
//            Pitch.Spelling(.d, .flat),
//            Pitch.Spelling(.e, .flat),
            .d,
            .e,
            Pitch.Spelling(.e, .flat),
            .f,
            .e,
            Pitch.Spelling(.f, .sharp),
            .f,
            .g,
            Pitch.Spelling(.g, .flat),
            Pitch.Spelling(.a, .flat),
            .g,
            .a,
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.b, .flat),
            .a,
            .b,
            Pitch.Spelling(.b, .flat),
            .c,
            .b,
            Pitch.Spelling(.c, .sharp)
        ]
        let minorThirds: [Pitch.Spelling] = [
            .c,
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.c, .sharp),
            .e,
            .d,
            .f,
//            Pitch.Spelling(.e, .flat),
//            Pitch.Spelling(.g, .flat),
            .e,
            .g,
            .f,
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.f, .sharp),
            .a,
            .g,
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.g, .sharp),
            .b,
            .a,
            .c,
//            Pitch.Spelling(.b, .flat),
//            Pitch.Spelling(.d, .flat),
            .b,
            .d
        ]
        let majorThirds: [Pitch.Spelling] = [
            .c,
            .e,
            Pitch.Spelling(.d, .flat),
            .f,
            .d,
            Pitch.Spelling(.f, .sharp),
            Pitch.Spelling(.e, .flat),
            .g,
            .e,
            Pitch.Spelling(.g, .sharp),
            .f,
            .a,
//            Pitch.Spelling(.g, .flat),
//            Pitch.Spelling(.b, .flat),
            .g,
            .b,
            Pitch.Spelling(.a, .flat),
            .c,
            .a,
            Pitch.Spelling(.c, .sharp),
            Pitch.Spelling(.b, .flat),
            .d,
            .b,
            Pitch.Spelling(.d, .sharp)
        ]
        let perfectFourths: [Pitch.Spelling] = [
            .c,
            .f,
            Pitch.Spelling(.d, .flat),
            Pitch.Spelling(.g, .flat),
            .d,
            .g,
            Pitch.Spelling(.e, .flat),
            Pitch.Spelling(.a, .flat),
            .e,
            .a,
            .f,
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.f, .sharp),
            .b,
            .g,
            .c,
            Pitch.Spelling(.a, .flat),
            Pitch.Spelling(.d, .flat),
            .a,
            .d,
            Pitch.Spelling(.b, .flat),
            Pitch.Spelling(.e, .flat),
            .b,
            .e
        ]
        let dyads = semitones + tones + minorThirds + majorThirds + perfectFourths
        var spellingInverter = SpellingInverter(spellings: dyads)
        let pairing = GraphScheme<FlowNode<Int>> { edge in
            switch (edge.a, edge.b) {
            case let (.internal(a), .internal(b)):
                return ((a % 2 == 0) && (b % 2 == 1) && (b - 1 == a)) ||
                    ((a % 2 == 1) && (b % 2 == 0) && (a - 1 == b))
            default: return true
            }
        }
        spellingInverter.mask(pairing)
        XCTAssertFalse(spellingInverter.findDependencies().containsCycle())
    }
    
    func testCycleCheckFSharpASharpGFlatBFlatSubGraphsAfterStronglyConnectedComponentsClumped() {
        var spellingInverter = SpellingInverter(spellings: [
            1: Pitch.Spelling(.f,.sharp),
            2: Pitch.Spelling(.a,.sharp),
            3: Pitch.Spelling(.g,.flat),
            4: Pitch.Spelling(.b,.flat)
            ])
        spellingInverter.partition([1:0, 2:0, 3:1, 4:1])
        XCTAssertFalse(spellingInverter.findDependencies().DAGify().containsCycle())
    }
    
    func testWeightsDerivationWithSimpleCycle() {
        var spellingInverter = SpellingInverter(spellings: [
            1: Pitch.Spelling(.f,.sharp),
            2: Pitch.Spelling(.a,.sharp),
            3: Pitch.Spelling(.g,.flat),
            4: Pitch.Spelling(.b,.flat)
            ])
        spellingInverter.partition([1:0, 2:0, 3:1, 4:1])
        let weights = spellingInverter.generateWeights()
        XCTAssertEqual(weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .up)),
            .sink
        )], weights[SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(10, .down))
            )])
        XCTAssertLessThan(weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .up)),
            .sink
        )]!, weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .up)),
            .internal(Cross<Pitch.Class, Tendency>(10, .down))
        )]!)

        XCTAssertLessThan(weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .down)),
            .internal(Cross<Pitch.Class, Tendency>(10, .up))
        )]!, weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(10, .up)),
            .sink
        )]!)
        XCTAssertLessThan(weights[SpellingInverter.PitchedEdge(
            .internal(Cross<Pitch.Class, Tendency>(6, .down)),
            .internal(Cross<Pitch.Class, Tendency>(10, .up))
        )]!, weights[SpellingInverter.PitchedEdge(
            .source,
            .internal(Cross<Pitch.Class, Tendency>(6, .down))
        )]!)

    }
}
