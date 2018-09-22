//
//  Graph.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/14/18.
//

// MARK: - Directedness Flags

protocol Directedness { }
protocol Directed: Directedness { }
protocol Undirected: Directedness { }

typealias DirectedOver = OrderedPair
extension DirectedOver: Directed { }

typealias UndirectedOver = UnorderedPair
extension UndirectedOver: Undirected { }

// MARK: - Weightedness Flags

protocol Weightedness { }
struct Unweighted: Weightedness { }

protocol _Graph {
    associatedtype Node: Hashable
    associatedtype Edge: SymmetricPair & Hashable where Edge.A == Node
    var nodes: Set<Node> { get set }
    func neighbors(of source: Node, in nodes: Set<Node>?) -> Set<Node>
}

extension _Graph {

    func contains(_ node: Node) -> Bool {
        return nodes.contains(node)
    }

    mutating func insert(_ node: Node) {
        nodes.insert(node)
    }
}

protocol _DirectedGraph: _Graph where Edge == OrderedPair<Node> { }
protocol _UndirectedGraph: _Graph where Edge == UnorderedPair<Node> { }

protocol _WeightedGraph: _Graph {
    associatedtype Weight: Numeric
    var adjacents: [Edge: Weight] { get set }
    init(_ nodes: Set<Node>, _ adjacents: [Edge: Weight])
}

extension _WeightedGraph {

    func contains(_ edge: Edge) -> Bool {
        return adjacents.keys.contains(edge)
    }

    func neighbors(of source: Node, in nodes: Set<Node>? = nil) -> Set<Node> {
        return (nodes ?? self.nodes).filter { contains(Edge(source,$0)) }
    }

    mutating func removeEdge (from source: Node, to destination: Node) {
        adjacents[Edge(source, destination)] = nil
    }
}

protocol _UnweightedGraph: _Graph {
    var edges: Set<Edge> { get set }
    init(_ nodes: Set<Node>, _ edges: Set<Edge>)
}

extension _UnweightedGraph {

    func contains(_ edge: Edge) -> Bool {
        return edges.contains(edge)
    }

    func neighbors(of source: Node, in nodes: Set<Node>? = nil) -> Set<Node> {
        return (nodes ?? self.nodes).filter { destination in
            edges.contains(Edge(source,destination))
        }
    }

    mutating func insertEdge(from source: Node, to destination: Node) {
        edges.insert(Edge(source,destination))
    }

    mutating func removeEdge (from source: Node, to destination: Node) {
        edges.remove(Edge(source,destination))
    }
}

extension _WeightedGraph {
    func unweighted <U> () -> U where U: _UnweightedGraph, U.Edge == Edge {
        return .init(nodes, Set(adjacents.keys))
    }
}

extension _WeightedGraph {

    func weight(for edge: Edge) -> Weight? {
        return adjacents[edge]
    }

    func weight(from source: Node, to destination: Node) -> Weight? {
        return adjacents[Edge(source,destination)]
    }

    mutating func insertEdge(from source: Node, to destination: Node, weight: Weight) {
        adjacents[Edge(source,destination)] = weight
    }
    mutating func insertEdge(_ edge: Edge, weight: Weight) {
        adjacents[edge] = weight
    }
    mutating func updateEdge(_ edge: Edge, by transform: (Weight) -> Weight) {
        guard let weight = weight(for: edge) else { return }
        insertEdge(edge, weight: transform(weight))
    }
}

struct _WeightedDirectedGraph <Node: Hashable, Weight: Numeric>: _WeightedGraph, _DirectedGraph {
    typealias Edge = OrderedPair<Node>
    var nodes: Set<Node> = []
    var adjacents: [Edge: Weight] = [:]
    init(_ nodes: Set<Node>, _ adjacents: [Edge: Weight]) {
        self.nodes = nodes
        self.adjacents = adjacents
    }
}

struct _WeightedUndirectedGraph <Node: Hashable, Weight: Numeric>: _WeightedGraph, _UndirectedGraph {
    typealias Edge = UnorderedPair<Node>
    var nodes: Set<Node> = []
    var adjacents: [Edge: Weight] = [:]
    init(_ nodes: Set<Node>, _ adjacents: [Edge: Weight]) {
        self.nodes = nodes
        self.adjacents = adjacents
    }
}

struct _UnweightedDirectedGraph <Node: Hashable>: _UnweightedGraph, _DirectedGraph {
    typealias Edge = OrderedPair<Node>
    var nodes: Set<Node> = []
    var edges: Set<Edge> = []
    init(_ nodes: Set<Node>, _ edges: Set<Edge>) {
        self.nodes = nodes
        self.edges = edges
    }
}

