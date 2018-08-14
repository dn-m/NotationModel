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
protocol Unweighted: Weightedness { }
protocol AsWeight: Weightedness { }

// Allows Double to be used as an edge weight
extension Double: AsWeight { }
enum WithoutWeights: Unweighted {
    case unweighted
}

// Weightable, directable implementation of a Graph structure
struct _Graph<Weight: Weightedness, Pair: SymmetricPair & Directedness & Hashable> where Pair.A: Hashable {
    
    // MARK: - Typealiases
    
    typealias Node = Pair.A
    
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
    
    // MARK: - Instance Properties
     
    var nodes: Set<Node>
    var adjacents: [Pair: Weight]
    
    var edges: [Edge] {
        return adjacents.map(Edge.init)
    }
    
    // MARK: - Instance Methods
    
    mutating func insertNode (_ node: Node) {
        nodes.insert(node)
    }
    
    mutating func insertEdge (from source: Node, to destination: Node, withWeight weight: Weight) {
        adjacents[Pair(source, destination)] = weight
    }
    
    mutating func insertEdge (_ keyValue: (Pair, Weight)) {
        insertEdge(from: keyValue.0.a, to: keyValue.0.b, withWeight: keyValue.1)
    }
    
    mutating func insertEdge(_ pair: Pair, _ weight: Weight) {
        insertEdge(from: pair.a, to: pair.b, withWeight: weight)
    }

    mutating func updateEdge(_ pair: Pair, with transform: (Weight) -> Weight) {
        guard let weight = weight(pair) else { return }
        insertEdge(pair, transform(weight))
    }
    
    mutating func insertPath (_ path: Path) {
        path.nodes.forEach { insertNode($0) }
        path.weights.forEach { insertEdge($0) }
    }
    
    mutating func removeEdge (from source: Node, to destination: Node) {
        adjacents[Pair(source, destination)] = nil
    }
    
    /// - Returns: `true` if the graph contains this `node`, else `false`
    func contains (_ node: Node) -> Bool {
        return nodes.contains(node)
    }
    
    /// - Returns: `true` if `edge.nodes` are adjacent in the graph, else `false`
    func contains (_ edge: Pair) -> Bool {
        return adjacents.keys.contains(edge)
    }
    
    /// - Returns: Weight of the edge containing this `pair` of nodes if it exists, else nil
    func weight (_ pair: Pair) -> Weight? {
        return weight(from: pair.a, to: pair.b)
    }
    
    /// - Returns: Weight of the edge from `source` to `destination` if it exists, else nil
    func weight (from source: Node, to destination: Node) -> Weight? {
        return adjacents[Pair(source, destination)]
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
    
    // MARK: - Initializers
    
    init () {
        nodes = []
        adjacents = [:]
    }
    
    init (_ nodes: Set<Node>, _ adjacents: [Pair: Weight]) {
        self.nodes = nodes
        self.adjacents = adjacents
    }
}


extension _Graph where Weight == WithoutWeights {
    
    // MARK: - Instance Methods
    
    mutating func insertEdge (from source: Node, to destination: Node) {
        insertEdge(from: source, to: destination, withWeight: .unweighted)
    }
    
    mutating func insertPath (_ nodes: [_Graph.Node]) {
        insertPath(Path(nodes))
    }
}

extension _Graph where Weight: AsWeight {
    
    // MARK: - Instance Methods
    
    static func unWeightedVersion (of weightedGraph: _Graph) -> _Graph<WithoutWeights, Pair> {
        let adjacents: [Pair: WithoutWeights] = weightedGraph.adjacents.mapValues { _ in .unweighted }
        return _Graph<WithoutWeights, Pair>(weightedGraph.nodes, adjacents)
    }
    
    var unweighted: _Graph<WithoutWeights,Pair> {
        return .init(nodes, adjacents.mapValues { _ in .unweighted })
    }
}

extension _Graph.Edge where Weight == WithoutWeights {
    
    // MARK: - Initializers
    
    init (_ a: _Graph.Node, _ b: _Graph.Node) {
        self.nodes = Pair(a, b)
        self.weight = .unweighted
    }
}

extension _Graph where Pair: SwappablePair {
    
    // MARK: - Instance Methods
    
    mutating func flipEdge (containing nodes: Pair) {
        adjacents[nodes.swapped] = adjacents[nodes]
        adjacents[nodes] = nil
    }
}

extension _Graph.Path where Weight == WithoutWeights {
    
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
                weights[Pair(currentNode, nextNode)] = .unweighted
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
    
    typealias UnweightedPath = _Graph<WithoutWeights, DirectedOver<Node>>.Path
    
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
