//
//  PitchClassSetSpellerTests.swift
//  SpelledPitch
//
//  Created by James Bean on 8/25/16.
//
//

/*
import XCTest
import Pitch
@testable import SpelledPitch

class PitchClassSetSpellerTests: XCTestCase {

    // MARK: - Node Rule tests
    
    func testDoubleSharpOrDoubleFlatPenalized() {
        [Pitch.Spelling(.c, .doubleSharp), Pitch.Spelling(.g, .doubleFlat)].forEach {
            XCTAssertEqual(doubleSharpOrDoubleFlat(1)($0), 1)
        }
    }
    
    func testDoubleSharpOrDoubleFlatNotPenalized() {
        [Pitch.Spelling(.a, .threeQuarterSharp), Pitch.Spelling(.f, .quarterFlat)].forEach {
            XCTAssertEqual(doubleSharpOrDoubleFlat(1)($0), 0)
        }
    }
    
    func testThreeQuarterSharpOrThreeQuarterFlatPenalized() {
        [Pitch.Spelling(.d, .threeQuarterSharp), Pitch.Spelling(.e, .threeQuarterFlat)].forEach {
            XCTAssertEqual(threeQuarterSharpOrThreeQuarterFlat(1)($0), 1)
        }
    }
    
    func testThreeQuarterSharpOrThreeQuarterFlatNotPenalized() {
        [Pitch.Spelling(.d), Pitch.Spelling(.e, .sharp)].forEach {
            XCTAssertEqual(threeQuarterSharpOrThreeQuarterFlat(1)($0), 0)
        }
    }
    
    func testQuarterStepEighthStepCombinationPenalized() {
        let a = Pitch.Spelling(.d, .quarterSharp, .down)
        let b = Pitch.Spelling(.e, .threeQuarterFlat, .up)
        [a,b].forEach {
            XCTAssertEqual(quarterStepEighthStepCombination(1.0)($0), 1)
        }
    }
    
    func testQuarterStepEighthStepCombinationNotPenalized() {
        [Pitch.Spelling(.c), Pitch.Spelling(.b, .flat)].forEach {
            XCTAssertEqual(quarterStepEighthStepCombination(1.0)($0), 0)
        }
    }
    
    // MARK: - Edge Rule tests
    
    func testUnisonPenalized() {
        let a = (Pitch.Spelling(.c, .sharp), Pitch.Spelling(.c, .sharp, .down))
        let b = (Pitch.Spelling(.a, .quarterFlat), Pitch.Spelling(.a, .natural))
        [a,b].forEach { XCTAssertEqual(unison(1)($0), 1) }
    }
    
    func testUnisonNotPenalized() {
        let a = (Pitch.Spelling(.c, .sharp), Pitch.Spelling(.f, .sharp, .down))
        let b = (Pitch.Spelling(.a, .quarterFlat), Pitch.Spelling(.f))
        [a,b].forEach { XCTAssertEqual(unison(1)($0), 0) }
    }
    
    /// - FIXME: This currently crashes `NamedInterval.quality`.
    func DISABLED_testAugmentedOrDiminishedPenalized() {
        let a = (Pitch.Spelling(.c, .sharp), Pitch.Spelling(.f))
        let b = (Pitch.Spelling(.a, .flat), Pitch.Spelling(.b))
        [a,b].forEach { XCTAssertEqual(augmentedOrDiminished(1)($0), 1) }
    }
    
    /// - FIXME: This currently crashes `NamedInterval.quality`. 
    func DISABLED_testAugmentedOrDiminishedNotPenalized() {
        let a = (Pitch.Spelling(.c, .sharp), Pitch.Spelling(.f, .sharp))
        let b = (Pitch.Spelling(.a, .flat), Pitch.Spelling(.c))
        [a,b].forEach { XCTAssertEqual(augmentedOrDiminished(1)($0), 0) }
    }
    
    func testCrossoverPenalized() {
        let a = (Pitch.Spelling(.c, .doubleSharp), Pitch.Spelling(.d))
        let b = (Pitch.Spelling(.f, .quarterSharp), Pitch.Spelling(.g, .doubleFlat))
        [a,b].forEach { XCTAssertEqual(crossover(1)($0), 1) }
    }
    
    func testCrossoverNotPenalized() {
        let a = (Pitch.Spelling(.b), Pitch.Spelling(.c))
        let b = (Pitch.Spelling(.a), Pitch.Spelling(.f, .sharp))
        [a,b].forEach { XCTAssertEqual(crossover(1)($0), 0) }
    }
    
    func testFlatSharpIncompatibilityPenalized() {
        let a = (Pitch.Spelling(.c, .sharp), Pitch.Spelling(.e, .flat))
        let b = (Pitch.Spelling(.f, .quarterSharp), Pitch.Spelling(.g, .doubleFlat))
        [a,b].forEach { XCTAssertEqual(flatSharpIncompatibility(1)($0), 1) }
    }
    
    func testFlatSharpIncompatibilityNotPenalized() {
        let a = (Pitch.Spelling(.c), Pitch.Spelling(.d, .sharp))
        let b = (Pitch.Spelling(.f, .quarterSharp), Pitch.Spelling(.g, .sharp))
        [a,b].forEach { XCTAssertEqual(flatSharpIncompatibility(1)($0), 0) }
    }
    
    // MARK: - Speller tests
    
    private func assert(
        _ spelledPitchClassSet: SpelledPitchClassSet,
        isEqualTo expected: [Pitch.Spelling]
    )
    {
        let expected = SpelledPitchClassSet(expected.map(SpelledPitchClass.init))
        XCTAssertEqual(spelledPitchClassSet, expected)
    }
    
    func testDiatonicMonad() {
        let spelledPitchClassSet = PitchClassSetSpeller([0]).spell()
        assert(spelledPitchClassSet, isEqualTo: [Pitch.Spelling(.c)])
    }
    
    func testChromaticMonad() {
        assert(PitchClassSetSpeller([1]).spell(), isEqualTo: [Pitch.Spelling(.c, .sharp)])
        assert(PitchClassSetSpeller([3]).spell(), isEqualTo: [Pitch.Spelling(.e, .flat)])
        assert(PitchClassSetSpeller([6]).spell(), isEqualTo: [Pitch.Spelling(.f, .sharp)])
        assert(PitchClassSetSpeller([8]).spell(), isEqualTo: [Pitch.Spelling(.a, .flat)])
        assert(PitchClassSetSpeller([10]).spell(), isEqualTo: [Pitch.Spelling(.b, .flat)])
    }
    
    // FIXME: Abstract this to an array: [(Float, (.letterName, .quarterStep))]
    func testQuarterToneMonad() {
        assert(PitchClassSetSpeller([0.5]).spell(), isEqualTo: [Pitch.Spelling(.c, .quarterSharp)])
        assert(PitchClassSetSpeller([1.5]).spell(), isEqualTo: [Pitch.Spelling(.d, .quarterFlat)])
        assert(PitchClassSetSpeller([2.5]).spell(), isEqualTo: [Pitch.Spelling(.d, .quarterSharp)])
        assert(PitchClassSetSpeller([3.5]).spell(), isEqualTo: [Pitch.Spelling(.e, .quarterFlat)])
        assert(PitchClassSetSpeller([4.5]).spell(), isEqualTo: [Pitch.Spelling(.e, .quarterSharp)])
        assert(PitchClassSetSpeller([5.5]).spell(), isEqualTo: [Pitch.Spelling(.f, .quarterSharp)])
        assert(PitchClassSetSpeller([6.5]).spell(), isEqualTo: [Pitch.Spelling(.g, .quarterFlat)])
        assert(PitchClassSetSpeller([7.5]).spell(), isEqualTo: [Pitch.Spelling(.g, .quarterSharp)])
        assert(PitchClassSetSpeller([8.5]).spell(), isEqualTo: [Pitch.Spelling(.a, .quarterFlat)])
        assert(PitchClassSetSpeller([9.5]).spell(), isEqualTo: [Pitch.Spelling(.a, .quarterSharp)])
        assert(PitchClassSetSpeller([10.5]).spell(), isEqualTo: [Pitch.Spelling(.b, .quarterFlat)])
        assert(PitchClassSetSpeller([11.5]).spell(), isEqualTo: [Pitch.Spelling(.b, .quarterSharp)])
    }
    
    func testDiatonicDyad() {
        let dyad: PitchClassSet = [0,2]
        assert(PitchClassSetSpeller(dyad).spell(), isEqualTo: [Pitch.Spelling(.c), Pitch.Spelling(.d)])
    }
    
    func testChromaticDiatonicDyad() {
        assert(
            PitchClassSetSpeller([1,2]).spell(),
            isEqualTo: [Pitch.Spelling(.c, .sharp), Pitch.Spelling(.d)]
        )
    }
    
    /// - note: Consider (d flat, e flat) vs (c sharp, d sharp)
    func testChromaticDyad() {
        assert(
            PitchClassSetSpeller([1,3]).spell(),
            isEqualTo: [Pitch.Spelling(.c, .sharp), Pitch.Spelling(.d, .sharp)]
        )
    }
    
    // FIXME: Currently crashing named interval creation
    /*
    func testQuarterStepMixedDyad() {
        // 0, 0.5
        assert(
            PitchClassSetSpeller([0,0.5]).spell(),
            isEqualTo: [Pitch.Spelling(.c), Pitch.Spelling(.d, .threeQuarterFlat)]
        )
    }
    */

    func testDiatonicTriad() {
        assert(
            PitchClassSetSpeller([0,2,4]).spell(),
            isEqualTo: [Pitch.Spelling(.c), Pitch.Spelling(.d), Pitch.Spelling(.e)]
        )
    }
}
*/
