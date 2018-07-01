//
//  EdgeLike.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

protocol EdgeLike: Weighted & NodePair {
    init(_ nodepair: Pair, _ weight: Weight)
}
