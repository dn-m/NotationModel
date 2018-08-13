import XCTest

extension PlotModelTests {
    static let __allTests = [
        ("testPlotModel", testPlotModel),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PlotModelTests.__allTests),
    ]
}
#endif
