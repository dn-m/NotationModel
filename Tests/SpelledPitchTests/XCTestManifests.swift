import XCTest

extension CompoundIntervalDescriptorTests {
    static let __allTests = [
        ("testInitTwoSpelledPitchesAscendingMajorTenth", testInitTwoSpelledPitchesAscendingMajorTenth),
        ("testInitTwoSpelledPitchesAscendingMinorSecond", testInitTwoSpelledPitchesAscendingMinorSecond),
        ("testInitTwoSpelledPitchesAscendingMinorSixth", testInitTwoSpelledPitchesAscendingMinorSixth),
        ("testInitTwoSpelledPitchesDescendingMajorSecond", testInitTwoSpelledPitchesDescendingMajorSecond),
        ("testInitTwoSpelledPitchesDescendingPerfectEleventh", testInitTwoSpelledPitchesDescendingPerfectEleventh),
        ("testInitTwoSpelledPitchesUnison", testInitTwoSpelledPitchesUnison),
    ]
}

extension FlowNetworkTests {
    static let __allTests = [
        ("testFlowNetworkAbsorbsSourceSink", testFlowNetworkAbsorbsSourceSink),
        ("testFlowNetworkMaskEmpty", testFlowNetworkMaskEmpty),
        ("testFlowNetworkMaskPullback", testFlowNetworkMaskPullback),
        ("testFlowNetworkMaskSquared", testFlowNetworkMaskSquared),
        ("testMinimumCut", testMinimumCut),
        ("testPitchSpellingTestCase", testPitchSpellingTestCase),
        ("testUnreachableMinimumCut", testUnreachableMinimumCut),
    ]
}

extension LetterNameTests {
    static let __allTests = [
        ("testDisplacedUnison", testDisplacedUnison),
        ("testLetterNameSimpleNegative", testLetterNameSimpleNegative),
        ("testLetterNameSimplePositive", testLetterNameSimplePositive),
        ("testLetterNameWrapping", testLetterNameWrapping),
    ]
}

extension PitchSpellerTests {
    static let __allTests = [
        ("testDyads", testDyads),
        ("testFailingDyads", testFailingDyads),
        ("testMonads", testMonads),
        ("testSpelledOneFiveOverDNatural", testSpelledOneFiveOverDNatural),
        ("testSpelledOneThreeOverDNatural", testSpelledOneThreeOverDNatural),
        ("testSpelledZeroOneOverDNatural", testSpelledZeroOneOverDNatural),
    ]
}

extension PitchSpellingCategoryTests {
    static let __allTests = [
        ("testLetterNamePredecessor", testLetterNamePredecessor),
        ("testLetterNameSuccessor", testLetterNameSuccessor),
        ("testNeutralLetterName", testNeutralLetterName),
        ("testPCEight_AFlat", testPCEight_AFlat),
        ("testPCEightNeutral_Nil", testPCEightNeutral_Nil),
        ("testPCEightUp_GSharp", testPCEightUp_GSharp),
        ("testPCFourDown_FFlat", testPCFourDown_FFlat),
        ("testPCFourNeutral_ENatural", testPCFourNeutral_ENatural),
        ("testPCFourUp_DDoubleSharp", testPCFourUp_DDoubleSharp),
        ("testPCOneDown_DFlat", testPCOneDown_DFlat),
        ("testPCOneNeutral_CSharp", testPCOneNeutral_CSharp),
        ("testPCOneUp_BDoubleSharp", testPCOneUp_BDoubleSharp),
        ("testPCThreeDown_FDoubleFlat", testPCThreeDown_FDoubleFlat),
        ("testPCThreeNeutral_EFlat", testPCThreeNeutral_EFlat),
        ("testPCThreeUp_DSharp", testPCThreeUp_DSharp),
        ("testPCTwoDown_EDoubleFlat", testPCTwoDown_EDoubleFlat),
        ("testPCTwoNeutral_DNatural", testPCTwoNeutral_DNatural),
        ("testPCTwoUp_CDoubleSharp", testPCTwoUp_CDoubleSharp),
        ("testPCZeroDown_DDoubleFlat", testPCZeroDown_DDoubleFlat),
        ("testPCZeroNeutral_CNatural", testPCZeroNeutral_CNatural),
        ("testPCZeroUp_BSharp", testPCZeroUp_BSharp),
    ]
}

extension PitchSpellingTendencyTests {
    static let __allTests = [
        ("testPCEightUpDown_GSharp", testPCEightUpDown_GSharp),
        ("testPCElevenUpDown_BNatural", testPCElevenUpDown_BNatural),
        ("testPCNineDownDown_BDoubleFlat", testPCNineDownDown_BDoubleFlat),
        ("testPCSixUpUp_EDoubleSharp", testPCSixUpUp_EDoubleSharp),
        ("testPCThreeUpDown_EFlat", testPCThreeUpDown_EFlat),
        ("testPCZeroUpDown_CNatural", testPCZeroUpDown_CNatural),
        ("testTendencyComparable", testTendencyComparable),
    ]
}

