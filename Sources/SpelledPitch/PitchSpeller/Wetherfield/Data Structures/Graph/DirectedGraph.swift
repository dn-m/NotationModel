//
//  DirectedGraph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

struct DirectedGraph <Node: Hashable>: UnweightedGraphProtocol, DirectedGraphProtocol {
    typealias Edge = OrderedPair<Node>
    var nodes: Set<Node>
    var edges: Set<Edge>
    init(_ nodes: Set<Node> = [], _ edges: Set<Edge> = []) {
        self.nodes = nodes
        self.edges = edges
    }
}

extension DirectedGraph: Equatable { }
extension DirectedGraph: Hashable { }
