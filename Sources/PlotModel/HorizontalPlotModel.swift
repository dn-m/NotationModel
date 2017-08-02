//
//  HorizontalPlotModel.swift
//  PlotModel
//
//  Created by James Bean on 6/25/17.
//
//

public protocol HorizontalPlotModel: PlotModel {
    
    /// Type that converts a given type of musical element to `AbstractHorizontalPosition`.
    associatedtype HorizontalAxis: Axis
    
    /// Determines the way that information is mapped onto the horizontal axis.
    var horizontalAxis: HorizontalAxis { get }
}
