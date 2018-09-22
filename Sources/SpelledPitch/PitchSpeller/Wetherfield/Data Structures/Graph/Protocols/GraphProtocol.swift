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
    func neighbors(of source: Node, in nodes: Set<Node>?) -> Set<Node>
}

extension GraphProtocol {

    func contains(_ node: Node) -> Bool {
        return nodes.contains(node)
    }

    mutating func insert(_ node: Node) {
        nodes.insert(node)
    }
}