struct _UnweightedUndirectedGraph <Node: Hashable>: _UnweightedGraph, _UndirectedGraph {
    typealias Edge = UnorderedPair<Node>
    var nodes: Set<Node> = []
    var edges: Set<Edge> = []
    init(_ nodes: Set<Node>, _ edges: Set<Edge>) {
        self.nodes = nodes
        self.edges = edges
    }
}

// Weightable, directable implementation of a Graph structure.
struct Graph <Weight, Pair: SymmetricPair & Directedness & Hashable> where Pair.A: Hashable {

    // MARK: - Instance Properties
     
    var nodes: Set<Node>
    var adjacents: [Pair: Weight]
}

extension Graph {

    // MARK: - Type Aliases

    typealias Node = Pair.A
}

extension Graph {

    // MARK: - Nested Types

    struct Edge {

        // MARK: - Instance Properties

        let nodes: Pair
        let weight: Weight

        // MARK: - Initializers

        init (_ a: Graph.Node, _ b: Graph.Node, withWeight weight: Weight) {
            self.nodes = Pair(a, b)
            self.weight = weight
        }

        init (_ nodes: Pair, withWeight weight: Weight) {
            self.nodes = nodes
            self.weight = weight
        }
    }

    struct Path {

        // MARK: - Instance Properties

        let nodes: [Node]
        let weights: [Pair: Weight]

        // MARK: - Initializers

        init (_ nodes: [Node], _ weights: [Pair: Weight]) {
            self.nodes = nodes
            self.weights = weights
        }
    }
}

extension Graph {

    // MARK: - Initializers

    /// Creates a `Graph` without nodes.
    init () {
        nodes = []
        adjacents = [:]
    }

    /// Creates a `Graph` with the given `nodes` and `adjacents`, describing how the given `nodes`
    /// are connected.
    init (_ nodes: Set<Node>, _ adjacents: [Pair: Weight]) {
        self.nodes = nodes
        self.adjacents = adjacents
    }
}

extension Graph {

    // MARK: - Computed Properties

    /// - Returns: All of the `Edge` values contained herein.
    ///
    /// - Remark: Consider returning a `Set` instead of an `Array`, as order does not have
    /// significance.
    var edges: [Edge] {
        return adjacents.map(Edge.init)
    }
}

extension Graph {

    // MARK: - Modifying a `Graph`

    /// Inserts the given `node` into the `Graph`.
    mutating func insertNode (_ node: Node) {
        nodes.insert(node)
    }

    /// Connects the `source` node to the `destination` with the given `weight`.
    ///
    /// - Remark: We should consider only exposing this for weighted graphs.
    mutating func insertEdge (from source: Node, to destination: Node, withWeight weight: Weight) {
        adjacents[Pair(source, destination)] = weight
    }

    /// Inserts the given pair-value pair into the `Graph`.
    mutating func insertEdge (_ pairAndWeight: (pair: Pair, weight: Weight)) {
        insertEdge(pairAndWeight.pair, pairAndWeight.weight)
    }

    /// Insert an `Edge` between the given `pair` with the given `weight`.
    ///
    /// - Remark: We should consider only exposing this for weighted graphs.
    mutating func insertEdge(_ pair: Pair, _ weight: Weight) {
        insertEdge(from: pair.a, to: pair.b, withWeight: weight)
    }

    /// Updates the weight of the edge connecting the given `pair`.
    ///
    /// > If the nodes in the given `pair` do not exist, or are no connected, no action is taken.
    mutating func updateEdge(_ pair: Pair, with transform: (Weight) -> Weight) {
        guard let weight = weight(pair) else { return }
        insertEdge(pair, transform(weight))
    }

    /// Inserts the given `path` into the `Graph`.
    mutating func insertPath (_ path: Path) {
        path.nodes.forEach { insertNode($0) }
        path.weights.forEach { insertEdge($0) }
    }

    /// Removes the edge between the given `source` and `destination` nodes.
    mutating func removeEdge (from source: Node, to destination: Node) {
        adjacents[Pair(source, destination)] = nil
    }
}

extension Graph {

    // MARK: - Querying a `Graph`

    /// - Returns: `true` if the graph contains this `node`, else `false`
    func contains (_ node: Node) -> Bool {
        return nodes.contains(node)
    }

    /// - Returns: `true` if `edge.nodes` are adjacent in the graph, else `false`
    func contains (_ edge: Pair) -> Bool {
        return adjacents.keys.contains(edge)
    }

    /// - Returns: Weight of the edge from `source` to `destination` if it exists, else nil
    func weight (from source: Node, to destination: Node) -> Weight? {
        return weight(Pair(source, destination))
    }

    /// - Returns: Weight of the edge containing this `pair` of nodes if it exists, else nil
    func weight (_ pair: Pair) -> Weight? {
        return adjacents[pair]
    }

