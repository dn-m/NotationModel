//
//  GraphTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/22/18.
//

import XCTest
@testable import SpelledPitch

class GraphTests: XCTestCase {

    func testGraphInsertNodes() {
        var result = Graph<Int>()
        result.insertEdge(from: 0, to: 1)
        let expected = Graph([0,1], [.init(0,1)])
        XCTAssertEqual(result, expected)
    }

    func testWeightedGraphInsertNodes() {
        var result = WeightedGraph<String,Double>()
        result.insertEdge(from: "Zero", to: "One", weight: 42.0)
        let expected = WeightedGraph(["Zero","One"], [.init("One","Zero"): 42.0])
        XCTAssertEqual(result, expected)
    }

    func testDirectedGraphInsertNodes() {
        var result = DirectedGraph<String>()
        result.insertEdge(from: "Zero", to: "One")
        let expected = DirectedGraph(["Zero","One"], [.init("Zero","One")])
        XCTAssertEqual(result, expected)
    }

    func testWeightedDirectedGraphInsertNodes() {
        var result = WeightedDirectedGraph<String,Double>()
        result.insertEdge(from: "Zero", to: "One", weight: 42.0)
        let expected = WeightedDirectedGraph(["Zero","One"], [.init("Zero","One"): 42.0])
        XCTAssertEqual(result, expected)
    }
}
