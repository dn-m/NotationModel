//
//  DefaultVerticalPlotModel.Builder.swift
//  PlotModel
//
//  Created by James Bean on 6/30/17.
//
//

import DictionaryProtocol

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
            points.safelyAppend(point, toArrayWith: position)
        }
        
        public func build() -> DefaultVerticalPlotModel {
            return DefaultVerticalPlotModel(points)
        }
    }
}
