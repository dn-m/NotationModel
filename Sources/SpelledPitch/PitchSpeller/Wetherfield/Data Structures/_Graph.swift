//
//  _Graph.swift
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

// Weightable, directable implementation of a _Graph structure.
struct _Graph <Weight, Pair: SymmetricPair & Directedness & Hashable> where Pair.A: Hashable {

    // MARK: - Instance Properties
     
    var nodes: Set<Node>
    var adjacents: [Pair: Weight]
}

extension _Graph {

    // MARK: - Type Aliases

    typealias Node = Pair.A
}

extension _Graph {

    // MARK: - Nested Types

    struct Edge {

        // MARK: - Instance Properties

        let nodes: Pair
        let weight: Weight

        // MARK: - Initializers

        init (_ a: _Graph.Node, _ b: _Graph.Node, withWeight weight: Weight) {
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

extension _Graph {

    // MARK: - Initializers

    /// Creates a `_Graph` without nodes.
    init () {
        nodes = []
        adjacents = [:]
    }

    /// Creates a `_Graph` with the given `nodes` and `adjacents`, describing how the given `nodes`
    /// are connected.
    init (_ nodes: Set<Node>, _ adjacents: [Pair: Weight]) {
        self.nodes = nodes
        self.adjacents = adjacents
    }
}

extension _Graph {

    // MARK: - Computed Properties

    /// - Returns: All of the `Edge` values contained herein.
    ///
    /// - Remark: Consider returning a `Set` instead of an `Array`, as order does not have
    /// significance.
    var edges: [Edge] {
        return adjacents.map(Edge.init)
    }
}

extension _Graph {

    // MARK: - Modifying a `_Graph`

    /// Inserts the given `node` into the `_Graph`.
    mutating func insertNode (_ node: Node) {
        nodes.insert(node)
    }

    /// Connects the `source` node to the `destination` with the given `weight`.
    ///
    /// - Remark: We should consider only exposing this for weighted graphs.
    mutating func insertEdge (from source: Node, to destination: Node, withWeight weight: Weight) {
        adjacents[Pair(source, destination)] = weight
    }

    /// Inserts the given pair-value pair into the `_Graph`.
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

    /// Inserts the given `path` into the `_Graph`.
    mutating func insertPath (_ path: Path) {
        path.nodes.forEach { insertNode($0) }
        path.weights.forEach { insertEdge($0) }
    }

    /// Removes the edge between the given `source` and `destination` nodes.
    mutating func removeEdge (from source: Node, to destination: Node) {
        adjacents[Pair(source, destination)] = nil
    }
}

extension _Graph {

    // MARK: - Querying a `_Graph`

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

extension _Graph where Weight == Unweighted {
    
    // MARK: - Instance Methods
    
    mutating func insertEdge (from source: Node, to destination: Node) {
        insertEdge(from: source, to: destination, withWeight: .init())
    }
    
    mutating func insertPath (_ nodes: [_Graph.Node]) {
        insertPath(Path(nodes))
    }
}

extension _Graph {
    
    // MARK: - Instance Methods

    var unweighted: _Graph<Unweighted,Pair> {
        return .init(nodes, adjacents.mapValues { _ in .init() })
    }
}

extension _Graph.Edge where Weight == Unweighted {
    
    // MARK: - Initializers
    
    init (_ a: _Graph.Node, _ b: _Graph.Node) {
        self.nodes = Pair(a, b)
        self.weight = .init()
    }
}

extension _Graph.Path where Weight == Unweighted {
    
    // MARK: - Instance properties
    
    var adjacents: Set<Pair> {
        return Set(weights.keys)
    }
    
    // MARK: - Initializers
    
    init (_ nodes: [_Graph.Node]) {
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

extension _Graph.Edge where Pair: Directed {
    
    // MARK: - Instance Properties
    
    var source: _Graph.Node { return nodes.a }
    var destination: _Graph.Node { return nodes.b }
}

extension _Graph {
    
    // MARK: = Typealiases
    
    typealias UnweightedPath = _Graph<Unweighted, DirectedOver<Node>>.Path
    
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
        
        queue.enqueue(source)
        while !queue.isEmpty {
            let node = queue.dequeue()
            for neighbor in neighbors(of: node, from: unvisited) {
                queue.enqueue(neighbor)
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
        queue.enqueue(source)
        visited.append(source)
        while !queue.isEmpty {
            let node = queue.dequeue()
            for neighbor in neighbors(of: node) where !visited.contains(neighbor) {
                queue.enqueue(neighbor)
                visited.append(neighbor)
            }
        }
        return visited
    }
}
