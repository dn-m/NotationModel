//
//  GraphTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/21/18.
//

import XCTest
@testable import SpelledPitch

class GraphTests: XCTestCase {

    typealias UnweightedPath = Graph<Unweighted, DirectedOver<String>>.Path

    var simpleGraph: Graph<Double, DirectedOver<Int>> {
        var graph = Graph<Double, DirectedOver<Int>>()
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

    var unweightedGraph: Graph<Unweighted, DirectedOver<Int>> {
        var graph = Graph<Unweighted, DirectedOver<Int>>()
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

    func testNodesCount() {
        let graph = simpleGraph
        XCTAssertEqual(graph.nodes.count, 10)
    }

    func testEdgesCount() {
        let graph = simpleGraph
        XCTAssertEqual(graph.edges.count, 5)
    }

    func testUnweightedEdgesCount() {
        let graph = unweightedGraph
        XCTAssertEqual(graph.edges.count, 5)
    }

    func testEdgeWeight() {
        var graph = Graph<Double, DirectedOver<Int>>()
        graph.insertNode(0)
        graph.insertNode(1)
        graph.insertEdge(from: 0, to: 1, withWeight: 0.5)
        XCTAssertEqual(graph.weight(from: 0, to: 1), 0.5)
    }

    func testPairWeight() {
        var graph = Graph<Double, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertEdge(from: "a", to: "b", withWeight: 0.5)
        XCTAssertEqual(graph.weight(OrderedPair("a", "b")), 0.5)
    }

    func testRemoveEdge() {
        var graph = Graph<Double, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "b", withWeight: 1)
        graph.insertEdge(from: "b", to: "c", withWeight: 1)
        graph.removeEdge(from: "a", to: "b")
        XCTAssertNil(graph.weight(from: "a", to: "b"))
        XCTAssertEqual(graph.edges.count, 1)
    }

    func testEdgesFromNodeDirected() {
        var graph = Graph<Double, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "c", withWeight: 0.5)
        let edgesFromA = graph.edges(from: "a")
        let edgesFromC = graph.edges(from: "c")
        XCTAssertEqual(edgesFromA[0].weight, 0.5)
        XCTAssertEqual(edgesFromA.count, 1)
        XCTAssertEqual(edgesFromC.count, 0)
    }

    func testEdgesFromNodeUndirected() {
        var graph = Graph<Double, UndirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "c", withWeight: 0.5)
        let edgesFromA = graph.edges(from: "a")
        let edgesFromC = graph.edges(from: "a")
        XCTAssertEqual(edgesFromA[0].weight, 0.5)
        XCTAssertEqual(edgesFromA.count, 1)
        XCTAssertEqual(edgesFromC[0].weight, 0.5)
        XCTAssertEqual(edgesFromC.count, 1)
    }

    func testNeighborsDirected() {
        var graph = Graph<Unweighted, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "a", to: "c")
        XCTAssertEqual(Set(graph.neighbors(of: "a")), Set(["b","c"]))
        XCTAssertEqual(graph.neighbors(of: "b"), [])
        XCTAssertEqual(graph.neighbors(of: "c"), [])
    }

    func testNeighborsFromArrayDirected() {
        var graph = Graph<Unweighted, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "a", to: "c")
        XCTAssertEqual(Set(graph.neighbors(of: "a", from: ["b", "c"])), Set(["b","c"]))
        XCTAssertEqual(Set(graph.neighbors(of: "a", from: ["b", "a"])), Set(["b"]))
        XCTAssertEqual(Set(graph.neighbors(of: "a", from: ["a", "c"])), Set(["c"]))
        XCTAssertEqual(Set(graph.neighbors(of: "a", from: ["d", "e"])), Set([]))
        XCTAssertEqual(graph.neighbors(of: "b", from: ["a", "b", "c"]), [])
    }

    func testNeighborsUndirected() {
        var graph = Graph<Unweighted, UndirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "a", to: "c")
        XCTAssertEqual(Set(graph.neighbors(of: "a")), Set(["b","c"]))
        XCTAssertEqual(graph.neighbors(of: "b"), ["a"])
        XCTAssertEqual(graph.neighbors(of: "c"), ["a"])
    }

    func testShortestUnweightedPathSingleNode() {
        var graph = Graph<Unweighted, DirectedOver<String>>()
        graph.insertNode("a")
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "a")!.nodes, ["a"])
    }

    func testShortestUnweightedPathTwoUnconnectedNodes() {
        var graph = Graph<Unweighted, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        XCTAssertNil(graph.shortestUnweightedPath(from: "a", to: "b"))
    }

    func testShortestUnweightedPathTwoDirectionallyConnectedNodes() {
        var graph = Graph<Unweighted, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertEdge(from: "a", to: "b")
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "b")!.nodes, ["a", "b"])
        XCTAssertNil(graph.shortestUnweightedPath(from: "b", to: "a"))
    }

    func testShortestPathThreeNodes() {
        var graph = Graph<Unweighted, DirectedOver<String>>()
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("c")
        graph.insertEdge(from: "a", to: "b")
        graph.insertEdge(from: "b", to: "c")
        graph.insertEdge(from: "c", to: "b")
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "c")!.nodes, ["a", "b", "c"])
        XCTAssertEqual(graph.shortestUnweightedPath(from: "a", to: "b")!.nodes, ["a", "b"])
    }

    func testShortestPathTwoOptions() {
        var graph = Graph<Double, DirectedOver<String>>()
        graph.insertNode("s")
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("t")
        graph.insertEdge(from: "s", to: "a", withWeight: 2.0)
        graph.insertEdge(from: "s", to: "b", withWeight: 1.0)
        graph.insertEdge(from: "a", to: "t", withWeight: 3.0)
        graph.insertEdge(from: "b", to: "t", withWeight: 4.0)
        XCTAssertEqual(graph.shortestUnweightedPath(from: "s", to: "t")!.nodes.count, 3)
    }

    func testPathAdjacents() {
        var graph = Graph<Double, DirectedOver<String>>()
        graph.insertNode("s")
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertNode("t")
        graph.insertEdge(from: "s", to: "a", withWeight: 2.0)
        graph.insertEdge(from: "s", to: "b", withWeight: 1.0)
        graph.insertEdge(from: "a", to: "t", withWeight: 3.0)
        graph.insertEdge(from: "b", to: "t", withWeight: 4.0)
        XCTAssertEqual(graph.shortestUnweightedPath(from: "s", to: "t")!.adjacents.count, 2)
    }
}
