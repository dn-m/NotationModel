import XCTest

extension BeamingTests {
    static let __allTests = [
        ("testCutAfterEqualToStartCountSingleLevel", testCutAfterEqualToStartCountSingleLevel),
        ("testCutAfterLastThrowsOutOfBounds", testCutAfterLastThrowsOutOfBounds),
        ("testCutAtEqualToStopCountSingleLevel", testCutAtEqualToStopCountSingleLevel),
        ("testCutFirstThrowsIndexOutOfBounds", testCutFirstThrowsIndexOutOfBounds),
        ("testCutFourSixteenthsIntoTwoPairsCutOneLevel", testCutFourSixteenthsIntoTwoPairsCutOneLevel),
        ("testCutQuarterNotesThrowsCurrentStackEmpty", testCutQuarterNotesThrowsCurrentStackEmpty),
        ("testCutQuarterNotesThrowsPreviousStackEmpty", testCutQuarterNotesThrowsPreviousStackEmpty),
        ("testCutSingleBeamingThrowsItemOutOfRange", testCutSingleBeamingThrowsItemOutOfRange),
        ("testCutStartCountEqualToAmount", testCutStartCountEqualToAmount),
        ("testCutStartCountGreaterThanAmount", testCutStartCountGreaterThanAmount),
        ("testCutStartCountLessThanAmount", testCutStartCountLessThanAmount),
        ("testCutStopCountEqualToAmount", testCutStopCountEqualToAmount),
        ("testCutStopCountGreaterThanAmount", testCutStopCountGreaterThanAmount),
        ("testCutStopCountLessThanAmount", testCutStopCountLessThanAmount),
        ("testCutTwoBeamedEighthsIntoTwoQuarterNoteBeamlets", testCutTwoBeamedEighthsIntoTwoQuarterNoteBeamlets),
        ("testFuzzingPrintOneHundredRandomBeamings", testFuzzingPrintOneHundredRandomBeamings),
        ("testFuzzingTenThousandRandomBeamings", testFuzzingTenThousandRandomBeamings),
        ("testFuzzingTenThousandRandomBeamingsCutAtRandomIndicesWithRandomAmounts", testFuzzingTenThousandRandomBeamingsCutAtRandomIndicesWithRandomAmounts),
        ("testMaintainsToStartsAmountGreaterThanCount", testMaintainsToStartsAmountGreaterThanCount),
        ("testMaintainsToStartsAmountLessThanCount", testMaintainsToStartsAmountLessThanCount),
        ("testMaintainsToStartsNone", testMaintainsToStartsNone),
        ("testMaintainsToStopsAmountGreaterThanCount", testMaintainsToStopsAmountGreaterThanCount),
        ("testMaintainsToStopsAmountLessThanCount", testMaintainsToStopsAmountLessThanCount),
        ("testMaintainsToStopsNone", testMaintainsToStopsNone),
        ("testSevenTwoZero", testSevenTwoZero),
        ("testSixteenthSixteenthThirtySecondCutAt1", testSixteenthSixteenthThirtySecondCutAt1),
        ("testSixteenthSixteenthThirtySecondCutAt2", testSixteenthSixteenthThirtySecondCutAt2),
        ("testStartsToBeamletsAmountGreaterThanCount", testStartsToBeamletsAmountGreaterThanCount),
        ("testStartsToBeamletsCountGreaterThanAmount", testStartsToBeamletsCountGreaterThanAmount),
        ("testStartsToBeamletsNoStarts", testStartsToBeamletsNoStarts),
        ("testStopsToBeamletsAmountGreaterThanCount", testStopsToBeamletsAmountGreaterThanCount),
        ("testStopsToBeamletsCountGreaterThanAmount", testStopsToBeamletsCountGreaterThanAmount),
        ("testStopsToBeamletsNoStops", testStopsToBeamletsNoStops),
        ("testThirtySecondSixteenthQuarterCutAt1Amount2", testThirtySecondSixteenthQuarterCutAt1Amount2),
        ("testThritySecondSixteenthQuarterCutAt1", testThritySecondSixteenthQuarterCutAt1),
        ("testTripletEighthsCutAt1", testTripletEighthsCutAt1),
        ("testTripletEighthsCutAt2", testTripletEighthsCutAt2),
        ("testTwoSevenZero", testTwoSevenZero),
    ]
}

extension SpelledRhythmTests {
    static let __allTests = [
        ("testInitWithRhythm", testInitWithRhythm),
        ("testTiesAllNones", testTiesAllNones),
        ("testTiesCombo", testTiesCombo),
        ("testTiesSequence", testTiesSequence),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BeamingTests.__allTests),
        testCase(SpelledRhythmTests.__allTests),
    ]
}
#endif
