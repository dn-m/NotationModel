//
//  UnweightedGraphSchemeProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

public protocol UnweightedGraphSchemeProtocol: GraphSchemeProtocol {
    var contains: (Edge) -> Bool { get }
    
    init (_ contains: @escaping (Edge) -> Bool)
}

extension UnweightedGraphSchemeProtocol {
    @inlinable
    func pullback <H> (_ f: @escaping (H.Node) -> Node) -> H where H: UnweightedGraphSchemeProtocol {
        return H.init { self.contains(Edge(f($0.a),f($0.b))) }
    }
}
