//
//  FlowNetworkTests.swift
//  PitchSpellerTests
//
//  Created by James Bean on 5/24/18.
//

import XCTest
@testable import PitchSpeller

class FlowNetworkTests: XCTestCase {

    var simpleFlowNetwork: FlowNetwork<String> {
        var graph = DirectedGraph<String>()
        graph.insertNode("s")
        graph.insertNode("t")
        graph.insertNode("a")
        graph.insertNode("b")
        graph.insertEdge(from: "s", to: "a", withWeight: 1)
        graph.insertEdge(from: "s", to: "b", withWeight: 2)
        graph.insertEdge(from: "a", to: "t", withWeight: 3)
        graph.insertEdge(from: "b", to: "t", withWeight: 4)
        return FlowNetwork(graph, source: "s", sink: "t")
    }
    
    func assertDuality (_ flowNetwork: FlowNetwork<String>) {
        let minCut = flowNetwork.minimumCut
        let diGraph = flowNetwork.directedGraph
        let cutValue = minCut.0.lazy.map {
            source in
            return diGraph.neighbors(of: source, from: minCut.1)
                .reduce(0.0, { $0 + diGraph.weight(from: source, to: $1)! })
        }
        .reduce(0.0, { $0 + $1 })
        XCTAssertEqual(cutValue, flowNetwork.solvedForMaximumFlow.flow)
    }
    
    func assertDisconnectedness (_ flowNetwork: FlowNetwork<String>) {
        let minCut = flowNetwork.minimumCut
        let residualNetwork = flowNetwork.solvedForMaximumFlow.network
        minCut.0.lazy.forEach {
            source in
            minCut.1.lazy.forEach {
                destination in
                XCTAssertNil(residualNetwork.weight(from: source, to: destination))
            }
            XCTAssert(Set(residualNetwork.breadthFirstSearch(from: source)).isDisjoint(with: minCut.1))
        }
    }

//    func testMaximumPathFlow() {
//        var graph = Graph<String>()
//        graph.insertNode("s")
//        graph.insertNode("t")
//        graph.insertNode("a")
//        graph.insertNode("b")
//        graph.insertEdge(from: "s", to: "a", value: 1)
//        graph.insertEdge(from: "a", to: "b", value: 2)
//        graph.insertEdge(from: "b", to: "t", value: 3)
//        let flowNetwork = FlowNetwork(graph, source: "s", sink: "t")
//        let path = graph.shortestPath(from: "s", to: "t")!
//        XCTAssertEqual(flowNetwork.maximumFlow(of: path), 1)
//    }

//    func testSaturatedEdges() {
//
//        // Example taken from: https://en.wikipedia.org/wiki/Edmonds%E2%80%93Karp_algorithm
//        var graph = Graph<String>()
//
//        // source
//        graph.insertNode("a")
//
//        // internal nodes
//        graph.insertNode("b")
//
//        graph.insertNode("c")
//        graph.insertNode("d")
//        graph.insertNode("e")
//        graph.insertNode("f")
//        graph.insertNode("g")
//
//        // hook 'em up
//        graph.insertEdge(from: "a", to: "b", value: 3)
//        graph.insertEdge(from: "a", to: "d", value: 3)
//        graph.insertEdge(from: "b", to: "c", value: 4)
//        graph.insertEdge(from: "c", to: "a", value: 3)
//        graph.insertEdge(from: "c", to: "e", value: 2)
//        graph.insertEdge(from: "e", to: "b", value: 1)
//        graph.insertEdge(from: "c", to: "d", value: 1)
//        graph.insertEdge(from: "d", to: "f", value: 6)
//        graph.insertEdge(from: "d", to: "e", value: 2)
//        graph.insertEdge(from: "e", to: "g", value: 1)
//        graph.insertEdge(from: "f", to: "g", value: 9)
//
//        let flowNetwork = FlowNetwork(graph, source: "a", sink: "g")
//
//        let ad = graph.edge(from: "a", to: "d")!
//        let cd = graph.edge(from: "c", to: "d")!
//        let eg = graph.edge(from: "e", to: "g")!
//
//        XCTAssertEqual(flowNetwork.saturatedEdges, [ad, cd, eg])
//    }

//    func testPartitions() {
//
//        // Example taken from: https://www.geeksforgeeks.org/minimum-cut-in-a-directed-graph/
//        var graph = Graph<String>()
//
//        // source
//        graph.insertNode("a")
//
//        // internal nodes
//        graph.insertNode("b")
//        graph.insertNode("c")
//        graph.insertNode("d")
//        graph.insertNode("e")
//
//        // sink
//        graph.insertNode("f")
//
//        graph.insertEdge(from: "a", to: "b", value: 16)
//        graph.insertEdge(from: "a", to: "c", value: 13)
//        graph.insertEdge(from: "b", to: "c", value: 10)
//        graph.insertEdge(from: "c", to: "b", value: 4)
//        graph.insertEdge(from: "b", to: "d", value: 12)
//        graph.insertEdge(from: "d", to: "c", value: 9)
//        graph.insertEdge(from: "c", to: "e", value: 14)
//        graph.insertEdge(from: "e", to: "d", value: 7)
//        graph.insertEdge(from: "d", to: "f", value: 20)
//        graph.insertEdge(from: "e", to: "f", value: 4)
//        let flowNetwork = FlowNetwork(graph, source: "a", sink: "f")
//
//        // Expected partitions
//        let sourceEdges = graph.edges(["a","b","c","e"])
//        let sourcePartition = Graph<String>(sourceEdges)
//        let sinkEdges = graph.edges(["d","f"])
//        let sinkPartition = Graph<String>(sinkEdges)
//        XCTAssertEqual(flowNetwork.partitions.source, sourcePartition)
//        XCTAssertEqual(flowNetwork.partitions.sink, sinkPartition)
//    }
 }
