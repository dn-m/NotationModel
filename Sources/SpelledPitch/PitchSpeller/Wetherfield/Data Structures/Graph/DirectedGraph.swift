////
////  DirectedGraph.swift
////  SpelledPitch
////
////  Created by James Bean on 9/22/18.
////
//
///// Unweighted, directed graph.
//struct DirectedGraph <Node: Hashable>: UnweightedGraphProtocol, DirectedGraphProtocol {
//
//    // MARK: - Instance Properties
//
//    /// All of the nodes contained herein.
//    ///
//    /// A `Node` is any `Hashable`-conforming value.
//    var nodes: Set<Node>
//
//    /// All of the edges contained herein.
//    ///
//    /// An `Edge` is an `OrderedPair` of `Node` values.
//    var edges: Set<Edge>
//}
//
//extension DirectedGraph {
//
//    // MARK: - Type Aliases
//
//    /// The type of edges which connect nodes.
//    typealias Edge = OrderedPair<Node>
//}
//
//extension DirectedGraph {
//
//    // MARK: - Initializers
//
//    /// Creates a `DirectedGraph` with the given set of nodes, with no edges between the nodes.
//    init(_ nodes: Set<Node> = []) {
//        self.nodes = nodes
//        self.edges = []
//    }
//
//    /// Creates a `DirectedGraph` with the given set of nodes and the given set of edges connecting the
//    /// nodes.
//    init(_ nodes: Set<Node> = [], _ edges: Set<Edge> = []) {
//        self.init(nodes)
//        self.edges = edges
//    }
//
//    /// Creates a `DirectedGraph` which is composed a path of nodes.
//    init <C> (path: C) where C: Collection, C.Element == Node {
//        self.nodes = Set(path)
//        self.edges = Set(nodes.pairs.map(OrderedPair.init))
//    }
//}
//
//extension DirectedGraph {
//
//    // MARK: - Instance Methods
//
//    /// - Returns: A set of edges which emanate from the given `source` node.
//    func edges(from source: Node) -> Set<Edge> {
//        return edges.filter { $0.a == source }
//    }
//
//    /// - Returns: A set of nodes connected to the given `source`, in the given set of
//    /// `nodes`.
//    ///
//    /// If `nodes` is empty, then any nodes contained herein are able to be included in the
//    /// resultant set.
//    func neighbors(of source: Node, in nodes: Set<Node>? = nil) -> Set<Node> {
//        return (nodes ?? self.nodes).filter { edges.contains(Edge(source,$0)) }
//    }
//}
//
//extension DirectedGraph: Equatable { }
//extension DirectedGraph: Hashable { }