extension PitchSpellingTests {
    static let __allTests = [
        ("testCDoubleFlatDescription", testCDoubleFlatDescription),
        ("testCDoubleSharpDescription", testCDoubleSharpDescription),
        ("testCFlatDescription", testCFlatDescription),
        ("testCNaturalDescription", testCNaturalDescription),
        ("testCSharpDescription", testCSharpDescription),
        ("testENonTupleFlatDescription", testENonTupleFlatDescription),
        ("testFQuintupleSharpDescription", testFQuintupleSharpDescription),
        ("testGQuadrupleSharpDescription", testGQuadrupleSharpDescription),
        ("testInitJustLetterName", testInitJustLetterName),
        ("testPitchClassCQuarterSharpZeroPointFive", testPitchClassCQuarterSharpZeroPointFive),
        ("testPitchClassCSharpOne", testPitchClassCSharpOne),
        ("testPitchClassCZero", testPitchClassCZero),
        ("testPitchClassDDoubleFlatZero", testPitchClassDDoubleFlatZero),
    ]
}

extension PitchSpellingsTests {
    static let __allTests = [
        ("testDefaultPitchSpellingsForEighthToneResolution", testDefaultPitchSpellingsForEighthToneResolution),
        ("testMiddleCPitchSpelling", testMiddleCPitchSpelling),
    ]
}

extension SpelledDyadTests {
    static let __allTests = [
        ("testDiminishedThird", testDiminishedThird),
        ("testDoubleAugmentedSixth", testDoubleAugmentedSixth),
        ("testInitSorted", testInitSorted),
        ("testRelativeNamedIntervalAugmentedFourth", testRelativeNamedIntervalAugmentedFourth),
        ("testRelativeNamedIntervalAugmentedSecond", testRelativeNamedIntervalAugmentedSecond),
        ("testRelativeNamedIntervalDiminishedFourth", testRelativeNamedIntervalDiminishedFourth),
        ("testRelativeNamedIntervalDiminishedSecond", testRelativeNamedIntervalDiminishedSecond),
        ("testRelativeNamedIntervalDoubleDiminishedFourth", testRelativeNamedIntervalDoubleDiminishedFourth),
        ("testRelativeNamedIntervalDoubleDiminishedSecond", testRelativeNamedIntervalDoubleDiminishedSecond),
        ("testRelativeNamedIntervalMinorSecond", testRelativeNamedIntervalMinorSecond),
        ("testRelativeNamedIntervalPerfectFourth", testRelativeNamedIntervalPerfectFourth),
        ("testRelativeNamedIntervalPerfectUnison", testRelativeNamedIntervalPerfectUnison),
        ("testTripleAugmentedUnison", testTripleAugmentedUnison),
    ]
}

extension SpelledPitchTests {
    static let __allTests = [
        ("testANaturalPlusPerfectFourthOctave", testANaturalPlusPerfectFourthOctave),
        ("testBNaturalPlusMajorThird", testBNaturalPlusMajorThird),
        ("testBQuarterSharp", testBQuarterSharp),
        ("testBSharpPtolemaicDown", testBSharpPtolemaicDown),
        ("testCDoubleSharpPlusAugmentedFourth", testCDoubleSharpPlusAugmentedFourth),
        ("testCNaturalDisplacedByMajorSecondDNatural", testCNaturalDisplacedByMajorSecondDNatural),
        ("testCNaturalDisplacedByMinorThirdEFlat", testCNaturalDisplacedByMinorThirdEFlat),
        ("testCNaturalPlusDescendingMajorSecond", testCNaturalPlusDescendingMajorSecond),
        ("testCNaturalPlusMinorSeventh", testCNaturalPlusMinorSeventh),
        ("testComparableDifferentOctave", testComparableDifferentOctave),
        ("testComparableMinorSixth", testComparableMinorSixth),
        ("testComparableSameLetter", testComparableSameLetter),
        ("testComparableSameOctave", testComparableSameOctave),
        ("testCSharpMajorThirdESharp", testCSharpMajorThirdESharp),
        ("testCSharpPlusMajorSecondDSharp", testCSharpPlusMajorSecondDSharp),
        ("testCSharpPlusMinorSecondDNatural", testCSharpPlusMinorSecondDNatural),
        ("testDisplacedByUnisonIsSelf", testDisplacedByUnisonIsSelf),
        ("testENaturalPlusMajorSecond", testENaturalPlusMajorSecond),
        ("testExtrema", testExtrema),
        ("testFNaturalPlusDescendingMajorSecondNoOctaveChange", testFNaturalPlusDescendingMajorSecondNoOctaveChange),
        ("testFNaturalPlusMinorSeventh", testFNaturalPlusMinorSeventh),
        ("testFSharpPlusMajorThirdASharp", testFSharpPlusMajorThirdASharp),
        ("testGSharpPlusDescendingMajorSeventh", testGSharpPlusDescendingMajorSeventh),
        ("testOctaveBBelowMiddleC", testOctaveBBelowMiddleC),
        ("testOctaveBSharp", testOctaveBSharp),
        ("testOctaveCFlat", testOctaveCFlat),
        ("testOctaveCNaturalDown", testOctaveCNaturalDown),
        ("testOctaveCQuarterFlat", testOctaveCQuarterFlat),
        ("testOctaveDAboveMiddleC", testOctaveDAboveMiddleC),
        ("testOctaveMiddleC", testOctaveMiddleC),
    ]
}

