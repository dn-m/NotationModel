//
//  FlowNetworkTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/21/18.
//

import XCTest
@testable import SpelledPitch

class FlowNetworkTests: XCTestCase {

    var simpleFlowNetwork: FlowNetwork<String,Int> {
        var graph = WeightedDirectedGraph<String,Int>()
        graph.insert("s")
        graph.insert("t")
        graph.insert("a")
        graph.insert("b")
        graph.insertEdge(from: "s", to: "a", weight: 1)
        graph.insertEdge(from: "s", to: "b", weight: 2)
        graph.insertEdge(from: "a", to: "t", weight: 3)
        graph.insertEdge(from: "b", to: "t", weight: 4)
        return FlowNetwork(graph, source: "s", sink: "t")
    }

    func assertDuality <Node> (_ flowNetwork: FlowNetwork<Node,Double>) {
        let minCut = flowNetwork.minimumCut
        let diGraph = flowNetwork.directedGraph
        let solvedFlow = flowNetwork.solvedForMaximumFlow.flow
        let cutValue = minCut.0.lazy.map { startNode in
            return diGraph.neighbors(of: startNode, in: minCut.1).lazy
                .compactMap { diGraph.weight(from: startNode, to: $0) }
                .reduce(0,+)
            }
            .reduce(0,+)
        XCTAssertLessThanOrEqual(cutValue, solvedFlow + 1E-5)
        XCTAssertGreaterThanOrEqual(cutValue + 1E-5, solvedFlow)
    }

    func assertDisconnectedness <Node,Weight> (_ flowNetwork: FlowNetwork<Node,Weight>) {
        let minCut = flowNetwork.minimumCut
        let residualNetwork = flowNetwork.solvedForMaximumFlow.network
        minCut.0.lazy.forEach { startNode in
            minCut.1.lazy.forEach { endNode in
                XCTAssertFalse(residualNetwork.contains(OrderedPair(startNode,endNode)))
                XCTAssert(Set(residualNetwork.breadthFirstSearch(from: startNode)).isDisjoint(with: minCut.1))
            }
        }
    }

    func testMinimumCut() {
        print(simpleFlowNetwork.minimumCut)
        XCTAssertEqual(simpleFlowNetwork.minimumCut.0, Set(["s"]))
    }

    func testRandomNetwork() {
        let iterations = 10
        (0..<iterations).forEach { _ in
            var randomNetwork = FlowNetwork<Int,Double>(
                WeightedDirectedGraph<Int,Double>([0,1], [:]),
                source: 0,
                sink: 1
            )
            (2..<100).forEach { randomNetwork.directedGraph.insert($0) }
            (0..<100).forEach { source in
                (0..<100).forEach { destination in
                    if Double.random(in: 0...1) < 0.3 {
                        randomNetwork.directedGraph.insertEdge(
                            from: source,
                            to: destination,
                            weight: Double.random(in: 0...1)
                        )
                    }
                }
            }
            assertDuality(randomNetwork)
            assertDisconnectedness(randomNetwork)
        }
    }
}
