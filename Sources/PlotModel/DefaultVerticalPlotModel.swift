//
//  DefaultVerticalPlotModel.swift
//  PlotModel
//
//  Created by James Bean on 6/30/17.
//
//

public struct DefaultVerticalPlotModel: VerticalPlotModel {
    
    public typealias Entity = Double
    
    public let verticalAxis = DefaultAxis<Double>()
    public let points: [Double: [DefaultVerticalPointModel]]
    
    public init(_ points: [Double: [DefaultVerticalPointModel]]) {
        self.points = points
    }
}
