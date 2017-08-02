//
//  VerticalPlotModel.swift
//  PlotModel
//
//  Created by James Bean on 6/25/17.
//
//

public protocol VerticalPlotModel: PlotModel {
    
    /// Type that converts a given type of musical element to `AbstractVerticalPosition`.
    associatedtype VerticalAxis: Axis
    
    /// Determines the way that information is mapped onto the vertical axis.
    var verticalAxis: VerticalAxis { get }
}
