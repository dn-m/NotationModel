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

enum WithDirectedEdges: Directed { }
enum WithUndirectedEdges: Undirected { }

struct _Graph<DirectednessFlag: Directedness> {
    
}

extension _Graph where DirectednessFlag: Directed {
    
}
