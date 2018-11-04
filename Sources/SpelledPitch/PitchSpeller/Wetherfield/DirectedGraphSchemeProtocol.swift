//
//  DirectedGraphSchemeProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

public protocol DirectedGraphSchemeProtocol: GraphSchemeProtocol where Edge == OrderedPair<Node> { }
