import XCTest

import SpelledPitchTests
import SpelledRhythmTests
import StaffModelTests
import PlotModelTests

var tests = [XCTestCaseEntry]()
tests += SpelledPitchTests.__allTests()
tests += SpelledRhythmTests.__allTests()
tests += StaffModelTests.__allTests()
tests += PlotModelTests.__allTests()

XCTMain(tests)