    /// - Returns: Array of nodes adjacent to `source`
    func neighbors (of source: Node) -> [Node] {
        return nodes.filter { adjacents.keys.contains(Pair(source, $0)) }
    }

    /// - Returns: Array of nodes adjacent to `source` out of the supplied array of `nodes`.
    func neighbors (of source: Node, from nodes: [Node]) -> [Node] {
        return neighbors(of: source, from: Set(nodes))
    }

    /// - Returns: Array of nodes adjacent to `source` out of the supplied set of `nodes`.
    func neighbors (of source: Node, from nodes: Set<Node>) -> [Node] {
        return nodes.filter { adjacents.keys.contains(Pair(source, $0)) }
    }

    /// - Returns: Array of edges emanating from `source`
    func edges (from source: Node) -> [Edge] {
        return nodes.compactMap {
            guard let weight = adjacents[Pair(source, $0)] else { return nil }
            return Edge(source, $0, withWeight: weight)
        }
    }
}

extension Graph where Weight == Unweighted {
    
    // MARK: - Instance Methods
    
    mutating func insertEdge (from source: Node, to destination: Node) {
        insertEdge(from: source, to: destination, withWeight: .init())
    }
    
    mutating func insertPath (_ nodes: [Graph.Node]) {
        insertPath(Path(nodes))
    }
}

extension Graph {
    
    // MARK: - Instance Methods
    
//    static func unWeightedVersion (of weightedGraph: Graph) -> Graph<Unweighted, Pair> {
//        let adjacents: [Pair: Unweighted] = weightedGraph.adjacents.mapValues { _ in .init() }
//        return Graph<Unweighted, Pair>(weightedGraph.nodes, adjacents)
//    }

    var unweighted: Graph<Unweighted,Pair> {
        return .init(nodes, adjacents.mapValues { _ in .init() })
    }
}

extension Graph.Edge where Weight == Unweighted {
    
    // MARK: - Initializers
    
    init (_ a: Graph.Node, _ b: Graph.Node) {
        self.nodes = Pair(a, b)
        self.weight = .init()
    }
}

extension Graph where Pair: SwappablePair {
    
    // MARK: - Instance Methods
    
//    mutating func flipEdge (containing nodes: Pair) {
//        adjacents[nodes.swapped] = adjacents[nodes]
//        adjacents[nodes] = nil
//    }
}

extension Graph.Path where Weight == Unweighted {
    
    // MARK: - Instance properties
    
    var adjacents: Set<Pair> {
        return Set(weights.keys)
    }
    
    // MARK: - Initializers
    
    init (_ nodes: [Graph.Node]) {
        let count = nodes.count
        var weights: [Pair: Weight] = [:]
        nodes.enumerated().forEach { index, currentNode in
            if index <= count - 2 {
                let nextNode = nodes[index + 1]
                weights[Pair(currentNode, nextNode)] = .init()
            }
        }
        self.init(nodes, weights)
    }
}

extension Graph.Edge where Pair: Directed {
    
    // MARK: - Instance Properties
    
    var source: Graph.Node { return nodes.a }
    var destination: Graph.Node { return nodes.b }
}

extension Graph {
    
    // MARK: = Typealiases
    
    typealias UnweightedPath = Graph<Unweighted, DirectedOver<Node>>.Path
    
    // MARK: - Instance Methods
    
    func shortestUnweightedPath (from source: Node, to destination: Node) -> UnweightedPath? {
        
        var breadcrumbs: [Node: Node] = [:]
        
        func backtrace () -> UnweightedPath {
            var path = [destination]
            var cursor = destination
            while cursor != source {
                path.insert(breadcrumbs[cursor]!, at: 0)
                cursor = breadcrumbs[cursor]!
            }
            return UnweightedPath(path)
        }
        
        if source == destination { return UnweightedPath([destination]) }
        
        var unvisited = nodes
        var queue: Queue<Node> = []
        
        queue.push(source)
        while !queue.isEmpty {
            let node = queue.pop()
            for neighbor in neighbors(of: node, from: unvisited) {
                queue.push(neighbor)
                unvisited.remove(neighbor)
                breadcrumbs[neighbor] = node
                if neighbor == destination { return backtrace() }
            }
        }
        return nil
    }
    
    internal func breadthFirstSearch(from source: Node) -> [Node] {
        var visited: [Node] = []
        var queue: Queue<Node> = []
        queue.push(source)
        visited.append(source)
        while !queue.isEmpty {
            let node = queue.pop()
            for neighbor in neighbors(of: node) where !visited.contains(neighbor) {
                queue.push(neighbor)
                visited.append(neighbor)
            }
        }
        return visited
    }
}
