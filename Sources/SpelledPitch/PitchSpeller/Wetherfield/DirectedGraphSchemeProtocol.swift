//
//  DirectedGraphSchemeProtocol.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 03/11/2018.
//

import DataStructures

protocol DirectedGraphSchemeProtocol: GraphSchemeProtocol where Edge == OrderedPair<Node> { }
