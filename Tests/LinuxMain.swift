import XCTest

import SpelledRhythmTests
import StaffModelTests
import SpelledPitchTests
import PlotModelTests

var tests = [XCTestCaseEntry]()
tests += SpelledRhythmTests.__allTests()
tests += StaffModelTests.__allTests()
tests += SpelledPitchTests.__allTests()
tests += PlotModelTests.__allTests()

XCTMain(tests)
