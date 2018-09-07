//
//  StaffModel.Builder.swift
//  StaffModel
//
//  Created by James Bean on 6/25/17.
//
//

import DataStructures

extension StaffModel {
    
    public static var builder: Builder {
        return Builder()
    }
    
    public final class Builder {
        
        var clef: Clef = Clef(.treble)
        var points: [Double: [StaffPointModel]] = [:]
        
        public init() { }
        
        public func set(_ clef: Clef) {
            self.clef = clef
        }
        
        public func add(_ point: Point, at position: Double) {
            points[position, default: []].append(point)
        }
        
        public func build() -> StaffModel {
            return StaffModel(clef: clef, points: points)
        }
    }
}
