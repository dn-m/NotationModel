//
//  GraphTests.swift
//  PitchSpellerTests
//
//  Created by James Bean on 5/24/18.
//

import XCTest
@testable import PitchSpeller

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
            graph.insertEdge(from: source, to: destination, value: Double.random(in: 0...1))
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
        graph.insertEdge(from: source, to: destination, value: 0.5)
        XCTAssertEqual(graph.edgeValue(from: source, to: destination), 0.5)
    }

    func testRemoveEdge() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        let c = graph.createNode("c")
        graph.insertEdge(from: a, to: b, value: 1)
        graph.insertEdge(from: b, to: c, value: 1)
        graph.removeEdge(from: a, to: b)
        XCTAssertNil(graph.edgeValue(from: a, to: b))
    }

    func testEdgesFromNode() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        let c = graph.createNode("c")
        graph.insertEdge(from: a, to: b, value: 1)
        graph.insertEdge(from: a, to: c, value: 0.5)
        let edges = graph.edges(from: a)
        let ab = edges[0]
        let ac = edges[1]
        XCTAssertEqual(ab.value, 1)
        XCTAssertEqual(ac.value, 0.5)
    }

    func testNodesAdjacentToNode() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        let c = graph.createNode("c")
        graph.insertEdge(from: a, to: b, value: 1)
        graph.insertEdge(from: a, to: c, value: 0.5)
        XCTAssertEqual(graph.neighbors(of: a), [b,c])
        XCTAssertEqual(graph.neighbors(of: b), [])
        XCTAssertEqual(graph.neighbors(of: c), [])
    }

    func testShortestPathSingleNode() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        XCTAssertEqual(graph.shortestPath(from: a, to: a), [])
    }

    func testShortestPathTwoUnconnectedNodes() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        XCTAssertEqual(graph.shortestPath(from: a, to: b), nil)
        XCTAssertEqual(graph.shortestPath(from: b, to: b), [])
    }

    func testShortestPathTwoDirectionallyConnectedNodes() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        graph.insertEdge(from: a, to: b, value: 1)
        XCTAssertEqual(graph.shortestPath(from: a, to: b), [Graph.Edge(from: a, to: b, value: 1)])
        XCTAssertEqual(graph.shortestPath(from: b, to: b), [])
    }

    func testShortestPathThreeNodes() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        let c = graph.createNode("c")
        graph.insertEdge(from: a, to: b, value: 1)
        graph.insertEdge(from: b, to: c, value: 0.66)
        graph.insertEdge(from: a, to: c, value: 0.33)
        XCTAssertEqual(graph.shortestPath(from: a, to: c), [Graph.Edge(from: a, to: c, value: 0.33)])
        XCTAssertEqual(graph.shortestPath(from: b, to: c), [Graph.Edge(from: b, to: c, value: 0.66)])
    }

    func testInsertEdgeReplacesEdges() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        graph.insertEdge(from: a, to: b, value: 1)
        graph.insertEdge(from: a, to: b, value: 0.5)
        XCTAssertEqual(graph.edges.count, 1)
        XCTAssertEqual(graph.edgeValue(from: a, to: b), 0.5)
    }

    func testInsertPath() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        let c = graph.createNode("c")
        graph.insertEdge(from: a, to: b, value: 1)
        graph.insertEdge(from: b, to: c, value: 0.5)
        let path = graph.shortestPath(from: a, to: c)!.map { $0 * 2 }
        graph.insertPath(path)
        XCTAssertEqual(graph.edgeValue(from: a, to: b), 2)
        XCTAssertEqual(graph.edgeValue(from: b, to: c), 1)
    }

    func testGraphInsertEdgeWithValueZeroRemoveEdge() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        let c = graph.createNode("c")
        graph.insertEdge(from: a, to: b, value: 1)
        graph.insertEdge(from: b, to: c, value: 1)
        graph.insertPath(graph.shortestPath(from: a, to: c)!.map { _ in 0 })
        XCTAssertNil(graph.edgeValue(from: a, to: b))
        XCTAssertNil(graph.edgeValue(from: b, to: c))
    }

    func testBreadthFirstSearch() {
        var graph = Graph<String>()
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        let c = graph.createNode("c")
        graph.insertEdge(from: a, to: b, value: 1)
        graph.insertEdge(from: b, to: c, value: 1)
        XCTAssertEqual(graph.breadthFirstSearch(from: a), [a,b,c])
    }
}