extension SpellingInverterTests {
    static let __allTests = [
        ("testConsistentBasicExample", testConsistentBasicExample),
        ("testCycleCheckFSharpASharpGFlatBFlat", testCycleCheckFSharpASharpGFlatBFlat),
        ("testCycleCheckFSharpASharpGFlatBFlatSubGraphs", testCycleCheckFSharpASharpGFlatBFlatSubGraphs),
        ("testCycleCheckFSharpASharpGFlatBFlatSubGraphsAfterStronglyConnectedComponentsClumped", testCycleCheckFSharpASharpGFlatBFlatSubGraphsAfterStronglyConnectedComponentsClumped),
        ("testDependenciesFSharpASharp", testDependenciesFSharpASharp),
        ("testLargeSetOfDyadsWithoutCycles", testLargeSetOfDyadsWithoutCycles),
        ("testMajorThirds", testMajorThirds),
        ("testMinorThirds", testMinorThirds),
        ("testPerfectFourths", testPerfectFourths),
        ("testSemitones", testSemitones),
        ("testSpellingInverterAdjacenciesFSharpASharp", testSpellingInverterAdjacenciesFSharpASharp),
        ("testSpellingInverterEdgesPitchClass11", testSpellingInverterEdgesPitchClass11),
        ("testSpellingInverterPitchClass0", testSpellingInverterPitchClass0),
        ("testSpellingInverterPitchClass1", testSpellingInverterPitchClass1),
        ("testSpellingInverterPitchClass10", testSpellingInverterPitchClass10),
        ("testSpellingInverterPitchClass11", testSpellingInverterPitchClass11),
        ("testSpellingInverterPitchClass2", testSpellingInverterPitchClass2),
        ("testSpellingInverterPitchClass3", testSpellingInverterPitchClass3),
        ("testSpellingInverterPitchClass4", testSpellingInverterPitchClass4),
        ("testSpellingInverterPitchClass5", testSpellingInverterPitchClass5),
        ("testSpellingInverterPitchClass6", testSpellingInverterPitchClass6),
        ("testSpellingInverterPitchClass7", testSpellingInverterPitchClass7),
        ("testSpellingInverterPitchClass8", testSpellingInverterPitchClass8),
        ("testSpellingInverterPitchClass9", testSpellingInverterPitchClass9),
        ("testTones", testTones),
        ("testWeightsDerivationWithSimpleCycle", testWeightsDerivationWithSimpleCycle),
        ("testWeightsFSharpASharp", testWeightsFSharpASharp),
    ]
}

extension UnorderedIntervalDescriptorTests {
    static let __allTests = [
        ("testBFlatDSharpAugmentedThird", testBFlatDSharpAugmentedThird),
        ("testCASharpAugmentedSixthDiminishedThird", testCASharpAugmentedSixthDiminishedThird),
        ("testDFSharpMajorThird", testDFSharpMajorThird),
        ("testInitAugmentedUnison", testInitAugmentedUnison),
        ("testInitDoubleAugmentedUnison", testInitDoubleAugmentedUnison),
        ("testInitMinorSecond", testInitMinorSecond),
        ("testInitTripleAugmentedUnison", testInitTripleAugmentedUnison),
        ("testInitUnisonSamePitchClass", testInitUnisonSamePitchClass),
    ]
}

extension WeightLabelTests {
    static let __allTests = [
        ("testAddition", testAddition),
        ("testArithmetic", testArithmetic),
        ("testComparison", testComparison),
        ("testInverseOfInverseEqualToOriginalMinusColumn", testInverseOfInverseEqualToOriginalMinusColumn),
        ("testInverseOfInverseEqualToOriginalPlusColumn", testInverseOfInverseEqualToOriginalPlusColumn),
        ("testSubtraction", testSubtraction),
        ("testZeroEqualsEmpty", testZeroEqualsEmpty),
        ("testZeroEqualToEdgeCarrying", testZeroEqualToEdgeCarrying),
    ]
}

extension WetherfieldTests {
    static let __allTests = [
        ("testInitDyadNodeCount", testInitDyadNodeCount),
        ("testInitMonadNodeCount", testInitMonadNodeCount),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CompoundIntervalDescriptorTests.__allTests),
        testCase(FlowNetworkTests.__allTests),
        testCase(LetterNameTests.__allTests),
        testCase(PitchSpellerTests.__allTests),
        testCase(PitchSpellingCategoryTests.__allTests),
        testCase(PitchSpellingTendencyTests.__allTests),
        testCase(PitchSpellingTests.__allTests),
        testCase(PitchSpellingsTests.__allTests),
        testCase(SpelledDyadTests.__allTests),
        testCase(SpelledPitchTests.__allTests),
        testCase(SpellingInverterTests.__allTests),
        testCase(UnorderedIntervalDescriptorTests.__allTests),
        testCase(WeightLabelTests.__allTests),
        testCase(WetherfieldTests.__allTests),
    ]
}
#endif
