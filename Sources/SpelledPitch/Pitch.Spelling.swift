//
//  Pitch.Spelling.swift
//  Pitch
//
//  Createsd by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Pitch

extension Pitch {

    /// Spelled representation of a `Pitch`.
    public struct Spelling <Tuning: TuningSystem> {

        // MARK: - Instance Properties

        /// `Pitch.Class` represented by this `Pitch.Spelling` value.
        public var pitchClass: Pitch.Class {
            let noteNumber = NoteNumber(letterName.pitchClass + modifier.adjustment)
            return Pitch.Class(noteNumber: noteNumber)
        }

        /// `LetterName` of a `Pitch.Spelling`.
        public let letterName: LetterName

        /// `Modifier` of a `Pitch.Spelling`.
        public let modifier: Tuning.Modifier
    }
}

/// Letter name component of a `Pitch.Spelling`
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
}

extension LetterName {

    // MARK: - Instance Properties

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

extension LetterName {

    // MARK: - Initializers

    /// Creates a `LetterName` with a given `string` value. Uppercase and lowercase values are
    /// accepted here.
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
}

extension Pitch.Spelling where Tuning == EDO12 {

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let cNatural = Pitch.Spelling(.c)
    ///     let aFlat = Pitch.Spelling(.a, .flat)
    ///
    public init(_ letterName: LetterName) {
        self.init(letterName: letterName, modifier: .natural)
    }

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let cNatural = Pitch.Spelling(.c)
    ///     let aFlat = Pitch.Spelling(.a, .flat)
    ///
    public init(_ letterName: LetterName, _ modifier: EDO12.Modifier = .natural) {
        self.init(letterName: letterName, modifier: modifier)
    }
}

extension Pitch.Spelling where Tuning == EDO24 {

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let gQuarterSharp = Pitch.Spelling(.g, .quarterSharp)
    ///     let bDoubleSharp = Pitch.Spelling(.b, .doubleSharp)
    ///
    public init(_ letterName: LetterName) {
        let edo24 = EDO24.Modifier(edo12: .natural, modifier: .none)
        self.init(letterName: letterName, modifier: edo24)
    }

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let gQuarterSharp = Pitch.Spelling(.g, .quarterSharp)
    ///     let bDoubleSharp = Pitch.Spelling(.b, .doubleSharp)
    ///
    public init(_ letterName: LetterName, _ halfStep: EDO12.Modifier) {
        let edo24 = EDO24.Modifier(edo12: halfStep, modifier: .none)
        self.init(letterName: letterName, modifier: edo24)
    }

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let gQuarterSharp = Pitch.Spelling(.g, .quarterSharp)
    ///     let bDoubleSharp = Pitch.Spelling(.b, .doubleSharp)
    ///
    public init(
        _ letterName: LetterName,
        _ quarterStep: EDO24.Modifier.Modifier,
        _ halfStep: EDO12.Modifier
    )
    {
        let edo24 = EDO24.Modifier(edo12: halfStep, modifier: quarterStep)
        self.init(letterName: letterName, modifier: edo24)
    }
}

extension Pitch.Spelling where Tuning == EDO48 {

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let dQuarterFlatDown = Pitch.Spelling(.d, .flat(1))
    ///
    public init(_ letterName: LetterName) {
        let edo24 = EDO24.Modifier(edo12: .natural, modifier: .none)
        let edo48 = EDO48.Modifier(edo24: edo24, modifier: .none)
        self.init(letterName: letterName, modifier: edo48)
    }

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let dQuarterFlatDown = Pitch.Spelling(.d, .flat(1))
    ///
    public init(_ letterName: LetterName, _ halfStep: EDO12.Modifier = .natural) {
        let edo24 = EDO24.Modifier(edo12: halfStep, modifier: .none)
        let edo48 = EDO48.Modifier(edo24: edo24, modifier: .none)
        self.init(letterName: letterName, modifier: edo48)
    }

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let dQuarterFlatDown = Pitch.Spelling(.d, .quarterFlat, .down)
    ///
    public init(
        _ letterName: LetterName,
        _ quarterStep: EDO24.Modifier.Modifier = .none,
        _ halfStep: EDO12.Modifier = .natural
    )
    {
        let edo24 = EDO24.Modifier(edo12: halfStep, modifier: quarterStep)
        let edo48 = EDO48.Modifier(edo24: edo24, modifier: .none)
        self.init(letterName: letterName, modifier: edo48)
    }

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let dQuarterFlatDown = Pitch.Spelling(.d, .quarterFlat, .down)
    ///
    public init(
        _ letterName: LetterName,
        _ halfStep: EDO12.Modifier = .natural,
        _ eighthStep: EDO48.Modifier.Modifier
    )
    {
        let edo24 = EDO24.Modifier(edo12: halfStep, modifier: .none)
        let edo48 = EDO48.Modifier(edo24: edo24, modifier: eighthStep)
        self.init(letterName: letterName, modifier: edo48)
    }

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let dQuarterFlatDown = Pitch.Spelling(.d, .quarterFlat, .down)
    ///
    public init(
        _ letterName: LetterName,
        _ quarterStep: EDO24.Modifier.Modifier = .none,
        _ halfStep: EDO12.Modifier = .natural,
        _ eighthStep: EDO48.Modifier.Modifier
    )
    {
        let edo24 = EDO24.Modifier(edo12: halfStep, modifier: quarterStep)
        let edo48 = EDO48.Modifier(edo24: edo24, modifier: eighthStep)
        self.init(letterName: letterName, modifier: edo48)
    }
}

extension Pitch.Spelling where Tuning == EDO48 {

