//
//  StaffModel.swift
//  StaffModel
//
//  Created by James Bean on 1/15/17.
//
//

import SpelledPitch
import PlotModel

/// - TODO: Inject transposition as instance property. 
public struct StaffModel: VerticalPlotModel {
    
    /// - TODO: In Swift 4, there are associated type constraints. These typealiases should be
    /// inferrable by the relationship betwen `StaffModel` and `Clef`.
    public typealias Point = StaffPointModel
    public typealias VerticalCoordinate = StaffSlot
    public typealias HorizontalCoordinate = Double
    public typealias Entity = SpelledPitch
    
    public let verticalAxis: Clef
    public let horizontalAxis = DefaultAxis<Double>()
    public let points: [Double: [StaffPointModel]]
    
    /// Createss a `StaffModel` with the given `clef` and the given `points`.
    public init(clef: Clef = Clef(.treble), points: [Double: [StaffPointModel]]) {
        self.verticalAxis = clef
        self.points = points
    }
}
