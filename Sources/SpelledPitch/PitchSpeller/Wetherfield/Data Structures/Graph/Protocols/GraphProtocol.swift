//
//  GraphProtocol.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

protocol GraphProtocol {

    associatedtype Node: Hashable
    associatedtype Edge: SymmetricPair & Hashable where Edge.A == Node

    var nodes: Set<Node> { get set }

    init(_ nodes: Set<Node>)

    func neighbors(of source: Node, in nodes: Set<Node>?) -> Set<Node>
    func edges(containing node: Node) -> Set<Edge>
    
    mutating func removeEdge(from source: Node, to destination: Node)
}

extension GraphProtocol {

    func contains(_ node: Node) -> Bool {
        return nodes.contains(node)
    }

    func breadthFirstSearch(from source: Node, to destination: Node? = nil) -> [Node] {
        var visited: [Node] = []
        var queue: Queue<Node> = []
        queue.enqueue(source)
        visited.append(source)
        while !queue.isEmpty {
            let node = queue.dequeue()
            for neighbor in neighbors(of: node, in: nil) where !visited.contains(neighbor) {
                queue.enqueue(neighbor)
                visited.append(neighbor)
                if neighbor == destination { return visited }
            }
        }
        return visited
    }

    mutating func insert(_ node: Node) {
        nodes.insert(node)
    }
}
