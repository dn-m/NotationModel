//
//  DefaultAxis.swift
//  PlotModel
//
//  Createsd by James Bean on 6/30/17.
//
//

/// Axis which does not transform its element when constructing its coordinate.
public struct DefaultAxis <T>: Axis {
    
    /// - Returns: Element as coordinate.
    public var coordinate: (T) -> T = { t in t }
    
    /// Creates a `DefaultAxis`.
    public init() { }
}
