//
//  WeightLabelTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 11/12/18.
//

import XCTest
import DataStructures
@testable import SpelledPitch

class WeightLabelTests: XCTestCase {

    func testZeroEqualsEmpty() {
        XCTAssertEqual(WeightLabel<OrderedPair<Int>>(), .zero)
    }

    func testZeroEqualToEdgeCarrying() {
        XCTAssertEqual(WeightLabel<OrderedPair<Int>>(edge: .init(1,2)), .zero)
    }

    func testInverseOfInverseEqualToOriginalPlusColumn() {
        let label = WeightLabel<OrderedPair<Int>>.build(.init(1,2))
        XCTAssertEqual(label.inverse.inverse, label)
    }

    func testInverseOfInverseEqualToOriginalMinusColumn() {
        let label = WeightLabel<OrderedPair<Int>>(edge: .init(1,2), minus: [.init(1,2)])
        XCTAssertEqual(label.inverse.inverse, label)
    }

    func testAddition() {
        let a = WeightLabel<OrderedPair<Int>>.build(.init(1,2))
        let b = WeightLabel<OrderedPair<Int>>.build(.init(3,4))
        let expected = WeightLabel<OrderedPair<Int>>(edge: .init(1,2), plus: [.init(1,2), .init(3,4)])
        XCTAssertEqual(a + b, expected)
    }

    func testSubtraction() {
        let a = WeightLabel<OrderedPair<Int>>.build(.init(5,6))
        let b = WeightLabel<OrderedPair<Int>>.build(.init(7,8))
        let expected = WeightLabel<OrderedPair<Int>>(edge: .init(5,6), plus: [.init(5,6)], minus: [.init(7,8)])
        XCTAssertEqual(a - b, expected)
    }

    func testArithmetic() {
        let a = WeightLabel<OrderedPair<Int>>.build(.init(1,2))
        let b = WeightLabel<OrderedPair<Int>>.build(.init(3,4))
        let c = WeightLabel<OrderedPair<Int>>.build(.init(5,6))
        let d = WeightLabel<OrderedPair<Int>>.build(.init(7,8))
        let expected = WeightLabel<OrderedPair<Int>>(edge: .init(1,2),
                                                     plus:  [.init(1,2),.init(3,4)],
                                                     minus: [.init(7,8)])
        XCTAssertEqual(a + b + c - (d + c), expected)
    }

    func testComparison() {
        
    }
}
