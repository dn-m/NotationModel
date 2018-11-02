//
//  AdjacencyCarryingTests.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 30/10/2018.
//

import XCTest
import DataStructures
@testable import SpelledPitch

class AdjacencyCarryingTests: XCTestCase {
    
    func testPullback() {
        var g = Graph<Int>()
        g.insert(3)
        g.insert(5)
        g.insertEdge(from: 3, to: 5)
        let intEdgeCheck = AdjacencyCarrying.build(from: g)
        let f: (Float) -> Int = { f in Int(f) }
        let floatEdgeCheck: AdjacencyCarrying<Graph<Float>> = intEdgeCheck.pullback(f)
        XCTAssertTrue(floatEdgeCheck.contains(UnorderedPair(3.14, 5.6)))
    }
    
    func testConvenienceConstructor() {
        let g = Graph<Int>([1,2,3])
        let gAdjacency = AdjacencyCarrying.build(from: g)
        XCTAssertFalse(gAdjacency.contains(UnorderedPair(1,2)))
    }
    
    func testMultiplicationInitializationFreeze() {
        var g = DirectedGraph<Int>([1,2,3])
        var h = Graph<Int>([1,2,3])
        let gAdjacency = AdjacencyCarrying.build(from: g)
        let hAdjacency = AdjacencyCarrying.build(from: h)
        g.insertEdge(from: 1, to: 2)
        h.insertEdge(from: 2, to: 1)
        g.insertEdge(from: 3, to: 1)
        h.insertEdge(from: 2, to: 3)
        let masked = gAdjacency * hAdjacency
        XCTAssertFalse(masked.contains(from: 1,to: 2))
        XCTAssertFalse(masked.contains(from: 3, to: 1))
        XCTAssertFalse(masked.contains(from: 2, to: 3))
    }
    
    func testMultiplicationDirectedH() {
        var g = DirectedGraph<Int>([1,2,3])
        var h = DirectedGraph<Int>([1,2,3])
        g.insertEdge(from: 1, to: 2)
        h.insertEdge(from: 1, to: 2)
        g.insertEdge(from: 3, to: 1)
        h.insertEdge(from: 2, to: 3)
        let gAdjacency = AdjacencyCarrying.build(from: g)
        let hAdjacency = AdjacencyCarrying.build(from: h)
        let masked = gAdjacency * hAdjacency
        XCTAssertTrue(masked.contains(from: 1, to: 2))
        XCTAssertFalse(masked.contains(from: 3, to: 1))
        XCTAssertFalse(masked.contains(from: 2, to: 3))
    }
    
    func testMultiplicationBuildOrderMatters() {
        var g = DirectedGraph<Int>([1,2,3])
        var h = DirectedGraph<Int>([1,2,3])
        let gAdjacency = AdjacencyCarrying.build(from: g)
        let hAdjacency = AdjacencyCarrying.build(from: h)
        g.insertEdge(from: 1, to: 2)
        h.insertEdge(from: 1, to: 2)
        g.insertEdge(from: 3, to: 1)
        h.insertEdge(from: 2, to: 3)
        let masked = gAdjacency * hAdjacency
        XCTAssertFalse(masked.contains(from: 1, to: 2))
    }
    
    func testAddition() {
        var g = DirectedGraph<Int>([1,2,3])
        var h = DirectedGraph<Int>([1,2,3])
        g.insertEdge(from: 1, to: 2)
        h.insertEdge(from: 1, to: 2)
        g.insertEdge(from: 3, to: 1)
        h.insertEdge(from: 2, to: 3)
        let gAdjacency = AdjacencyCarrying.build(from: g)
        let hAdjacency = AdjacencyCarrying.build(from: h)
        let combined = gAdjacency + hAdjacency
        XCTAssertTrue(combined.contains(from: 1, to: 2))
        XCTAssertTrue(combined.contains(from: 3, to: 1))
    }
}
