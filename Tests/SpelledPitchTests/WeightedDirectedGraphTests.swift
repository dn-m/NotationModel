//
//  WeightedDirectedGraphTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/23/18.
//

import XCTest
@testable import SpelledPitch

class WeightedDirectedGraphTests: XCTestCase {

    func testWeightedDirectedGraphInsertNodes() {
        var result = WeightedDirectedGraph<String,Double>()
        result.insertEdge(from: "Zero", to: "One", weight: 42.0)
        let expected = WeightedDirectedGraph(["Zero","One"], [.init("Zero","One"): 42.0])
        XCTAssertEqual(result, expected)
    }

    func testEdgesFromNode() {
        var graph = WeightedDirectedGraph<String,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        XCTAssertEqual(graph.edges(from: "b"), [OrderedPair("b","c"),OrderedPair("b","d")])
    }
}
