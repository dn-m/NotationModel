import XCTest

extension BeamletDirectionTests {
    static let __allTests = [
        ("testFirstBeamletsForward", testFirstBeamletsForward),
        ("testLastBeamletsBackward", testLastBeamletsBackward),
        ("testSingleBeamletsForward", testSingleBeamletsForward),
        ("testTwoEighthNotesCutBeamletDirectionsForwardBackward", testTwoEighthNotesCutBeamletDirectionsForwardBackward),
    ]
}

extension RhythmBeamerTests {
    static let __allTests = [
        ("testBeamsCountDurationCoefficient15", testBeamsCountDurationCoefficient15),
        ("testBeamsCountDurationCoefficient2", testBeamsCountDurationCoefficient2),
        ("testBeamsCountDurationCoefficient3", testBeamsCountDurationCoefficient3),
        ("testBeamsCountDurationCoefficient7", testBeamsCountDurationCoefficient7),
        ("testDecreasing", testDecreasing),
        ("testDoubletFirstHigher", testDoubletFirstHigher),
        ("testDoubletSameValues", testDoubletSameValues),
        ("testDoubletSecondHigher", testDoubletSecondHigher),
        ("testFourOneOneOneOne", testFourOneOneOneOne),
        ("testInitWithRhythmTreeDottedValues", testInitWithRhythmTreeDottedValues),
        ("testLongSequence", testLongSequence),
        ("testOneFourOneOneOne", testOneFourOneOneOne),
        ("testOneOneFourOneOne", testOneOneFourOneOne),
        ("testOneOneOneFourOne", testOneOneOneFourOne),
        ("testOneOneOneOneFour", testOneOneOneOneFour),
        ("testSingletSetOfBeamlets", testSingletSetOfBeamlets),
        ("testTripletLowHighMid", testTripletLowHighMid),
        ("testTripletLowMidHigh", testTripletLowMidHigh),
        ("testTripletMidHighLow", testTripletMidHighLow),
        ("testTripletMidLowHigh", testTripletMidLowHigh),
        ("testTripletSameValues", testTripletSameValues),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(BeamletDirectionTests.__allTests),
        testCase(RhythmBeamerTests.__allTests),
    ]
}
#endif
