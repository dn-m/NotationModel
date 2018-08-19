//
//  PointModel.swift
//  PlotModel
//
//  Created by James Bean on 6/25/17.
//
//

public enum VerticalDirection {
    case above, below
}

public protocol PointModel {
    
    /// The thing the needs to be converted into vertical dimension
    associatedtype Entity
}
