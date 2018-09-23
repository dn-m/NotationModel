//
//  GraphTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/22/18.
//

import XCTest
@testable import SpelledPitch

class GraphTests: XCTestCase {

    func testNodesCount() {
        var graph = Graph<Int>()
        (0..<10).forEach { graph.insert($0) }
        [(0,2), (1,4), (1,5), (4,7), (4,9)].forEach { graph.insertEdge(from: $0.0, to: $0.1) }
        XCTAssertEqual(graph.nodes.count, 10)
    }

    func testEdgesCount() {
        var graph = Graph<Int>()
        (0..<10).forEach { graph.insert($0) }
        [(0,2), (1,4), (1,5), (4,7), (4,9)].forEach { graph.insertEdge(from: $0.0, to: $0.1) }
        XCTAssertEqual(graph.edges.count, 5)
    }

    func testInsertNodes() {
        var result = Graph<Int>()
        result.insertEdge(from: 0, to: 1)
        let expected = Graph([0,1], [.init(0,1)])
        XCTAssertEqual(result, expected)
    }

    func testRemoveEdge() {
        var graph = Graph<String>()
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.removeEdge(from: "a", to: "b")
        XCTAssertEqual(graph.edges.count, 1)
    }

    func testEdgesContainingNode() {
        var graph = Graph<String>()
        graph.insert("a")
        graph.insert("b")
        graph.insert("c")
        graph.insertEdge(from: "a", to: "c")
        XCTAssertEqual(graph.edges(containing: "a"), [UnorderedPair("a","c")])
    }

    func testNeighbors() {
        var graph = Graph<String>()
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "a", to: "c")
        XCTAssertEqual(graph.neighbors(of: "a"), ["b","c"])
    }

    func testNeighborsInSet() {
        var graph = Graph<String>()
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "a", to: "c")
        graph.insertEdge(from: "a", to: "d")
        graph.insertEdge(from: "a", to: "e")
        XCTAssertEqual(graph.neighbors(of: "a", in: ["c","d","f"]), ["c","d"])
    }

    func testBreadthFirstSearch() {
        var graph = Graph<String>()
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.insertEdge(from: "c", to: "d")
        graph.insertEdge(from: "d", to: "e")
        XCTAssertEqual(graph.breadthFirstSearch(from: "e"), ["e","d","c","b","a"])
        XCTAssertEqual(graph.breadthFirstSearch(from: "a"), ["a","b","c","d","e"])
    }
}
