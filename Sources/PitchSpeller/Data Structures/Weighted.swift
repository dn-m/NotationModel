//
//  Weighted.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

protocol Weighted {
    associatedtype Weight
    var weight: Weight { get set }
}
