//
//  GraphTests.swift
//  PitchSpellerTests
//
//  Created by James Bean on 5/24/18.
//

import XCTest
import PitchSpeller

class GraphTests: XCTestCase {

    var simpleGraph: Graph<Int> {
        var graph = Graph<Int>()
        var nodes: [Graph<Int>.Node] = []
        for value in 0..<10 {
            nodes.append(graph.createNode(value))
        }
        for indexPair in [(0,2), (1,4), (1,5), (4,7), (4,9)] {
            let (sourceIndex, destinationIndex) = indexPair
            let (source, destination) = (nodes[sourceIndex], nodes[destinationIndex])
            graph.addEdge(from: source, to: destination, value: Double.random(in: 0...1))
        }
        return graph
    }

    func testCount() {
        let graph = simpleGraph
        XCTAssertEqual(graph.count, 10)
    }

    func testNodesCount() {
        let graph = simpleGraph
        XCTAssertEqual(graph.nodes.count, 10)
    }

    func testEdgesCount() {
        let graph = simpleGraph
        XCTAssertEqual(graph.edges.count, 5)
    }

    func testEdgeValue() {
        var graph = Graph<Int>()
        let source = graph.createNode(0)
        let destination = graph.createNode(1)
        graph.addEdge(from: source, to: destination, value: 0.5)
        XCTAssertEqual(graph.edgeValue(from: source, to: destination), 0.5)
    }

    func testEdgesFromNode() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        let c = graph.createNode("c")
        graph.addEdge(from: a, to: b, value: 1)
        graph.addEdge(from: a, to: c, value: 0.5)
        let edges = graph.edges(from: a)
        let ab = edges[0]
        let ac = edges[1]
        XCTAssertEqual(ab.value, 1)
        XCTAssertEqual(ac.value, 0.5)
    }
}
