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
        graph.addEdge(from: source, to: a, value: 1)
        graph.addEdge(from: source, to: b, value: 2)
        graph.addEdge(from: a, to: sink, value: 3)
        graph.addEdge(from: b, to: sink, value: 4)
        return FlowNetwork(graph, source: source, sink: sink)
    }

    func testEdmondsKarp() {
        let flowNetwork = simpleFlowNetwork
        //flowNetwork.edmondsKarp()
    }
 }
