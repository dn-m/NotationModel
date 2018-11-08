import XCTest

extension AdjacencyCarryingTests {
    static let __allTests = [
        ("testAddition", testAddition),
        ("testConvenienceConstructor", testConvenienceConstructor),
        ("testMultiplicationBuildOrderMatters", testMultiplicationBuildOrderMatters),
        ("testMultiplicationDirectedH", testMultiplicationDirectedH),
        ("testMultiplicationInitializationFreeze", testMultiplicationInitializationFreeze),
        ("testPullback", testPullback),
    ]
}

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
        ("testSpelledOneFiveOverDNatural", testSpelledOneFiveOverDNatural),
        ("testSpelledOneFourOverDNatural", testSpelledOneFourOverDNatural),
        ("testSpelledOneThreeOverDNatural", testSpelledOneThreeOverDNatural),
        ("testSpelledOneTwoOverDNatural", testSpelledOneTwoOverDNatural),
        ("testSpelledZeroEightOverDNatural", testSpelledZeroEightOverDNatural),
        ("testSpelledZeroElevenOverDNatural", testSpelledZeroElevenOverDNatural),
        ("testSpelledZeroFiveOverDNatural", testSpelledZeroFiveOverDNatural),
        ("testSpelledZeroFourOverDNatural", testSpelledZeroFourOverDNatural),
        ("testSpelledZeroNineOverDNatural", testSpelledZeroNineOverDNatural),
        ("testSpelledZeroOneOverC", testSpelledZeroOneOverC),
        ("testSpelledZeroSevenOverDNatural", testSpelledZeroSevenOverDNatural),
        ("testSpelledZeroSixOverDNatural", testSpelledZeroSixOverDNatural),
        ("testSpelledZeroTenOverDNatural", testSpelledZeroTenOverDNatural),
        ("testSpelledZeroThreeOverDNatural", testSpelledZeroThreeOverDNatural),
        ("testSpelledZeroTwoOverDNatural", testSpelledZeroTwoOverDNatural),
        ("testSpellEightOverANatural", testSpellEightOverANatural),
        ("testSpellEightOverBNatural", testSpellEightOverBNatural),
        ("testSpellEightOverCNatural", testSpellEightOverCNatural),
        ("testSpellEightOverENatural", testSpellEightOverENatural),
        ("testSpellEightOverFNatural", testSpellEightOverFNatural),
        ("testSpellEightOverGNatural", testSpellEightOverGNatural),
        ("testSpellElevenOverDNatural", testSpellElevenOverDNatural),
        ("testSpellFiveOverDNatural", testSpellFiveOverDNatural),
        ("testSpellFourOverDNatural", testSpellFourOverDNatural),
        ("testSpellNineOverDNatural", testSpellNineOverDNatural),
        ("testSpellOneOverDNatural", testSpellOneOverDNatural),
        ("testSpellSelfAsPivot", testSpellSelfAsPivot),
        ("testSpellSevenOverDNatural", testSpellSevenOverDNatural),
        ("testSpellSixOverDNatural", testSpellSixOverDNatural),
        ("testSpellTenOverDNatural", testSpellTenOverDNatural),
        ("testSpellThreeOverDNatural", testSpellThreeOverDNatural),
        ("testSpellTwoOverDNatural", testSpellTwoOverDNatural),
        ("testSpellZeroOverDNatural", testSpellZeroOverDNatural),
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

extension WeightCarryingTests {
    static let __allTests = [
        ("testAddition", testAddition),
        ("testConvenienceConstructor", testConvenienceConstructor),
        ("testMultiplicationDirectedBuildOrderMatters", testMultiplicationDirectedBuildOrderMatters),
        ("testMultiplicationDirectedH", testMultiplicationDirectedH),
        ("testMultiplicationInitializationFreeze", testMultiplicationInitializationFreeze),
        ("testPullback", testPullback),
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
        testCase(AdjacencyCarryingTests.__allTests),
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
        testCase(UnorderedIntervalDescriptorTests.__allTests),
        testCase(WeightCarryingTests.__allTests),
        testCase(WetherfieldTests.__allTests),
    ]
}
#endif
