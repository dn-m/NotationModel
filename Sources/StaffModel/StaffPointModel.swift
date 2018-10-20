//
//  StaffPointModel.swift
//  StaffModel
//
//  Created by James Bean on 1/15/17.
//
//

import PlotModel
import SpelledPitch

/// A single point on a `Staff`.
///
/// - TODO: Articulations
/// - TODO: Articulation positioning
///
public struct StaffPointModel: PointModel {
    
    public typealias HorizontalAxis = Clef
    public typealias VerticalAxis = Clef
    
    public typealias Entity = SpelledPitch
    public typealias VerticalCoordinate = StaffSlot
    public typealias HorizontalCoordinate = Double

    /// Highest `StaffRepresentablePitch`.
    public var highest: StaffRepresentablePitch? {
        return elements.max()
    }
    
    /// Lowest `StaffRepresentablePitch`.
    public var lowest: StaffRepresentablePitch? {
        return elements.min()
    }

    /// A `Set` of `StaffRepresentablePitch` values.
    public let elements: Set<StaffRepresentablePitch>

    // MARK: - Initializers
    
    /// Creates a `StaffPointModel` with any type of `Sequence` containing 
    /// `StaffRepresentablePitch` values.
    public init <S: Sequence> (_ sequence: S) where S.Element == StaffRepresentablePitch {
        self.elements = Set(sequence)
    }
    
    /// Symbolic connection point for stems.
    public func stemConnectionPoint(from direction: VerticalDirection, axis: Clef) -> StaffSlot? {
        guard let representable = direction == .above ? lowest : highest else { return nil }
        return axis.coordinate(representable.spelledPitch)
    }

    /// - returns: Ledger lines above and below
    public func ledgerLines(_ clef: Clef) -> (above: Int, below: Int) {
        return (ledgerLinesAbove(clef), ledgerLinesBelow(clef))
    }
    
    private func ledgerLinesAbove(_ clef: Clef) -> Int {
        guard let highest = highest?.spelledPitch else { return 0 }
        return ledgerLinesAmount(distance: clef.coordinate(highest) - 6)
    }
    
    private func ledgerLinesBelow(_ clef: Clef) -> Int {
        guard let lowest = lowest?.spelledPitch else { return 0 }
        return ledgerLinesAmount(distance: abs(clef.coordinate(lowest)) - 6)
    }

    private func ledgerLinesAmount(distance: Int) -> Int {
        return distance >= 0 ? distance / 2 + 1 : 0
    }
}
