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

extension LetterNameTests {
    static let __allTests = [
        ("testDisplacedUnison", testDisplacedUnison),
        ("testLetterNameSimpleNegative", testLetterNameSimpleNegative),
        ("testLetterNameSimplePositive", testLetterNameSimplePositive),
        ("testLetterNameWrapping", testLetterNameWrapping),
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

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CompoundIntervalDescriptorTests.__allTests),
        testCase(LetterNameTests.__allTests),
        testCase(PitchSpellingTests.__allTests),
        testCase(PitchSpellingsTests.__allTests),
        testCase(SpelledDyadTests.__allTests),
        testCase(SpelledPitchTests.__allTests),
        testCase(UnorderedIntervalDescriptorTests.__allTests),
    ]
}
#endif
