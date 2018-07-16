//
//  _GraphTests.swift
//  PitchSpellerTests
//
//  Created by Benjamin Wetherfield on 7/15/18.
//

import XCTest
@testable import PitchSpeller

class _GraphTests: XCTestCase {

    var simpleGraph: _Graph<Double, DirectedOver<Int>> {
        var graph = _Graph<Double, DirectedOver<Int>>()
        var nodes: [Int] = []
        for value in 0..<10 {
            graph.insertNode(value)
            nodes.append(value)
        }
        for indexPair in [(0,2), (1,4), (1,5), (4,7), (4,9)] {
            let (sourceIndex, destinationIndex) = indexPair
            let (source, destination) = (nodes[sourceIndex], nodes[destinationIndex])
            graph.insertEdge(from: source, to: destination, withWeight: Double.random(in: 0...1))
        }
        return graph
    }
    
    var unweightedGraph: _Graph<WithoutWeights, DirectedOver<Int>> {
        var graph = _Graph<WithoutWeights, DirectedOver<Int>>()
        var nodes: [Int] = []
        for value in 0..<10 {
            graph.insertNode(value)
            nodes.append(value)
        }
        for indexPair in [(0,2), (1,4), (1,5), (4,7), (4,9)] {
            let (sourceIndex, destinationIndex) = indexPair
            let (source, destination) = (nodes[sourceIndex], nodes[destinationIndex])
            graph.insertEdge(from: source, to: destination)
        }
        return graph
    }
//
//    func testCount() {
//        let graph = simpleGraph
//        XCTAssertEqual(graph.count, 10)
//    }
//
    func testNodesCount() {
        let graph = simpleGraph
        XCTAssertEqual(graph.nodes.count, 10)
    }
//
    func testEdgesCount() {
        let graph = simpleGraph
        XCTAssertEqual(graph.edges.count, 5)
    }
    
    func testUnweightedEdgesCount() {
        let graph = unweightedGraph
        XCTAssertEqual(graph.edges.count, 5)
    }

//
    func testEdgeWeight() {
        var graph = _Graph<Double, DirectedOver<Int>>()
        graph.insertNode(0)
        graph.insertNode(1)
        graph.insertEdge(from: 0, to: 1, withWeight: 0.5)
        XCTAssertEqual(graph.weight(from: 0, to: 1), 0.5)
    }
//
    func testRemoveEdge() {
        var graph = _Graph<Double, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "b", withWeight: 1)
        graph.insertEdge(from: "b", to: "c", withWeight: 1)
        graph.removeEdge(from: "a", to: "b")
        XCTAssertNil(graph.weight(from: "a", to: "b"))
        XCTAssertEqual(graph.edges.count, 1)
    }
//
    func testEdgesFromNodeDirected() {
        var graph = _Graph<Double, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "c", withWeight: 0.5)
        let edges = graph.edges(from: "a")
        XCTAssertEqual(edges[0].weight, 0.5)
        XCTAssertEqual(edges.count, 1)
    }
    
    func testEdgesFromNodeUndirected() {
        var graph = _Graph<Double, UndirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "c", withWeight: 0.5)
        let edges = graph.edges(from: "a")
        XCTAssertEqual(edges[0].weight, 0.5)
        XCTAssertEqual(edges.count, 1)
    }
//
    func testNodesAdjacentToNodeDirected() {
        var graph = _Graph<WithoutWeights, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "a", to: "c")
        XCTAssertEqual(Set(graph.neighbors(of: "a")), Set(["b","c"]))
        XCTAssertEqual(graph.neighbors(of: "b"), [])
        XCTAssertEqual(graph.neighbors(of: "c"), [])
    }
    
    func testNodesAdjacentToNodeUndirected() {
        var graph = _Graph<WithoutWeights, UndirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "a", to: "c")
        XCTAssertEqual(Set(graph.neighbors(of: "a")), Set(["b","c"]))
        XCTAssertEqual(graph.neighbors(of: "b"), ["a"])
        XCTAssertEqual(graph.neighbors(of: "c"), ["a"])
    }
