//
//  OrderedPairTests.swift
//  PitchSpellerTests
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

import XCTest
@testable import PitchSpeller

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
    
    func testTuple() {
        let pair = OrderedPair<Int>(3,6)
        XCTAssertEqual(pair.tuple.0, 3)
        XCTAssertEqual(pair.tuple.1, 6)
    }
    
    func testElput() {
        let pair = OrderedPair<Int>(3,6)
        XCTAssertEqual(pair.elput.0, 6)
        XCTAssertEqual(pair.elput.1, 3)
    }
    
    func testSwapped() {
        let pair1 = OrderedPair<Int>(3,6)
        let pair2 = OrderedPair<Int>(6,3)
        XCTAssertEqual(pair1, pair2.swapped)
        XCTAssertEqual(pair1, pair1.swapped.swapped)
    }
}
