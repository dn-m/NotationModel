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
        ("testComparableMinorSixth", testComparableMinorSixth),
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
        testCase(OrderedSpelledIntervalTests.__allTests),
        testCase(PitchSpellingTests.__allTests),
        testCase(PitchSpellingsTests.__allTests),
        testCase(SpelledDyadTests.__allTests),
        testCase(SpelledIntervalQualityTests.__allTests),
        testCase(SpelledPitchTests.__allTests),
        testCase(UnorderedSpelledIntervalTests.__allTests),
    ]
}
#endif
