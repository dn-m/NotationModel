//
//  UnorderedPairTests.swift
//  PitchSpellerTests
//
//  Created by Benjamin Wetherfield on 6/30/18.
//

import XCTest
@testable import PitchSpeller

class UnorderedPairTests: XCTestCase {
    
    func testEqualityFunction() {
        let pair1 = UnorderedPair<Int>(3,5)
        let pair2 = UnorderedPair<Int>(3,5)
        let pair3 = UnorderedPair<Int>(5,3)
        XCTAssertEqual(pair1, pair2)
        XCTAssertEqual(pair1, pair3)
    }
    
    func testUnEqual() {
        let pair1 = UnorderedPair<Int>(1,2)
        let pair2 = UnorderedPair<Int>(1,3)
        XCTAssertNotEqual(pair1, pair2)
    }
    
    func testHashability() {
        let pair = UnorderedPair<Int>(2,4)
        let riap = UnorderedPair<Int>(4,2)
        let dict = [pair: "Hash Value"]
        XCTAssertEqual(dict[riap], "Hash Value")
    }
    
    func testInitializers() {
        let pair1 = UnorderedPair<Int>(2,5)
        let tuple = (2,5)
        let pair2 = UnorderedPair<Int>(tuple)
        XCTAssertEqual(pair1, pair2)
    }
}
