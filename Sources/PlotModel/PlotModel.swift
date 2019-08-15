//
//  PlotModel.swift
//  PlotModel
//
//  Created by James Bean on 1/14/17.
//
//

import DataStructures

/// Model represented by a `PlotView`.
public protocol PlotModel: Collection {

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

    // MARK: - Collection

    public typealias Base = [Position: [Point]]

    public var base: [Position: [Point]] {
        return points
    }

    /// Start index.
    public var startIndex: Base.Index {
        return base.startIndex
    }

    /// End index.
    public var endIndex: Base.Index {
        return base.endIndex
    }

    /// Index after given index `i`.
    public func index(after i: Base.Index) -> Base.Index {
        return base.index(after: i)
    }

    /// - returns: Element at the given `index`.
    public subscript (index: Base.Index) -> Base.Element {
        return base[index]
    }
}