    /// Creates a `Pitch.Spelling` in the `EDO48` `TuningSystem` from a `Pitch.Spelling` in the
    /// `EDO24` domain.
    public init(_ edo24: Pitch.Spelling<EDO24>) {
        let modifier = EDO48.Modifier(edo24: edo24.modifier, modifier: .none)
        self.init(letterName: edo24.letterName, modifier: modifier)
    }

    /// Creates a `Pitch.Spelling` in the `EDO48` `TuningSystem` from a `Pitch.Spelling` in the
    /// `EDO12` domain.
    public init(_ edo12: Pitch.Spelling<EDO12>) {
        let edo24 = EDO24.Modifier(edo12: edo12.modifier, modifier: .none)
        let modifier = EDO48.Modifier(edo24: edo24, modifier: .none)
        self.init(letterName: edo12.letterName, modifier: modifier)
    }
}

extension Pitch.Spelling where Tuning == EDO24 {

    /// Creates a `Pitch.Spelling` in the `EDO24` `TuningSystem` from a `Pitch.Spelling` in the
    /// `EDO12` domain.
    public init(_ edo12: Pitch.Spelling<EDO12>) {
        let edo24 = EDO24.Modifier(edo12: edo12.modifier, modifier: .none)
        self.init(letterName: edo12.letterName, modifier: edo24)
    }
}

//extension Pitch.Spelling {
//
//    // MARK: - Instance Methods
//
//    /// - Returns: `true` if this `Pitch.Spelling` can be applied to the given `Pitch`.
//    /// Otherwise, `false`.
//    public func isValid(for pitch: Pitch) -> Bool {
//        return pitch.spellings.contains(self)
//    }
//}

extension Pitch.Spelling: Comparable where Tuning.Modifier: Comparable {

    // MARK: - Comparable

    /// - Returns: `true` if the left hand `Pitch.Spelling` value is less than the right hand
    /// `Pitch.Spelling` value.
    public static func < (lhs: Pitch.Spelling<Tuning>, rhs: Pitch.Spelling<Tuning>) -> Bool {
        if lhs.letterName.steps == rhs.letterName.steps { return lhs.modifier < rhs.modifier }
        return lhs.letterName.steps < rhs.letterName.steps
    }
}

extension Pitch.Spelling: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printed description.
    public var description: String {
        return "\(letterName) \(modifier)"
    }
}

extension Pitch.Spelling: Equatable where Tuning.Modifier: Equatable { }
extension Pitch.Spelling: Hashable where Tuning.Modifier: Hashable { }

