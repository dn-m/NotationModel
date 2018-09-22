//
//  Graph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

struct Graph <Node: Hashable>: UnweightedGraphProtocol, UndirectedGraphProtocol {
    typealias Edge = UnorderedPair<Node>
    var nodes: Set<Node> = []
    var edges: Set<Edge> = []
    init(_ nodes: Set<Node>, _ edges: Set<Edge>) {
        self.nodes = nodes
        self.edges = edges
    }
}
