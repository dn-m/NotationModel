//
//  SpelledRhythmTests.swift
//  SpelledRhythmTests
//
//  Created by James Bean on 6/18/18.
//

import XCTest
import Rhythm
@testable import SpelledRhythm

class SpelledRhythmTests: XCTestCase {

    func testTiesAllNones() {
        let contexts: [MetricalContext<Int>] = [
            .instance(.event(1)),
            .instance(.event(1)),
            .instance(.event(1))
        ]
        let ties = makeTies(contexts)
        let expected: [Rhythm<Int>.Spelling.Tie] = [.none, .none, .none]
        XCTAssertEqual(ties, expected)
    }

    func testTiesCombo() {
        let contexts: [MetricalContext<Int>] = [
            .instance(.event(1)),
            .continuation,
            .instance(.absence)
        ]
        let ties = makeTies(contexts)
        let expected: [Rhythm<Int>.Spelling.Tie] = [.start, .stop, .none]
        XCTAssertEqual(ties, expected)
    }

    func testTiesSequence() {
        let contexts: [MetricalContext<Int>] = [
            .instance(.event(1)),
            .instance(.event(1)),
            .continuation,
            .instance(.absence),
            .instance(.event(1)),
            .continuation,
            .continuation,
            .instance(.event(1)),
            .instance(.absence)
        ]
        let ties = makeTies(contexts)
        let expected: [Rhythm<Int>.Spelling.Tie] = [
            .none,
            .start,
            .stop,
            .none,
            .start,
            .maintain,
            .stop,
            .none,
            .none
        ]
        XCTAssertEqual(ties, expected)
    }
}
