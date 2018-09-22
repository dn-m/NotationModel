//
//  UndirectedGraphProtocol.swift
//  SpelledPitch
//
//  Created by James Bean on 9/22/18.
//

/// Interface for directed graphs.
protocol UndirectedGraphProtocol: GraphProtocol where Edge == UnorderedPair<Node> { }
