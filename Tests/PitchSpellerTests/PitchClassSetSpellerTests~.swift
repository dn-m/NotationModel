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
        [PitchSpelling(.c, .doubleSharp), PitchSpelling(.g, .doubleFlat)].forEach {
            XCTAssertEqual(doubleSharpOrDoubleFlat(1)($0), 1)
        }
    }
    
    func testDoubleSharpOrDoubleFlatNotPenalized() {
        [PitchSpelling(.a, .threeQuarterSharp), PitchSpelling(.f, .quarterFlat)].forEach {
            XCTAssertEqual(doubleSharpOrDoubleFlat(1)($0), 0)
        }
    }
    
    func testThreeQuarterSharpOrThreeQuarterFlatPenalized() {
        [PitchSpelling(.d, .threeQuarterSharp), PitchSpelling(.e, .threeQuarterFlat)].forEach {
            XCTAssertEqual(threeQuarterSharpOrThreeQuarterFlat(1)($0), 1)
        }
    }
    
    func testThreeQuarterSharpOrThreeQuarterFlatNotPenalized() {
        [PitchSpelling(.d), PitchSpelling(.e, .sharp)].forEach {
            XCTAssertEqual(threeQuarterSharpOrThreeQuarterFlat(1)($0), 0)
        }
    }
    
    func testQuarterStepEighthStepCombinationPenalized() {
        let a = PitchSpelling(.d, .quarterSharp, .down)
        let b = PitchSpelling(.e, .threeQuarterFlat, .up)
        [a,b].forEach {
            XCTAssertEqual(quarterStepEighthStepCombination(1.0)($0), 1)
        }
    }
    
    func testQuarterStepEighthStepCombinationNotPenalized() {
        [PitchSpelling(.c), PitchSpelling(.b, .flat)].forEach {
            XCTAssertEqual(quarterStepEighthStepCombination(1.0)($0), 0)
        }
    }
    
    // MARK: - Edge Rule tests
    
    func testUnisonPenalized() {
        let a = (PitchSpelling(.c, .sharp), PitchSpelling(.c, .sharp, .down))
        let b = (PitchSpelling(.a, .quarterFlat), PitchSpelling(.a, .natural))
        [a,b].forEach { XCTAssertEqual(unison(1)($0), 1) }
    }
    
    func testUnisonNotPenalized() {
        let a = (PitchSpelling(.c, .sharp), PitchSpelling(.f, .sharp, .down))
        let b = (PitchSpelling(.a, .quarterFlat), PitchSpelling(.f))
        [a,b].forEach { XCTAssertEqual(unison(1)($0), 0) }
    }
    
    /// - FIXME: This currently crashes `NamedInterval.quality`.
    func DISABLED_testAugmentedOrDiminishedPenalized() {
        let a = (PitchSpelling(.c, .sharp), PitchSpelling(.f))
        let b = (PitchSpelling(.a, .flat), PitchSpelling(.b))
        [a,b].forEach { XCTAssertEqual(augmentedOrDiminished(1)($0), 1) }
    }
    
    /// - FIXME: This currently crashes `NamedInterval.quality`. 
    func DISABLED_testAugmentedOrDiminishedNotPenalized() {
        let a = (PitchSpelling(.c, .sharp), PitchSpelling(.f, .sharp))
        let b = (PitchSpelling(.a, .flat), PitchSpelling(.c))
        [a,b].forEach { XCTAssertEqual(augmentedOrDiminished(1)($0), 0) }
    }
    
    func testCrossoverPenalized() {
        let a = (PitchSpelling(.c, .doubleSharp), PitchSpelling(.d))
        let b = (PitchSpelling(.f, .quarterSharp), PitchSpelling(.g, .doubleFlat))
        [a,b].forEach { XCTAssertEqual(crossover(1)($0), 1) }
    }
    
    func testCrossoverNotPenalized() {
        let a = (PitchSpelling(.b), PitchSpelling(.c))
        let b = (PitchSpelling(.a), PitchSpelling(.f, .sharp))
        [a,b].forEach { XCTAssertEqual(crossover(1)($0), 0) }
    }
    
    func testFlatSharpIncompatibilityPenalized() {
        let a = (PitchSpelling(.c, .sharp), PitchSpelling(.e, .flat))
        let b = (PitchSpelling(.f, .quarterSharp), PitchSpelling(.g, .doubleFlat))
        [a,b].forEach { XCTAssertEqual(flatSharpIncompatibility(1)($0), 1) }
    }
    
    func testFlatSharpIncompatibilityNotPenalized() {
        let a = (PitchSpelling(.c), PitchSpelling(.d, .sharp))
        let b = (PitchSpelling(.f, .quarterSharp), PitchSpelling(.g, .sharp))
        [a,b].forEach { XCTAssertEqual(flatSharpIncompatibility(1)($0), 0) }
    }
    
    // MARK: - Speller tests
    
    private func assert(
        _ spelledPitchClassSet: SpelledPitchClassSet,
        isEqualTo expected: [PitchSpelling]
    )
    {
        let expected = SpelledPitchClassSet(expected.map(SpelledPitchClass.init))
        XCTAssertEqual(spelledPitchClassSet, expected)
    }
    
    func testDiatonicMonad() {
        let spelledPitchClassSet = PitchClassSetSpeller([0]).spell()
        assert(spelledPitchClassSet, isEqualTo: [PitchSpelling(.c)])
    }
    
    func testChromaticMonad() {
        assert(PitchClassSetSpeller([1]).spell(), isEqualTo: [PitchSpelling(.c, .sharp)])
        assert(PitchClassSetSpeller([3]).spell(), isEqualTo: [PitchSpelling(.e, .flat)])
        assert(PitchClassSetSpeller([6]).spell(), isEqualTo: [PitchSpelling(.f, .sharp)])
        assert(PitchClassSetSpeller([8]).spell(), isEqualTo: [PitchSpelling(.a, .flat)])
        assert(PitchClassSetSpeller([10]).spell(), isEqualTo: [PitchSpelling(.b, .flat)])
    }
    
    // FIXME: Abstract this to an array: [(Float, (.letterName, .quarterStep))]
    func testQuarterToneMonad() {
        assert(PitchClassSetSpeller([0.5]).spell(), isEqualTo: [PitchSpelling(.c, .quarterSharp)])
        assert(PitchClassSetSpeller([1.5]).spell(), isEqualTo: [PitchSpelling(.d, .quarterFlat)])
        assert(PitchClassSetSpeller([2.5]).spell(), isEqualTo: [PitchSpelling(.d, .quarterSharp)])
        assert(PitchClassSetSpeller([3.5]).spell(), isEqualTo: [PitchSpelling(.e, .quarterFlat)])
        assert(PitchClassSetSpeller([4.5]).spell(), isEqualTo: [PitchSpelling(.e, .quarterSharp)])
        assert(PitchClassSetSpeller([5.5]).spell(), isEqualTo: [PitchSpelling(.f, .quarterSharp)])
        assert(PitchClassSetSpeller([6.5]).spell(), isEqualTo: [PitchSpelling(.g, .quarterFlat)])
        assert(PitchClassSetSpeller([7.5]).spell(), isEqualTo: [PitchSpelling(.g, .quarterSharp)])
        assert(PitchClassSetSpeller([8.5]).spell(), isEqualTo: [PitchSpelling(.a, .quarterFlat)])
        assert(PitchClassSetSpeller([9.5]).spell(), isEqualTo: [PitchSpelling(.a, .quarterSharp)])
        assert(PitchClassSetSpeller([10.5]).spell(), isEqualTo: [PitchSpelling(.b, .quarterFlat)])
        assert(PitchClassSetSpeller([11.5]).spell(), isEqualTo: [PitchSpelling(.b, .quarterSharp)])
    }
    
    func testDiatonicDyad() {
        let dyad: PitchClassSet = [0,2]
        assert(PitchClassSetSpeller(dyad).spell(), isEqualTo: [PitchSpelling(.c), PitchSpelling(.d)])
    }
    
    func testChromaticDiatonicDyad() {
        assert(
            PitchClassSetSpeller([1,2]).spell(),
            isEqualTo: [PitchSpelling(.c, .sharp), PitchSpelling(.d)]
        )
    }
    
    /// - note: Consider (d flat, e flat) vs (c sharp, d sharp)
    func testChromaticDyad() {
        assert(
            PitchClassSetSpeller([1,3]).spell(),
            isEqualTo: [PitchSpelling(.c, .sharp), PitchSpelling(.d, .sharp)]
        )
    }
    
    // FIXME: Currently crashing named interval creation
    /*
    func testQuarterStepMixedDyad() {
        // 0, 0.5
        assert(
            PitchClassSetSpeller([0,0.5]).spell(),
            isEqualTo: [PitchSpelling(.c), PitchSpelling(.d, .threeQuarterFlat)]
        )
    }
    */

    func testDiatonicTriad() {
        assert(
            PitchClassSetSpeller([0,2,4]).spell(),
            isEqualTo: [PitchSpelling(.c), PitchSpelling(.d), PitchSpelling(.e)]
        )
    }
}
*/
