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

struct _Graph<Weight: Weightedness, Pair: SymmetricPair & Directedness> {
    
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
    }
    
    // MARK: - Instance Properties
     
    var nodes: [Node]
    var edges: [Edge]
    
    // MARK: - Instance Methods
    
    mutating func insertNode (_ node: Node) {
        nodes.append(node)
    }
    
    mutating func insertEdge(from source: Node, to destination: Node, withWeight weight: Weight) {
        edges.append(Edge(source, destination, withWeight: weight))
    }
    
    // MARK: - Initializers
    
    init() {
        nodes = []
        edges = []
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

extension _Graph where Weight: Numeric, Pair: Directed {
    
}
