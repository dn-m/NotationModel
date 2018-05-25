//
//  FlowNetworkTests.swift
//  PitchSpellerTests
//
//  Created by James Bean on 5/24/18.
//

import XCTest
@testable import PitchSpeller

class FlowNetworkTests: XCTestCase {
    
    func testInitMonadNodeCount() {
        let flowNetwork = Wetherfield.FlowNetwork(pitchClasses: [0], parsimonyPivot: 2)
        XCTAssertEqual(flowNetwork.internalNodes.count, 2)
    }

    func testInitDyadNodeCount() {
        let flowNetwork = Wetherfield.FlowNetwork(pitchClasses: [0,1], parsimonyPivot: 2)
        XCTAssertEqual(flowNetwork.internalNodes.count, 4)
    }

    func testInitTriadEdges() {

        let flowNetwork = Wetherfield.FlowNetwork(pitchClasses: [0,1,6], parsimonyPivot: 2)

        for internalNode in flowNetwork.internalNodes {

            // Sink is not connected to anything
            XCTAssertNil(flowNetwork.graph.edgeValue(from: flowNetwork.sink, to: internalNode))

            // Nothing is not connected to the source
            XCTAssertNil(flowNetwork.graph.edgeValue(from: internalNode, to: flowNetwork.source))

            // Source is connected to all internal nodes
            XCTAssertNotNil(flowNetwork.graph.edgeValue(from: flowNetwork.source, to: internalNode))

            // All internal nodes are connected to sink
            XCTAssertNotNil(flowNetwork.graph.edgeValue(from: internalNode, to: flowNetwork.sink))

            // All internal nodes are connected to each other
            for otherNode in flowNetwork.internalNodes.lazy.filter({ $0 != internalNode}) {
                XCTAssertNotNil(flowNetwork.graph.edgeValue(from: internalNode, to: otherNode))
                XCTAssertNotNil(flowNetwork.graph.edgeValue(from: otherNode, to: internalNode))
            }
        }
    }

    func testPaths() {
        let flowNetwork = Wetherfield.FlowNetwork(pitchClasses: [0], parsimonyPivot: 2)

        //     (0,0)
        //    / || \
        //   s  ||  t
        //    \ || /
        //     (0,1)

        // Edges:
        // - Source -> 0,0
        // - Source -> 0,1
        // - 0,0 -> 0,1
        // - 0,1 -> 0,0
        // - 0,0 -> Sink
        // - 0,1 -> Sink

        // Paths:
        // - Source -> (0,0) -> t
        // - Source -> (0,1) -> t
        // - Source -> (0,0) -> (0,1) -> t
        // - Source -> (0,1) -> (0,0) -> t
    }
}
