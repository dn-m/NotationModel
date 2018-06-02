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
        var graph = Graph<String>()
        let source = graph.createNode("source")
        let sink = graph.createNode("sink")
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        graph.insertEdge(from: source, to: a, value: 1)
        graph.insertEdge(from: source, to: b, value: 2)
        graph.insertEdge(from: a, to: sink, value: 3)
        graph.insertEdge(from: b, to: sink, value: 4)
        return FlowNetwork(graph, source: source, sink: sink)
    }

    func testEdmondsKarp() {
        let flowNetwork = simpleFlowNetwork
        let residualNetwork = flowNetwork.edmondsKarp()
        print(residualNetwork)
    }

    func testMaximumPathFlow() {
        var graph = Graph<String>()
        let source = graph.createNode("source")
        let sink = graph.createNode("sink")
        let a = graph.createNode("a")
        let b = graph.createNode("b")
        graph.insertEdge(from: source, to: a, value: 1)
        graph.insertEdge(from: a, to: b, value: 2)
        graph.insertEdge(from: b, to: sink, value: 3)
        let flowNetwork = FlowNetwork(graph, source: source, sink: sink)
        let path = graph.shortestPath(from: source, to: sink)!
        XCTAssertEqual(flowNetwork.maximumFlow(of: path), 1)
    }

    func testSaturatedEdges() {

        // Example taken from: https://en.wikipedia.org/wiki/Edmonds%E2%80%93Karp_algorithm
        var graph = Graph<String>()

        // source
        let a = graph.createNode("a")

         // sink
        let b = graph.createNode("b")

        // internal nodes
        let c = graph.createNode("c")
        let d = graph.createNode("d")
        let e = graph.createNode("e")
        let f = graph.createNode("f")
        let g = graph.createNode("g")

        // hook 'em up
        graph.insertEdge(from: a, to: b, value: 3)
        graph.insertEdge(from: a, to: d, value: 3)
        graph.insertEdge(from: b, to: c, value: 4)
        graph.insertEdge(from: c, to: a, value: 3)
        graph.insertEdge(from: c, to: e, value: 2)
        graph.insertEdge(from: e, to: b, value: 1)
        graph.insertEdge(from: c, to: d, value: 1)
        graph.insertEdge(from: d, to: f, value: 6)
        graph.insertEdge(from: d, to: e, value: 2)
        graph.insertEdge(from: e, to: g, value: 1)
        graph.insertEdge(from: f, to: g, value: 9)
        let flowNetwork = FlowNetwork(graph, source: a, sink: g)

        let ad = graph.edge(from: a, to: d)!
        let cd = graph.edge(from: c, to: d)!
        let eg = graph.edge(from: e, to: g)!
        XCTAssertEqual(flowNetwork.saturatedEdges, [ad, cd, eg])
    }

    func testPartitions() {

        // Example taken from: https://www.geeksforgeeks.org/minimum-cut-in-a-directed-graph/
        var graph = Graph<String>()

        // source
        let a = graph.createNode("a")

        // sink
        let b = graph.createNode("b")

        // internal nodes
        let c = graph.createNode("c")
        let d = graph.createNode("d")
        let e = graph.createNode("e")
        let f = graph.createNode("f")

        graph.insertEdge(from: a, to: b, value: 16)
        graph.insertEdge(from: a, to: c, value: 13)
        graph.insertEdge(from: b, to: c, value: 10)
        graph.insertEdge(from: c, to: b, value: 4)
        graph.insertEdge(from: b, to: d, value: 12)
        graph.insertEdge(from: d, to: c, value: 9)
        graph.insertEdge(from: c, to: e, value: 14)
        graph.insertEdge(from: e, to: d, value: 7)
        graph.insertEdge(from: d, to: f, value: 20)
        graph.insertEdge(from: e, to: f, value: 4)
        let flowNetwork = FlowNetwork(graph, source: a, sink: f)

        // Expected partitions
        let sourcePartition = Graph(graph.edges([a,b,c,e]))
        let sinkPartition = Graph(graph.edges([d,f]))
        XCTAssertEqual(flowNetwork.partitions.source, sourcePartition)
        XCTAssertEqual(flowNetwork.partitions.sink, sinkPartition)
    }
 }
