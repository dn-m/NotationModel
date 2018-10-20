//
//  Pitch.Spelling.swift
//  Pitch
//
//  Created by James Bean on 3/17/16.
//  Copyright © 2016 James Bean. All rights reserved.
//

import Pitch

struct Spelling {

    /// The modification of a `Pitch.Spelling` from the given `LetterName`.
    struct Modifier {

        static let doubleFlat = Modifier(.doubleFlat)
        static let threeQuarterFlat = Modifier(.flat, [.undecimal(-1)])
        static let flat = Modifier(.flat)
        static let quarterFlat = Modifier(.natural, [.undecimal(-1)])
        static let natural = Modifier(.natural)
        static let quarterSharp = Modifier(.natural, [.undecimal(1)])
        static let sharp = Modifier(.sharp)
        static let threeQuarterSharp = Modifier(.sharp, [.undecimal(1)])
        static let doubleSharp = Modifier(.doubleSharp)

        // MARK: - Nested Types

        /// Base modifier (natural, sharps, flats).
        struct Pythagorean {

            // MARK: - Type Properties

            static let doubleFlat = Pythagorean(-2)
            static let flat = Pythagorean(-1)
            static let natural = Pythagorean(0)
            static let sharp = Pythagorean(1)
            static let doubleSharp = Pythagorean(2)

            // MARK: - Computed Properties

            /// Adjustment to letter name in semitones.
            var adjustment: Double {
                return Double(amount)
            }

            // MARK: - Instance Properties

            /// The amount of semitones above or below a given letter name.
            let amount: Int

            // MARK: - Initializers

            /// Creates a `Pythagorean` base modifier with the given `amount`.
            init(_ amount: Int) {
                self.amount = amount
            }
        }

        /// Alteration to the base pythagorean modifier.
        ///
        /// - TODO: Prime intervals in limits 16-64.
        enum Alteration {

            /// Alteration by one syntonic comma (81/80). +/- 21.5 cents.
            case ptolemaic(Int)

            /// Alteration by one septimal comma (64/63). +/- 27.3 cents.
            case septimal(Int)

            /// Alteration by one undecimal quarter tone (33/32). +/- 53.3 cents.
            case undecimal(Int)

            /// Alteration by one tridecimal third tone (27/26). +/- 65.3 cents.
            case tridecimal(Int)

            /// Alteration by the given amount of cents.
            case cents(Double)

            /// - Returns: The amount of adjustment in semitones.
            var adjustment: Double {
                switch self {
                case .ptolemaic(let amount): return 0.215 * Double(amount)
                case .septimal(let amount): return 0.273 * Double(amount)
                case .undecimal(let amount): return 0.535 * Double(amount)
                case .tridecimal(let amount): return 0.653 * Double(amount)
                case .cents(let amount): return amount / 100
                }
            }
        }

        // MARK: - Computed Properties

        /// The adjustment to letter name in semitones.
        var adjustment: Double {
            return base.adjustment + alterations.map { $0.adjustment }.sum
        }

        // MARK: Instance Properties

        /// The natural, sharp, or flat base modifier.
        let base: Pythagorean

        /// The additional alterations made to the base modifier.
        let alterations: [Alteration]

        // MARK: - Initializers

        /// Creates a `Modifier` with the given `Pythagorean` base modifier and the given
        /// `Alteration` values.
        init(_ base: Pythagorean = .natural, _ alterations: [Alteration] = []) {
            self.base = base
            self.alterations = alterations
        }
    }

    // MARK: - Computed Properties

    /// `Pitch.Class` represented by this `Pitch.Spelling` value.
    public var pitchClass: Pitch.Class {
        return Pitch.Class(letterName.pitchClass + modifier.adjustment)
    }

    // MARK: - Instance Properties

    /// `LetterName` of a `Pitch.Spelling`.
    let letterName: LetterName

    /// `Modifier` of a `Pitch.Spelling`.
    let modifier: Modifier

    // MARK: - Initializers

    /// Creates a Pitch.Spelling with the given `letterName` and the given `modifier`.
    init(_ letterName: LetterName, modifier: Modifier) {
        self.letterName = letterName
        self.modifier = modifier
    }
}

extension Pitch {

    /// Spelled representation of a `Pitch`.
    public struct Spelling <Tuning: TuningSystem> {

        // MARK: - Instance Properties

        /// `Pitch.Class` represented by this `Pitch.Spelling` value.
        public var pitchClass: Pitch.Class {
            let noteNumber = NoteNumber(letterName.pitchClass + modifier.adjustment)
            return Pitch.Class(noteNumber)
        }

        /// `LetterName` of a `Pitch.Spelling`.
        public let letterName: LetterName

        /// `Modifier` of a `Pitch.Spelling`.
        public let modifier: Tuning.Modifier
    }
}

extension Pitch.Spelling where Tuning: EDO {

    // MARK: - Static Properties

    /// The `c natural` closest to the middle of a piano keyboard.
    public static var middleC: Pitch.Spelling<Tuning> {
        return .init(letterName: .c, modifier: Tuning.Modifier.identity)
    }
}

