//
//  Pitch.Spelling.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Pitch

extension Pitch {

    /// Spelled representation of a `Pitch`.
    public struct Spelling {

        // MARK: - Errors

        /// Errors possible when attempting to spell a `Pitch`.
        //
        // FIXME: Move to `PitchSpeller`
        public enum Error: Swift.Error {

            /// If the given `Pitch.Spelling` is not applicable to the given `Pitch`.
            case invalidSpelling(Pitch, Pitch.Spelling)

            /// If there is no `Pitch.Spelling` found for the given `Pitch`.
            case noSpellingForPitch(Pitch)
        }

        // MARK: - Instance Properties

        /// LetterName of a `Pitch.Spelling`.
        public let letterName: LetterName

        /// Fine resolution of a `Pitch.Spelling`.
        public let eighthStep: EighthStepModifier

        /// Coarse resolution of a `Pitch.Spelling`.
        public let quarterStep: QuarterStepModifier

        /// `PitchClass` represented by this `Pitch.Spelling` value.
        ///
        /// - TODO: Refactor to `PitchClass`.
        public var pitchClass: Pitch.Class {
            let nn = NoteNumber(letterName.pitchClass + quarterStep.rawValue + eighthStep.rawValue)
            return Pitch.Class(noteNumber: nn)
        }

        // MARK: - Initializers

        /**
         Create a `Pitch.Spelling` (with argument labels).

         **Example:**

         ```
         let cNatural = Pitch.Spelling(letterName: .c)
         let aFlat = Pitch.Spelling(letterName: .a, quarterStep: .flat)
         let gQuarterSharp = Pitch.Spelling(letterName: .g, quarterStep: .quarterSharp)
         let dQuarterFlatDown = Pitch.Spelling(letterName: .d, quarterStep: .quarterFlat, eighthStep: .down)
         let bDoubleSharp = Pitch.Spelling(letterName: .b, quarterStep: .doubleSharp)
         ```
         */
        public init(
            letterName: LetterName,
            quarterStep: QuarterStepModifier = .natural,
            eighthStep: EighthStepModifier = .none
        )
        {
            self.letterName = letterName
            self.quarterStep = quarterStep
            self.eighthStep = eighthStep
        }

        /**
         Create a `Pitch.Spelling` (without argument labels).

         **Example:**

         ```
         let cNatural = Pitch.Spelling(.c)
         let aFlat = Pitch.Spelling(.a, .flat)
         let gQuarterSharp = Pitch.Spelling(.g, .quarterSharp)
         let dQuarterFlatDown = Pitch.Spelling(.d, .quarterFlat, .down)
         let bDoubleSharp = Pitch.Spelling(.b, .doubleSharp)
         ```
         */
        public init(
            _ letterName: LetterName,
            _ quarterStep: QuarterStepModifier = .natural,
            _ eighthStep: EighthStepModifier = .none
        )
        {
            self.letterName = letterName
            self.quarterStep = quarterStep
            self.eighthStep = eighthStep
        }

        // MARK: - Instance Methods

        /// - Returns: `true` if this `Pitch.Spelling` can be applied to the given `Pitch`.
        /// Otherwise, `false`.
        public func isValid(for pitch: Pitch) -> Bool {
            return pitch.spellings.contains(self)
        }
    }
}

// FIXME: Move to own file
extension Pitch.Spelling {

    // MARK: - LetterName

    /**
     Letter name component of a `Pitch.Spelling`
     */
    public enum LetterName: String {

        // MARK: - Cases

        /// A, la.
        case a

        /// B, si.
        case b

        /// C, do.
        case c

        /// D, re.
        case d

        /// E, mi.
        case e

        /// F, fa.
        case f

        /// G, sol.
        case g

        // MARK: - Initializers

        /**
         Create a `LetterName` with a given `string` value. Uppercase and lowercase values are
         accepted here.
         */
        public init?(string: String) {
            switch string {
            case "a", "A": self = .a
            case "b", "B": self = .b
            case "c", "C": self = .c
            case "d", "D": self = .d
            case "e", "E": self = .e
            case "f", "F": self = .f
            case "g", "G": self = .g
            default: return nil
            }
        }

