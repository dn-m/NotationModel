//
//  _Graph.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/14/18.
//

protocol Directedness { }
protocol Directed: Directedness { }
protocol Undirected: Directedness { }

enum WithDirectedEdges: Directed { }
enum WithUndirectedEdges: Undirected { }

struct _Graph<DirectednessFlag: Directedness> {
    
}
