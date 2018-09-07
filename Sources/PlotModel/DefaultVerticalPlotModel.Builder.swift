//
//  DefaultVerticalPlotModel.Builder.swift
//  PlotModel
//
//  Created by James Bean on 6/30/17.
//
//

import DataStructures

extension DefaultVerticalPlotModel {
    
    public var builder: Builder {
        return Builder()
    }
    
    public final class Builder {
        
        var points: [Position: [DefaultVerticalPointModel]]
        
        public init() {
            self.points = [:]
        }
        
        public func add(_ point: Point, at position: Position) {
            points[position, default: []].append(point)
        }
        
        public func build() -> DefaultVerticalPlotModel {
            return DefaultVerticalPlotModel(points)
        }
    }
}
