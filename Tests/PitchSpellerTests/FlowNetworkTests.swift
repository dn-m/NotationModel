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
 }
