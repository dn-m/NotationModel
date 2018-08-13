import XCTest

extension DyadTests {
    static let __allTests = [
        ("testFinestResolutionEighthTone", testFinestResolutionEighthTone),
        ("testFinestResolutionQuarterTone", testFinestResolutionQuarterTone),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DyadTests.__allTests),
    ]
}
#endif