extension Pitch.Spelling where Tuning == EDO12 {

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let cNatural = Pitch.Spelling(.c)
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
    public init(_ letterName: LetterName, _ modifier: EDO12.Modifier) {
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
        let edo24 = EDO24.Modifier(edo12: .natural, quarterTone: .none)
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
        let edo24 = EDO24.Modifier(edo12: halfStep, quarterTone: .none)
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
        _ quarterStep: EDO24.Modifier.QuarterTone,
        _ halfStep: EDO12.Modifier
    )
    {
        let edo24 = EDO24.Modifier(edo12: halfStep, quarterTone: quarterStep)
        self.init(letterName: letterName, modifier: edo24)
    }
}

extension Pitch.Spelling where Tuning == EDO48 {

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let dQuarterFlatDown = Pitch.Spelling(.d, .flat))
    ///
    public init(_ letterName: LetterName) {
        let edo24 = EDO24.Modifier(edo12: .natural, quarterTone: .none)
        let edo48 = EDO48.Modifier(edo24: edo24, eighthTone: .none)
        self.init(letterName: letterName, modifier: edo48)
    }

    /// Creates a `Pitch.Spelling`.
    ///
    /// **Example Usage**
    ///
    ///     let dQuarterFlatDown = Pitch.Spelling(.d, .flat))
    ///
    public init(_ letterName: LetterName, _ halfStep: EDO12.Modifier = .natural) {
        let edo24 = EDO24.Modifier(edo12: halfStep, quarterTone: .none)
        let edo48 = EDO48.Modifier(edo24: edo24, eighthTone: .none)
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
        _ quarterStep: EDO24.Modifier.QuarterTone = .none,
        _ halfStep: EDO12.Modifier = .natural
    )
    {
        let edo24 = EDO24.Modifier(edo12: halfStep, quarterTone: quarterStep)
        let edo48 = EDO48.Modifier(edo24: edo24, eighthTone: .none)
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
        _ eighthStep: EDO48.Modifier.EighthTone
    )
    {
        let edo24 = EDO24.Modifier(edo12: halfStep, quarterTone: .none)
        let edo48 = EDO48.Modifier(edo24: edo24, eighthTone: eighthStep)
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
        _ quarterStep: EDO24.Modifier.QuarterTone = .none,
        _ halfStep: EDO12.Modifier = .natural,
        _ eighthStep: EDO48.Modifier.EighthTone
    )
    {
        let edo24 = EDO24.Modifier(edo12: halfStep, quarterTone: quarterStep)
        let edo48 = EDO48.Modifier(edo24: edo24, eighthTone: eighthStep)
        self.init(letterName: letterName, modifier: edo48)
    }
}

extension Pitch.Spelling where Tuning == EDO48 {

    /// Creates a `Pitch.Spelling` in the `EDO48` `TuningSystem` from a `Pitch.Spelling` in the
    /// `EDO24` domain.
    public init(_ edo24: Pitch.Spelling<EDO24>) {
        let modifier = EDO48.Modifier(edo24: edo24.modifier, eighthTone: .none)
        self.init(letterName: edo24.letterName, modifier: modifier)
    }

    /// Creates a `Pitch.Spelling` in the `EDO48` `TuningSystem` from a `Pitch.Spelling` in the
    /// `EDO12` domain.
    public init(_ edo12: Pitch.Spelling<EDO12>) {
        let edo24 = EDO24.Modifier(edo12: edo12.modifier, quarterTone: .none)
        let modifier = EDO48.Modifier(edo24: edo24, eighthTone: .none)
        self.init(letterName: edo12.letterName, modifier: modifier)
    }
}

extension Pitch.Spelling where Tuning == EDO24 {

    /// Creates a `Pitch.Spelling` in the `EDO24` `TuningSystem` from a `Pitch.Spelling` in the
    /// `EDO12` domain.
    public init(_ edo12: Pitch.Spelling<EDO12>) {
        let edo24 = EDO24.Modifier(edo12: edo12.modifier, quarterTone: .none)
        self.init(letterName: edo12.letterName, modifier: edo24)
    }

    /// Creates a `Pitch.Spelling` in the `EDO24` `TuningSystem` from a `Pitch.Spelling` in the
    /// `EDO24` domain.
    public init(_ edo48: Pitch.Spelling<EDO48>) {
        let edo24 = EDO24.Modifier(edo12: edo48.modifier.edo24.edo12, quarterTone: .none)
        self.init(letterName: edo48.letterName, modifier: edo24)
    }
}

extension Pitch.Spelling where Tuning == EDO12 {

    /// Creates a `Pitch.Spelling` in the `EDO12` `TuningSystem` from a `Pitch.Spelling` in the
    /// `EDO24` domain.
    public init(_ edo24: Pitch.Spelling<EDO24>) {
        self.init(letterName: edo24.letterName, modifier: edo24.modifier.edo12)
    }

    /// Creates a `Pitch.Spelling` in the `EDO12` `TuningSystem` from a `Pitch.Spelling` in the
    /// `EDO48` domain.
    public init(_ edo48: Pitch.Spelling<EDO48>) {
        self.init(letterName: edo48.letterName, modifier: edo48.modifier.edo24.edo12)
    }
}

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


// FIXME: Move to EDO12.swift when compiler bug is fixed
extension Pitch.Spelling where Tuning == EDO12 {

    // MARK: - Spelling Distance

    public var spellingDistance: LineOfFifths.Distance {
        return LineOfFifths.distance(ofPitchSpelling: self)
    }
}

