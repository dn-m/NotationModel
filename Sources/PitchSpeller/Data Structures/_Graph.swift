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

struct _Graph<Weight: Weightedness, Pair: SymmetricPair & Directedness & Hashable> where Pair.A: Hashable {
    
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
    
    // MARK: - Instance Properties
     
    var nodes: Set<Node>
    var adjacents: [Pair: Weight]
    
    var edges: [Edge] {
        return adjacents.compactMap { Edge($0.key, withWeight: $0.value) }
    }
    
    // MARK: - Instance Methods
    
    mutating func insertNode (_ node: Node) {
        nodes.insert(node)
    }
    
    mutating func insertEdge (from source: Node, to destination: Node, withWeight weight: Weight) {
        adjacents[Pair(source, destination)] = weight
    }
    
    mutating func removeEdge (from source: Node, to destination: Node) {
        adjacents[Pair(source, destination)] = nil
    }
    
    func weight (from source: Node, to destination: Node) -> Weight? {
        return adjacents[Pair(source, destination)]
    }
    
    func neighbors (of source: Node) -> [Node] {
        return nodes.compactMap {
            guard let _ = adjacents[Pair(source, $0)] else { return nil }
            return $0
        }
    }
    
    func neighbors (of source: Node, from nodes: Set<Node>) -> [Node] {
        return nodes.compactMap {
            guard let _ = adjacents[Pair(source, $0)] else { return nil }
            return $0
        }
    }
    
    func neighbors (of source: Node, from nodes: [Node]) -> [Node] {
        return neighbors(of: source, from: Set(nodes))
    }
    
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
}


extension _Graph where Weight == WithoutWeights {
    
    // MARK: - Instance Methods
    
    mutating func insertEdge (from source: Node, to destination: Node) {
        insertEdge(from: source, to: destination, withWeight: .unweighted)
    }
}

extension _Graph.Edge where Weight == WithoutWeights {
    
    // MARK: - Initializers
    
    init (_ a: _Graph.Node, _ b: _Graph.Node) {
        self.nodes = Pair(a, b)
        self.weight = .unweighted
    }
}

extension _Graph.Edge where Pair: Directed {
    
    // MARK: - Instance Properties
    
    var source: _Graph.Node { return nodes.a }
    var destination: _Graph.Node { return nodes.b }
}

extension _Graph {
    
    // MARK: - Instance Methods
    
    func shortestUnweightedPath (from source: Node, to destination: Node) {
        
        var breadcrumbs: [Node: Node] = [:]
        
        func backtrace () -> [Node] {
            #warning("TODO: Implement")
            return []
        }
        
        var unvisited = nodes
        var queue: Queue<Node> = []
        
        queue.push(source)
        while !queue.isEmpty {
            let node = queue.pop()
            if node == destination {
                return backtrace()
            }
            for neighbor in neighbors(of: node, from: unvisited) {
                queue.push(neighbor)
                unvisited.remove(neighbor)
                breadcrumbs[neighbor] = node
            }
        }

    }
}
