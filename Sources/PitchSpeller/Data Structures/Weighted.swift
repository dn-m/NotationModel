//
//  Weighted.swift
//  PitchSpeller
//
//  Created by Benjamin Wetherfield on 7/1/18.
//

protocol Weighted {
    
    // MARK: - Associated Types
    
    associatedtype Weight
    
    // MARK: - Instance Properties
    
    var weight: Weight { get set }
}
