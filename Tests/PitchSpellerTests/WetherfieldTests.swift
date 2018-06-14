//
//  WetherfieldTests.swift
//  PitchSpellerTests
//
//  Created by James Bean on 5/29/18.
//

import XCTest
import Foundation
import Pitch
@testable import PitchSpeller

class WetherfieldTests: XCTestCase {
    
    func testInitMonadNodeCount() {
        let speller = PitchSpeller(pitches: [60], parsimonyPivot: 2)
        XCTAssertEqual(speller.flowNetwork.internalNodes.count, 2)
    }

    func testInitDyadNodeCount() {
        let speller = PitchSpeller(pitches: [60,61], parsimonyPivot: 2)
        XCTAssertEqual(speller.flowNetwork.internalNodes.count, 4)
    }

    func testInitTriadEdges() {

        let speller = PitchSpeller(pitches: [60,61,66], parsimonyPivot: 2)
        let flowNetwork = speller.flowNetwork

        for internalNode in speller.flowNetwork.internalNodes {

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

    func testEdgeUpdating() {
        let speller = PitchSpeller(pitches: [60,61,66], parsimonyPivot: 2)
        let flowNetwork = speller.flowNetwork
        flowNetwork.internalNodes.forEach { print($0) }
    }

//    func testPaths() {
//        let flowNetwork = Wetherfield.PitchSpeller(pitch: [60], parsimonyPivot: 2)
//
//        //     (0,0)
//        //    / || \
//        //   s  ||  t
//        //    \ || /
//        //     (0,1)
//
//        // Edges:
//        // - Source -> 0,0
//        // - Source -> 0,1
//        // - 0,0 -> 0,1
//        // - 0,1 -> 0,0
//        // - 0,0 -> Sink
//        // - 0,1 -> Sink
//
//        // Paths:
//        // - Source -> (0,0) -> t
//        // - Source -> (0,1) -> t
//        // - Source -> (0,0) -> (0,1) -> t
//        // - Source -> (0,1) -> (0,0) -> t
//    }
}
