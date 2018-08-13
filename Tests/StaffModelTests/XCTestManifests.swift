import XCTest

extension ClefTests {
    static let __allTests = [
        ("testStaffSlotASharpTwoOctavesBelowMiddleC", testStaffSlotASharpTwoOctavesBelowMiddleC),
        ("testStaffSlotDSharpTwoOctavesAboveMiddleC", testStaffSlotDSharpTwoOctavesAboveMiddleC),
        ("testStaffSlotEFlatAboveMiddleC", testStaffSlotEFlatAboveMiddleC),
        ("testStaffSlotMiddleC", testStaffSlotMiddleC),
    ]
}

extension StaffPointModelTests {
    static let __allTests = [
        ("testDoublesExtrema", testDoublesExtrema),
        ("testHighest", testHighest),
        ("testInit", testInit),
        ("testLedgerLinesAboveAndBelowEmpty", testLedgerLinesAboveAndBelowEmpty),
        ("testLedgerLinesAboveMonadInStaff", testLedgerLinesAboveMonadInStaff),
        ("testLedgerLinesAboveMonadJustAboveNoLedgerLines", testLedgerLinesAboveMonadJustAboveNoLedgerLines),
        ("testLedgerLinesBelowMonadInStaff", testLedgerLinesBelowMonadInStaff),
        ("testLedgerLinesBelowMonadJustBelowNoLedgerLines", testLedgerLinesBelowMonadJustBelowNoLedgerLines),
        ("testLedgerLinesDyadSingleAboveAndBelow", testLedgerLinesDyadSingleAboveAndBelow),
        ("testLedgerLinesMonadOneAbove", testLedgerLinesMonadOneAbove),
        ("testLedgerLinesMonadOneBelow", testLedgerLinesMonadOneBelow),
        ("testLowest", testLowest),
        ("testManyPitchesOnlySeveralLinesAboveDNatural", testManyPitchesOnlySeveralLinesAboveDNatural),
        ("testPitchesExtrema", testPitchesExtrema),
        ("testSpelledPitchesExtrema", testSpelledPitchesExtrema),
        ("testStemConnectionPoint", testStemConnectionPoint),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ClefTests.__allTests),
        testCase(StaffPointModelTests.__allTests),
    ]
}
#endif
