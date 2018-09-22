//
//  WeightedGraph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

struct WeightedGraph <Node: Hashable, Weight: Numeric>:
    WeightedGraphProtocol,
    UndirectedGraphProtocol
{
    typealias Edge = UnorderedPair<Node>
    var nodes: Set<Node> = []
    var adjacents: [Edge: Weight] = [:]
    init(_ nodes: Set<Node>, _ adjacents: [Edge: Weight]) {
        self.nodes = nodes
        self.adjacents = adjacents
    }
}
