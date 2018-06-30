//
//  CrossTests.swift
//  PitchSpellerTests
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

import XCTest
@testable import PitchSpeller

class CrossTests: XCTestCase {
    
    func testEqualityFunction() {
        let pair1 = Cross<Int, String>(3, "three")
        let pair2 = Cross<Int, String>(3, "three")
        let pair3 = Cross<Int, String>(3, "four")
        XCTAssertEqual(pair1, pair2)
        XCTAssertNotEqual(pair1, pair3)
    }
    
    func testHashability() {
        let pair = Cross<Int, String>(2, "two")
        let dict = [pair: "Hash Value"]
        XCTAssertEqual(dict[pair], "Hash Value")
    }
    
    func testTuple() {
        let pair = Cross<Int, String>(3, "three")
        XCTAssertEqual(pair.tuple.0, 3)
        XCTAssertEqual(pair.tuple.1, "three")
    }
}