        /// Amount of steps from c
        public var steps: Int {
            switch self {
            case .c: return 0
            case .d: return 1
            case .e: return 2
            case .f: return 3
            case .g: return 4
            case .a: return 5
            case .b: return 6
            }
        }

        /// Default pitch class for a given `LetterName`.
        public var pitchClass: Double {
            switch self {
            case .c: return 0
            case .d: return 2
            case .e: return 4
            case .f: return 5
            case .g: return 7
            case .a: return 9
            case .b: return 11
            }
        }
    }
}



// FIXME: Move to own file
extension Pitch.Spelling {

    // MARK: - Coarse Adjustment

    /**
     Coarse resolution component of a `Pitch.Spelling`.
     Analogous to the body of an accidental.
     */
    public enum QuarterStepModifier: Double, Comparable {

        public enum Direction: Double, Comparable {
            case none = 0
            case up = 1
            case down = -1
        }

        public enum Resolution: Double, Comparable {
            case halfStep = 0
            case quarterStep = 0.5
        }

        public var direction: Direction {
            return self == .natural ? .none : rawValue > 0 ? .up : .down
        }

        public var distance: Double {
            return abs(rawValue)
        }

        public var resolution: Resolution {
            return rawValue.truncatingRemainder(dividingBy: 1) == 0 ? .halfStep : .quarterStep
        }

        public var quantizedToHalfStep: QuarterStepModifier {
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

    // FIXME: Move to PitchSpeller
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

// FIXME: Move to own file.
extension Pitch.Spelling {

    // MARK: - Fine Adjustment

    /**
     Fine resolution component of a `Pitch.Spelling`.
     Analogous to an up or down (or lack of) arrow of an accidental.

     - note: In 48-EDO, represents 1/8th-tone adjustment.
     May be useful for other cases (e.g., -14c adjustment for 5th partial, etc.).
     */
    public enum EighthStepModifier: Double {

        /// None.
        case none = 0

        /// Up.
        case up = 0.25

        /// Down.
        case down = -0.25
    }
}

// FIXME: Move to own file.
extension Pitch.Spelling {

    /**
     Resolution of a `Pitch.Spelling`.
     */
    public enum Resolution: Float {

        // chromatic
        case halfStep = 0

        // quartertone
        case quarterStep = 0.5

        // eighth-tone
        case eighthStep = 0.25
    }

    /// `Resolution` (e.g., halfstep (chromatic), quarter-step, or eighth-step)
    public var resolution: Resolution {
        return eighthStep != .none
            ? .eighthStep
            : quarterStep.resolution == .quarterStep ? .quarterStep
            : .halfStep
    }

    /**
     - returns: A `Pitch.Spelling` object that is quantized to the given `resolution`.
     */
    public func quantized(to resolution: Resolution) -> Pitch.Spelling {
        switch resolution {
        case .quarterStep:
            return Pitch.Spelling(letterName, quarterStep, .none)
        case .halfStep where quarterStep.resolution == .quarterStep:
            return Pitch.Spelling(letterName, quarterStep.quantizedToHalfStep, .none)
        default:
            return self
        }
    }
}

extension Pitch.Spelling: Equatable, Hashable { }

extension Pitch.Spelling: Comparable {

    public static func < (lhs: Pitch.Spelling, rhs: Pitch.Spelling) -> Bool {
        if lhs.letterName.steps < rhs.letterName.steps { return true }
        if lhs.letterName.steps == rhs.letterName.steps {
            if lhs.quarterStep.rawValue < rhs.quarterStep.rawValue { return true }
            if lhs.quarterStep.rawValue == rhs.quarterStep.rawValue {
                if lhs.eighthStep.rawValue < rhs.eighthStep.rawValue { return true }
            }
        }
        return false
    }
}

extension Pitch.Spelling: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printed description.
    public var description: String {
        var result = ""
        result += "\(letterName)"
        if quarterStep != .natural { result += " \(quarterStep)" }
        if eighthStep != .none { result += " \(eighthStep)" }
        return result
    }
}
