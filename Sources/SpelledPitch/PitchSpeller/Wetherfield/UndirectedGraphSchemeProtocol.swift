//
//  UndirectedGraphSchemeProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

public protocol UndirectedGraphSchemeProtocol: GraphSchemeProtocol where Edge == UnorderedPair<Node> { }
