//
//  WeightedGraphTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/23/18.
//

import XCTest
@testable import SpelledPitch

class WeightedGraphTests: XCTestCase {

    func testInsertNodes() {
        var result = WeightedGraph<String,Double>()
        result.insertEdge(from: "a", to: "b", weight: 42.0)
        let expected = WeightedGraph(["a","b"], [.init("b","a"): 42.0])
        XCTAssertEqual(result, expected)
    }

    func testWeightForEdge() {
        var graph = WeightedGraph<String,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        XCTAssertNil(graph.weight(for: UnorderedPair("c","e")))
        XCTAssertEqual(graph.weight(for: UnorderedPair("b","c")), 7)
        XCTAssertEqual(graph.weight(from: "d", to: "e"), 13)
    }

    func testUpdateEdge() {
        var graph = WeightedGraph<String,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 1)
        graph.updateEdge(from: "a", to: "b") { $0 * 2 }
        XCTAssertEqual(graph.weight(from: "a", to: "b"), 2)
    }

    func testContains() {
        var graph = WeightedGraph<String,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        XCTAssertFalse(graph.contains(UnorderedPair("a","c")))
        XCTAssert(graph.contains(UnorderedPair("b","d")))
    }

    func testNeighbors() {
        var graph = WeightedGraph<String,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        XCTAssertEqual(graph.neighbors(of: "b"), ["a","c","d"])
        XCTAssertEqual(graph.neighbors(of: "f"), [])
    }

    func testRemoveEdge() {
        var graph = WeightedGraph<String,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        graph.removeEdge(from: "b", to: "d")
        XCTAssertFalse(graph.contains(UnorderedPair("b","d")))
    }

    func testUnweighted() {
        var graph = WeightedGraph<String,Int>()
        graph.insertEdge(from: "a", to: "b", weight: 5)
        graph.insertEdge(from: "b", to: "c", weight: 7)
        graph.insertEdge(from: "b", to: "d", weight: 11)
        graph.insertEdge(from: "d", to: "e", weight: 13)
        let unweighted: Graph<String> = graph.unweighted()
        let expected = Graph(
            ["a","b","c","d","e"],
            [
                UnorderedPair("a","b"),
                UnorderedPair("b","c"),
                UnorderedPair("b","d"),
                UnorderedPair("d","e")
            ]
        )
        XCTAssertEqual(unweighted, expected)
    }
}
