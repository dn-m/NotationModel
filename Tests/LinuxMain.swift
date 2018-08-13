import XCTest

import SpelledPitchTests
import SpelledRhythmTests
import RhythmBeamerTests
import StaffModelTests
import PitchSpellerTests
import PlotModelTests

var tests = [XCTestCaseEntry]()
tests += SpelledPitchTests.__allTests()
tests += SpelledRhythmTests.__allTests()
tests += RhythmBeamerTests.__allTests()
tests += StaffModelTests.__allTests()
tests += PitchSpellerTests.__allTests()
tests += PlotModelTests.__allTests()

XCTMain(tests)
