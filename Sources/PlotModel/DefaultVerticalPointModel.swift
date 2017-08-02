//
//  DefaultVerticalPointModel.swift
//  PlotModel
//
//  Created by James Bean on 6/30/17.
//
//

public struct DefaultVerticalPointModel: PointModel {

    public typealias VerticalAxis = DefaultAxis<Double>

    public typealias Entity = Double

    public var value: Double
    
    public init(_ value: Double) {
        self.value = value
    }
}
