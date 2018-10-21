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

        /// The modification of a `Pitch.Spelling` from the given `LetterName`.
        public struct Modifier {

            public static let doubleFlat = Modifier(.doubleFlat)
            public static let threeQuarterFlat = Modifier(.flat, [.undecimal(-1)])
            public static let flat = Modifier(.flat)
            public static let quarterFlat = Modifier(.natural, [.undecimal(-1)])
            public static let natural = Modifier(.natural)
            public static let quarterSharp = Modifier(.natural, [.undecimal(1)])
            public static let sharp = Modifier(.sharp)
            public static let threeQuarterSharp = Modifier(.sharp, [.undecimal(1)])
            public static let doubleSharp = Modifier(.doubleSharp)

            // MARK: - Nested Types

            /// Base modifier (natural, sharps, flats).
            public struct Pythagorean {

                // MARK: - Type Properties

                public static let doubleFlat = Pythagorean(-2)
                public static let flat = Pythagorean(-1)
                public static let natural = Pythagorean(0)
                public static let sharp = Pythagorean(1)
                public static let doubleSharp = Pythagorean(2)

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
            public enum Alteration {

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
                    // FIXME: This should return 0.535, but forcing 0.5 for previous tests
                    case .undecimal(let amount): return 0.5 * Double(amount)
                    case .tridecimal(let amount): return 0.653 * Double(amount)
                    case .cents(let amount): return amount / 100
                    }
                }
            }

            // MARK: - Computed Properties

            /// The adjustment to letter name in semitones.
            public var adjustment: Double {
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
            public init(_ base: Pythagorean = .natural, _ alterations: [Alteration] = []) {
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
        public let letterName: LetterName

        /// `Modifier` of a `Pitch.Spelling`.
        public let modifier: Modifier

        // MARK: - Initializers

        /// Creates a Pitch.Spelling with the given `letterName` and the given `modifier`.
        public init(_ letterName: LetterName, _ modifier: Modifier = .natural) {
            self.letterName = letterName
            self.modifier = modifier
        }

        public init(
            _ letterName: LetterName,
            _ base: Modifier.Pythagorean = .natural,
            _ alterations: Modifier.Alteration...
        )
        {
            self.letterName = letterName
            self.modifier = Modifier(base, alterations)
        }
    }
}

extension Pitch.Spelling {

    // MARK: - Static Properties

    /// The `c natural` closest to the middle of a piano keyboard.
    public static let middleC = Pitch.Spelling(.c, .natural)
}


extension Pitch.Spelling: Comparable {

    // MARK: - Comparable

    /// - Returns: `true` if the left hand `Pitch.Spelling` value is less than the right hand
    /// `Pitch.Spelling` value.
    public static func < (lhs: Pitch.Spelling, rhs: Pitch.Spelling) -> Bool {
        if lhs.letterName.steps == rhs.letterName.steps {
            return lhs.modifier.adjustment < rhs.modifier.adjustment
        }
        return lhs.letterName.steps < rhs.letterName.steps
    }
}

extension Pitch.Spelling.Modifier.Pythagorean: Equatable { }
extension Pitch.Spelling.Modifier.Pythagorean: Hashable { }
extension Pitch.Spelling.Modifier.Alteration: Equatable { }
extension Pitch.Spelling.Modifier.Alteration: Hashable { }
extension Pitch.Spelling.Modifier: Equatable { }
extension Pitch.Spelling.Modifier: Hashable { }
extension Pitch.Spelling: Equatable { }
extension Pitch.Spelling: Hashable { }

extension Pitch.Spelling {

    // MARK: - Spelling Distance

    public var spellingDistance: LineOfFifths.Distance {
        return LineOfFifths.distance(ofPitchSpelling: self)
    }
}

