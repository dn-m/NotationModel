//
//  SpelledRhythmTests.swift
//  SpelledRhythmTests
//
//  Created by James Bean on 6/18/18.
//

import XCTest
import DataStructures
import MetricalDuration
import Rhythm
import RhythmBeamer
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

    func testInitWithRhythm() {

        let rhythm = Rhythm(4/>8, [event(1), tie(), tie(), rest()])
        let spelling = Rhythm.Spelling(rhythm: rhythm, using: DefaultBeamer.beaming)

        let expectedBeamingPoints: [Stack<Rhythm<Int>.Beaming.Item.Point>] = [
            [.start],
            [.maintain],
            [.maintain],
            [.stop]
        ]
        let expectedBeamingItems = expectedBeamingPoints.map(Rhythm<Int>.Beaming.Item.init)
        let expectedTies: [Rhythm<Int>.Spelling.Tie] = [.start, .maintain, .stop, .none]
        let expectedDots = [0,0,0,0]
        let expectedItems = zip(expectedBeamingItems, expectedTies, expectedDots)
            .map(Rhythm<Int>.Spelling.Item.init)
        XCTAssertEqual(spelling.items, expectedItems)

        let expectedGroup = Rhythm<Int>.Spelling.Group(duration: 4/>8, contentsSum: 4)
        let expectedContext = expectedGroup.context(range: 0...3)
        let expectedGrouping = Rhythm<Int>.Spelling.Grouping.leaf(expectedContext)
        XCTAssertEqual(spelling.grouping, expectedGrouping)
    }
}
