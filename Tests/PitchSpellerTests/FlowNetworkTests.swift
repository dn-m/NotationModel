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
    
    func assertDuality<Node> (_ flowNetwork: FlowNetwork<Node>) {
        let minCut = flowNetwork.minimumCut
        let diGraph = flowNetwork.directedGraph
        let solvedFlow = flowNetwork.solvedForMaximumFlow.flow
        let cutValue = minCut.0.lazy.map { startNode in
            return diGraph.neighbors(of: startNode, from: minCut.1).lazy
                .compactMap { diGraph.weight(from: startNode, to: $0) }
                .reduce(0.0, +)
        }
        .reduce(0.0, +)
        XCTAssertLessThanOrEqual(cutValue, solvedFlow + 1E-5)
        XCTAssertGreaterThanOrEqual(cutValue + 1E-5, solvedFlow)
    }
    
    func assertDisconnectedness<Node> (_ flowNetwork: FlowNetwork<Node>) {
        let minCut = flowNetwork.minimumCut
        let residualNetwork = flowNetwork.solvedForMaximumFlow.network
        minCut.0.lazy.forEach { startNode in
            minCut.1.lazy.forEach { endNode in
                XCTAssertNil(residualNetwork.weight(from: startNode, to: endNode))
                XCTAssert(Set(residualNetwork.breadthFirstSearch(from: startNode)).isDisjoint(with: minCut.1))
            }
        }
    }
    
    func testMinimumCut() {
        XCTAssertEqual(simpleFlowNetwork.minimumCut.0, Set(["s"]))
    }
    
    func testRandomNetwork() {
        let iterations = 1
        (0..<iterations).forEach { _ in
            var randomNetwork = FlowNetwork<Int>(DirectedGraph<Int>([0,1], [:]), source: 0, sink: 1)
            (2..<100).forEach { randomNetwork.directedGraph.insertNode($0) }
            (0..<100).forEach { source in
                (0..<100).forEach { destination in
                    if Double.random(in: 0...1) < 0.3 {
                        randomNetwork.directedGraph.insertEdge(from: source, to: destination, withWeight: Double.random(in: 0...1))
                    }
                }
            }
            assertDuality(randomNetwork)
            assertDisconnectedness(randomNetwork)
        }
    }
 }
