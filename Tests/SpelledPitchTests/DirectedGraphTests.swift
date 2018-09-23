//
//  DirectedGraphTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/23/18.
//

import XCTest
@testable import SpelledPitch

class DirectedGraphTests: XCTestCase {

    func testDirectedGraphInsertNodes() {
        var result = DirectedGraph<String>()
        result.insertEdge(from: "Zero", to: "One")
        let expected = DirectedGraph(["Zero","One"], [.init("Zero","One")])
        XCTAssertEqual(result, expected)
    }

    func testEdgesFromNode() {
        var graph = DirectedGraph<String>()
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.insertEdge(from: "b", to: "d")
        graph.insertEdge(from: "d", to: "e")
        XCTAssertEqual(graph.edges(from: "b"), [OrderedPair("b","c"),OrderedPair("b","d")])
    }
}
