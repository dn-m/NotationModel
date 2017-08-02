//
//  PitchSpelling+QuarterStepModifier.swift
//  SpelledPitch
//
//  Created by James Bean on 5/3/16.
//
//

// temp: use collections api
extension RawRepresentable where RawValue: Comparable {
    
    // MARK: - `Comparable`
    
    /// - returns: `true` if the `rawValue` of the left value is less than the `rawValue`
    /// of the right value. Otherwise, `nil`.
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

extension PitchSpelling {
    
    // MARK: - Coarse Adjustment
    
    /**
     Coarse resolution component of a `PitchSpelling`.
     Analogous to the body of an accidental.
     */
    public enum QuarterStepModifier: Double, Comparable {
        
        internal enum Direction: Double, Comparable {
            case none = 0
            case up = 1
            case down = -1
        }
        
        internal enum Resolution: Double, Comparable {
            case halfStep = 0
            case quarterStep = 0.5
        }
        
        internal var direction: Direction {
            return self == .natural ? .none : rawValue > 0 ? .up : .down
        }
        
        internal var distance: Double {
            return abs(rawValue)
        }
        
        internal var resolution: Resolution {
            return rawValue.truncatingRemainder(dividingBy: 1) == 0 ? .halfStep : .quarterStep
        }
        
        internal var quantizedToHalfStep: QuarterStepModifier {
            switch direction {
            case .none: return .natural
            case .up: return .sharp
            case .down: return .flat
            }
        }
        
        /// Natural.
        case natural = 0
        
        /// QuarterSharp.
        case quarterSharp = 0.5
        
        /// Sharp.
        case sharp = 1
        
        /// ThreeQuarterSharp.
        case threeQuarterSharp = 1.5
        
        /// DoubleSharp.
        case doubleSharp = 2.0
        
        /// QuarterFlat.
        case quarterFlat = -0.5
        
        /// Flat.
        case flat = -1
        
        /// ThreeQuarterFlat.
        case threeQuarterFlat = -1.5
        
        /// DoubleFlat.
        case doubleFlat = -2.0
    }
    
    internal func isCompatible(withCoarseDirection direction: QuarterStepModifier.Direction)
        -> Bool
    {
        switch direction {
        case .none: return true
        case .up:
            return isFineAdjustedNatural ? false : (direction == .none || direction == .up)
        case .down:
            return isFineAdjustedNatural ? false : (direction == .none || direction == .down)
        }
    }

    internal var isFineAdjustedNatural: Bool {
        return quarterStep == .natural && eighthStep != .none
    }
}
