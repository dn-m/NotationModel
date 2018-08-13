import XCTest

extension AbsoluteNamedIntervalTests {
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

extension IntervalClass_PitchSpellingTests {
    static let __allTests = [
        ("testOctaveLessComplexThanPerfectFifth", testOctaveLessComplexThanPerfectFifth),
        ("testPerfectFifthLessComplexThanMajorThird", testPerfectFifthLessComplexThanMajorThird),
    ]
}

extension NamedIntervalQualityTests {
    static let __allTests = [
        ("testInverseDimAug", testInverseDimAug),
        ("testInverseMinorMajor", testInverseMinorMajor),
        ("testInversePerfect", testInversePerfect),
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

extension RelativeNamedIntervalTests {
    static let __allTests = [
        ("testBFlatDSharpAugmentedThird", testBFlatDSharpAugmentedThird),
        ("testCASharpAugmentedSixthDiminishedThird", testCASharpAugmentedSixthDiminishedThird),
        ("testDFSharpMajorThird", testDFSharpMajorThird),
        ("testInitUnisonSamePitchClass", testInitUnisonSamePitchClass),
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

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AbsoluteNamedIntervalTests.__allTests),
        testCase(IntervalClass_PitchSpellingTests.__allTests),
        testCase(NamedIntervalQualityTests.__allTests),
        testCase(PitchSet_PitchSpellingTests.__allTests),
        testCase(PitchSpellingTests.__allTests),
        testCase(PitchSpellingsTests.__allTests),
        testCase(Pitch_PitchSpellingTests.__allTests),
        testCase(RelativeNamedIntervalTests.__allTests),
        testCase(SpelledDyadTests.__allTests),
        testCase(SpelledPitchTests.__allTests),
    ]
}
#endif