//
//    func testShortestPathSingleNode() {
//        var graph = Graph<String>()
//        graph.insertNode("a")
//        XCTAssertEqual(graph.shortestPath(from: "a", to: "a"), [])
//    }
//
//    func testShortestPathTwoUnconnectedNodes() {
//        var graph = Graph<String>()
//        graph.insertNode("a")
//        graph.insertNode("b")
//        XCTAssertEqual(graph.shortestPath(from: "a", to: "b"), nil)
//        XCTAssertEqual(graph.shortestPath(from: "b", to: "b"), [])
//    }
//
//    func testShortestPathTwoDirectionallyConnectedNodes() {
//        var graph = Graph<String>()
//        graph.insertNode("a")
//        graph.insertNode("b")
//        graph.insertEdge(from: "a", to: "b", value: 1)
//        XCTAssertEqual(
//            graph.shortestPath(from: "a", to: "b"), [Graph.Edge(from: "a", to: "b", value: 1)]
//        )
//        XCTAssertEqual(graph.shortestPath(from: "b", to: "b"), [])
//    }
//
//    func testShortestPathThreeNodes() {
//        var graph = Graph<String>()
//        graph.insertNode("a")
//        graph.insertNode("b")
//        graph.insertNode("c")
//        graph.insertEdge(from: "a", to: "b", value: 1)
//        graph.insertEdge(from: "b", to: "c", value: 0.66)
//        graph.insertEdge(from: "a", to: "c", value: 0.33)
//        XCTAssertEqual(graph.shortestPath(from: "a", to: "c"), [Graph.Edge(from: "a", to: "c", value: 0.33)])
//        XCTAssertEqual(graph.shortestPath(from: "b", to: "c"), [Graph.Edge(from: "b", to: "c", value: 0.66)])
//    }
//
//    func testInsertEdgeReplacesEdges() {
//        var graph = Graph<String>()
//        graph.insertNode("a")
//        graph.insertNode("b")
//        graph.insertEdge(from: "a", to: "b", value: 1)
//        graph.insertEdge(from: "a", to: "b", value: 0.5)
//        XCTAssertEqual(graph.edges.count, 1)
//        XCTAssertEqual(graph.edgeValue(from: "a", to: "b"), 0.5)
//    }
//
//    func testInsertPath() {
//        var graph = Graph<String>()
//        graph.insertNode("a")
//        graph.insertNode("b")
//        graph.insertNode("c")
//        graph.insertEdge(from: "a", to: "b", value: 1)
//        graph.insertEdge(from: "b", to: "c", value: 0.5)
//        let path = graph.shortestPath(from: "a", to: "c")!.map { $0 * 2 }
//        graph.insertPath(path)
//        XCTAssertEqual(graph.edgeValue(from: "a", to: "b"), 2)
//        XCTAssertEqual(graph.edgeValue(from: "b", to: "c"), 1)
//    }
//
//    func testInsertEdgeWithValueZeroRemoveEdge() {
//        var graph = Graph<String>()
//        graph.insertNode("a")
//        graph.insertNode("b")
//        graph.insertNode("c")
//        graph.insertEdge(from: "a", to: "b", value: 1)
//        graph.insertEdge(from: "b", to: "c", value: 1)
//        graph.insertPath(graph.shortestPath(from: "a", to: "c")!.map { _ in 0 })
//        XCTAssertNil(graph.edgeValue(from: "a", to: "b"))
//        XCTAssertNil(graph.edgeValue(from: "b", to: "c"))
//    }
//
//    func testUpdateEdge() {
//        var graph = Graph<String>()
//        graph.insertNode("a")
//        graph.insertNode("b")
//        graph.insertNode("c")
//        graph.insertEdge(from: "a", to: "b", value: 1)
//        graph.insertEdge(from: "b", to: "c", value: 1)
//        graph.updateEdge(from: "a", to: "b") { $0 * 2 }
//        graph.updateEdge(from: "b", to: "c") { _ in 10 }
//        graph.updateEdge(from: "a", to: "c") { $0 * 100 }
//        XCTAssertEqual(graph.edgeValue(from: "a", to: "b"), 2)
//        XCTAssertEqual(graph.edgeValue(from: "b", to: "c"), 10)
//        XCTAssertNil(graph.edgeValue(from: "a", to: "c"))
//    }
//
//    func testBreadthFirstSearch() {
//        var graph = Graph<String>()
//        graph.insertNode("a")
//        graph.insertNode("b")
//        graph.insertNode("c")
//        graph.insertEdge(from: "a", to: "b", value: 1)
//        graph.insertEdge(from: "b", to: "c", value: 1)
//        XCTAssertEqual(graph.breadthFirstSearch(from: "a"), ["a","b","c"])
//    }
}
