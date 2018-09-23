//
//  WeightedDirectedGraph.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

struct WeightedDirectedGraph <Node: Hashable, Weight: Numeric>:
    WeightedGraphProtocol,
    DirectedGraphProtocol
{
    typealias Edge = OrderedPair<Node>

    var nodes: Set<Node>
    var adjacents: [Edge: Weight]

    init(_ nodes: Set<Node> = [], _ adjacents: [Edge: Weight] = [:]) {
        self.nodes = nodes
        self.adjacents = adjacents
    }

    func edges(from source: Node) -> Set<Edge> {
        return Set(adjacents.keys.lazy.filter { $0.a == source })
    }
}

extension WeightedDirectedGraph: Equatable { }
extension WeightedDirectedGraph: Hashable where Weight: Hashable { }
