//
//  FlowNetworkTests.swift
//  SpelledPitchTests
//
//  Created by James Bean on 9/21/18.
//

import XCTest
import Algebra
import DataStructures
@testable import SpelledPitch

class FlowNetworkTests: XCTestCase {

    /// Simple flow network which looks like this:
    ///     a
    ///  1 / \ 3
    ///   s   t
    ///  2 \ / 4
    ///     b
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
        let diGraph = flowNetwork
        let solvedFlow = flowNetwork.maximumFlowAndResidualNetwork.flow
        let cutValue = minCut.0.lazy.map { startNode in
            return diGraph.neighbors(of: startNode, in: minCut.1).lazy
                .compactMap { diGraph.weight(from: startNode, to: $0) }
                .sum
            }.sum
        XCTAssertLessThanOrEqual(cutValue, solvedFlow + 1E-5)
        XCTAssertGreaterThanOrEqual(cutValue + 1E-5, solvedFlow)
    }
    
    func assertDisconnectedness <Node,Weight> (_ flowNetwork: FlowNetwork<Node,Weight>) {
        let minCut = flowNetwork.minimumCut
        let residualNetwork = flowNetwork.maximumFlowAndResidualNetwork.network
        minCut.0.lazy.forEach { startNode in
            minCut.1.lazy.forEach { endNode in
                XCTAssertFalse(residualNetwork.contains(OrderedPair(startNode,endNode)))
                XCTAssert(Set(residualNetwork.breadthFirstSearch(from: startNode)).isDisjoint(with: minCut.1))
            }
        }
    }
    
    func testMinimumCut() {
        XCTAssertEqual(simpleFlowNetwork.minimumCut.0, ["s"])
        XCTAssertEqual(simpleFlowNetwork.minimumCut.1, ["a","b","t"])
    }
    
    func testUnreachableMinimumCut() {
        var graph = WeightedDirectedGraph<String,Int>()
        graph.insert("s")
        graph.insert("a")
        graph.insert("b")
        graph.insert("t")
        graph.insertEdge(from: "s", to: "a", weight: 2)
        graph.insertEdge(from: "a", to: "b", weight: 2)
        graph.insertEdge(from: "b", to: "t", weight: 3)
        let cut = FlowNetwork(graph, source: "s", sink: "t").minimumCut
        XCTAssertEqual(cut.0.union(cut.1), ["s", "a", "t", "b"])
    }
    
    func testFlowNetworkAbsorbsSourceSink() {
        var graph = WeightedDirectedGraph<String,Double>()
        graph.insert("a")
        let flowNetwork = FlowNetwork(graph, source: "s", sink: "t")
        XCTAssert(flowNetwork.contains("s"))
        XCTAssert(flowNetwork.contains("t"))
        XCTAssert(flowNetwork.contains("a"))
    }

    func testFlowNetworkMaskEmpty() {
        let weightScheme = WeightedGraphScheme<String,Int> { _ in nil }
        var flowNetwork = simpleFlowNetwork
        flowNetwork.mask(weightScheme)
        XCTAssertEqual(flowNetwork.nodes, simpleFlowNetwork.nodes)
        XCTAssert(flowNetwork.edges.isEmpty)
    }

    func testFlowNetworkMaskSquared() {
        let maskScheme = WeightedGraphScheme<String,Int> { edge in
            self.simpleFlowNetwork.weight(from: edge.a, to: edge.b)
        }
        var flowNetwork = simpleFlowNetwork
        flowNetwork.mask(maskScheme)
        for edge in flowNetwork.edges {
            let expected = simpleFlowNetwork.weight(edge)! * simpleFlowNetwork.weight(edge)!
            XCTAssertEqual(flowNetwork.weight(edge)!, expected)
        }
    }

    func testFlowNetworkMaskPullback() {
        var maskGraph = WeightedGraph<Int,Int>()
        maskGraph.insertEdge(from: 0, to: 1, weight: 1)
        maskGraph.insertEdge(from: 1, to: 2, weight: 2)
        let maskScheme: WeightedDirectedGraphScheme<String,Int> = WeightedDirectedGraphScheme<Int,Int> { edge in
                maskGraph.weight(from: edge.a, to: edge.b)
            }.pullback { (s: String) -> Int in s.count }
        var graph = WeightedDirectedGraph<String,Int>()
        graph.insertEdge(from: "", to: ".", weight: 3)
        graph.insertEdge(from: ".", to: "..", weight: 5)
        var flowNetwork = FlowNetwork(graph, source: "", sink: "..")
        flowNetwork.mask(maskScheme)
        XCTAssertEqual(flowNetwork.weight(from: "", to: "."), 3)
        XCTAssertEqual(flowNetwork.weight(from: ".", to: ".."), 10)
    }

    func testPitchSpellingTestCase() {
        let expectedGraph = WeightedDirectedGraph<PitchSpellingNode.Index,Double> (Set([
            .internal(.init(1,.down)),
            .internal(.init(1,.up)),
            .internal(.init(3,.down)),
            .internal(.init(3,.up)),
            .source,
            .sink]), [
                
                // source edges
                .init(.source,                  .internal(.init(1,.down))): 3,
                .init(.source,                  .internal(.init(3,.down))): 1,
                
                //sink edges
                .init(.internal(.init(1,  .up)),                    .sink): 1,
                .init(.internal(.init(3,  .up)),                    .sink): 3,
                
                // bigM edges
                .init(.internal(.init(1,  .up)),.internal(.init(1,.down))): Double.infinity,
                .init(.internal(.init(3,  .up)),.internal(.init(3,.down))): Double.infinity,
                
                // internal edges
                .init(.internal(.init(1,  .up)),.internal(.init(3,.down))): 0.5,
                .init(.internal(.init(1,.down)),.internal(.init(3,  .up))): 4,
                .init(.internal(.init(3,  .up)),.internal(.init(1,.down))): 4,
                .init(.internal(.init(3,.down)),.internal(.init(1,  .up))): 0.5,
                ]
        )
        let expectedFlowNetwork = FlowNetwork<PitchSpellingNode.Index,Double> (
            expectedGraph, source: .source, sink: .sink
        )
        let (sourceNodes, sinkNodes) = expectedFlowNetwork.minimumCut
        let expectedSourceNodes = Set<PitchSpellingNode.Index>([.source, .internal(.init(3, .down))])
        let expectedSinkNodes = Set<PitchSpellingNode.Index>([.sink,
                                                              .internal(.init(3, .up)),
                                                              .internal(.init(1, .down)),
                                                              .internal(.init(1, .up))])
        XCTAssertEqual(sourceNodes, expectedSourceNodes)
        XCTAssertEqual(sinkNodes, expectedSinkNodes)
    }

    #warning("Reinstate")
//    func testRandomNetwork() {
//        let iterations = 1
//        (0..<iterations).forEach { _ in
//            var randomNetwork = FlowNetwork<Int,Double>(
//                WeightedDirectedGraph<Int,Double>([0,1], [:]),
//                source: 0,
//                sink: 1
//            )
//            (2..<100).forEach { randomNetwork.insert($0) }
//            (0..<100).forEach { source in
//                (0..<100).forEach { destination in
//                    if Double.random(in: 0...1) < 0.3 {
//                        randomNetwork.insertEdge(
//                            from: source,
//                            to: destination,
//                            weight: Double.random(in: 0...1)
//                        )
//                    }
//                }
//            }
//            assertDuality(randomNetwork)
//            assertDisconnectedness(randomNetwork)
//        }
//    }
}
