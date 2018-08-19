//
//  PlotModel.swift
//  PlotModel
//
//  Createsd by James Bean on 1/14/17.
//
//

import DataStructures

/// Model represented by a `PlotView`.
public protocol PlotModel: CollectionWrapping {

    /// Model of a single point within a `PlotModel`.
    associatedtype Point: PointModel
    
    /// The thing the needs to be converted into vertical dimension.
    associatedtype Entity
    
    /// Type that describes the coordinates of a given `Point`.
    associatedtype Position: Hashable
    
    /// Array of points contained herein.
    var points: [Position: [Point]] { get }
}

extension PlotModel {

    // MARK: - CollectionWrapping

    public var base: [Position: [Point]] {
        return points
    }
}
