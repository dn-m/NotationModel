//
//  OrderedPairTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/21/18.
//

import XCTest
@testable import SpelledPitch

class OrderedPairTests: XCTestCase {

    func testEqualityFunction() {
        let pair1 = OrderedPair<Int>(1,2)
        let pair2 = OrderedPair<Int>(1,2)
        let pair3 = OrderedPair<Int>(2,1)
        XCTAssertEqual(pair1, pair2)
        XCTAssertNotEqual(pair1, pair3)
    }

    func testHashability() {
        let pair = OrderedPair<Int>(2,4)
        let riap = OrderedPair<Int>(4,2)
        let dict = [pair: "Hash Value"]
        XCTAssertEqual(dict[pair], "Hash Value")
        XCTAssertNil(dict[riap])
    }

    func testSwapped() {
        let pair1 = OrderedPair<Int>(3,6)
        let pair2 = OrderedPair<Int>(6,3)
        XCTAssertEqual(pair1, pair2.swapped)
        XCTAssertEqual(pair1, pair1.swapped.swapped)
    }

    func testInitializers() {
        let pair1 = OrderedPair<Int>(2,5)
        let tuple = (2,5)
        let pair2 = OrderedPair<Int>(tuple)
        XCTAssertEqual(pair1, pair2)
    }
}
