import XCTest

extension CompoundSpelledIntervalTests {
    static let __allTests = [
        ("testInitTwoSpelledPitchesAscendingMajorTenth", testInitTwoSpelledPitchesAscendingMajorTenth),
        ("testInitTwoSpelledPitchesAscendingMinorSecond", testInitTwoSpelledPitchesAscendingMinorSecond),
        ("testInitTwoSpelledPitchesAscendingMinorSixth", testInitTwoSpelledPitchesAscendingMinorSixth),
        ("testInitTwoSpelledPitchesDescendingMajorSecond", testInitTwoSpelledPitchesDescendingMajorSecond),
        ("testInitTwoSpelledPitchesDescendingPerfectEleventh", testInitTwoSpelledPitchesDescendingPerfectEleventh),
        ("testInitTwoSpelledPitchesUnison", testInitTwoSpelledPitchesUnison),
    ]
}

extension DyadTests {
    static let __allTests = [
        ("testFinestResolutionEighthTone", testFinestResolutionEighthTone),
        ("testFinestResolutionQuarterTone", testFinestResolutionQuarterTone),
    ]
}

extension IntervalClass_PitchSpellingTests {
    static let __allTests = [
        ("testOctaveLessComplexThanPerfectFifth", testOctaveLessComplexThanPerfectFifth),
        ("testPerfectFifthLessComplexThanMajorThird", testPerfectFifthLessComplexThanMajorThird),
    ]
}

extension OrderedSpelledIntervalTests {
    static let __allTests = [
        ("testAbsoluteNamedIntervalOrdinalInversion", testAbsoluteNamedIntervalOrdinalInversion),
        ("testAPI", testAPI),
        ("testAPIShouldNotCompile", testAPIShouldNotCompile),
        ("testDoubleAugmentedThirdDoubleDiminishedSixth", testDoubleAugmentedThirdDoubleDiminishedSixth),
        ("testInversionMajorSecondMinorSeventh", testInversionMajorSecondMinorSeventh),
        ("testInversionMajorThirdMinorSixth", testInversionMajorThirdMinorSixth),
        ("testInversionPerfectFifthPerfectFourth", testInversionPerfectFifthPerfectFourth),
        ("testPerfectOrdinalFourthFifthInverse", testPerfectOrdinalFourthFifthInverse),
        ("testPerfectOrdinalUnisonInverse", testPerfectOrdinalUnisonInverse),
        ("testSecondOrdinalInverseSeventh", testSecondOrdinalInverseSeventh),
    ]
}

extension PitchSet_PitchSpellingTests {
    static let __allTests = [
        ("testEmptyEmpty", testEmptyEmpty),
        ("testMiddleC", testMiddleC),
        ("testPitchSet", testPitchSet),
    ]
}

extension PitchSpellingTests {
    static let __allTests = [
        ("testGThreeQuarterFlatUpFivePointSeventyFive", testGThreeQuarterFlatUpFivePointSeventyFive),
        ("testInitJustLetterName", testInitJustLetterName),
        ("testPitchClassCQuarterSharpDownZeroPointTwoFive", testPitchClassCQuarterSharpDownZeroPointTwoFive),
        ("testPitchClassCQuarterSharpUpZeroPointSevenFive", testPitchClassCQuarterSharpUpZeroPointSevenFive),
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

extension Pitch_PitchSpellingTests {
    static let __allTests = [
        ("test60DefaultSpellingC", test60DefaultSpellingC),
        ("test61DefaultSpellingD", test61DefaultSpellingD),
        ("test61PitchSpellingsCSharpDFlat", test61PitchSpellingsCSharpDFlat),
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

extension SpelledIntervalQualityTests {
    static let __allTests = [
        ("testInverseDimAug", testInverseDimAug),
        ("testInverseMinorMajor", testInverseMinorMajor),
        ("testInversePerfect", testInversePerfect),
    ]
}

extension SpelledPitchTests {
    static let __allTests = [
        ("testBQuarterSharp", testBQuarterSharp),
        ("testBSharpDown", testBSharpDown),
        ("testComparableDifferentOctave", testComparableDifferentOctave),
        ("testComparableSameLetter", testComparableSameLetter),
        ("testComparableSameOctave", testComparableSameOctave),
        ("testExtrema", testExtrema),
        ("testOctaveBBelowMiddleC", testOctaveBBelowMiddleC),
        ("testOctaveBSharp", testOctaveBSharp),
        ("testOctaveCFlat", testOctaveCFlat),
        ("testOctaveCNaturalDown", testOctaveCNaturalDown),
        ("testOctaveCQuarterFlat", testOctaveCQuarterFlat),
        ("testOctaveDAboveMiddleC", testOctaveDAboveMiddleC),
        ("testOctaveMiddleC", testOctaveMiddleC),
    ]
}

extension UnorderedSpelledIntervalTests {
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
        testCase(CompoundSpelledIntervalTests.__allTests),
        testCase(DyadTests.__allTests),
        testCase(IntervalClass_PitchSpellingTests.__allTests),
        testCase(OrderedSpelledIntervalTests.__allTests),
        testCase(PitchSet_PitchSpellingTests.__allTests),
        testCase(PitchSpellingTests.__allTests),
        testCase(PitchSpellingsTests.__allTests),
        testCase(Pitch_PitchSpellingTests.__allTests),
        testCase(SpelledDyadTests.__allTests),
        testCase(SpelledIntervalQualityTests.__allTests),
        testCase(SpelledPitchTests.__allTests),
        testCase(UnorderedSpelledIntervalTests.__allTests),
    ]
}
#endif
