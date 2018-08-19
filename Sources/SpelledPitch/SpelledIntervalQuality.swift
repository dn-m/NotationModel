//
//  SpelledIntervalQuality.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import Algebra
import DataStructures

/// The quality of a `NamedInterval`.
public enum SpelledIntervalQuality: Invertible {

    // MARK: - Cases

    /// Perfect named interval qualities (perfect).
    case perfect(Perfect)

    /// Imperfect named interval qualities (major or minor).
    case imperfect(Imperfect)

    /// Extended named interval qualities (augmented or diminished).
    case extended(Extended)
}

extension SpelledIntervalQuality {

    // MARK: - Nested Types

    /// A perfect interval quality.
    public enum Perfect {

        // MARK: - Cases

        /// Perfect named interval quality.
        case perfect
    }

    /// An imperfect interval quality.
    public enum Imperfect: InvertibleEnum {

        // MARK: - Cases

        /// Major named interval quality.
        case major

        /// Minor named interval quality.
        case minor
    }

    /// An augmented or diminished named interval quality
    public struct Extended: Invertible {

        // MARK: Instance Properties

        /// - Returns: Inversion of `self`.
        public var inverse: Extended {
            return Extended(degree, quality.inverse)
        }

        /// Whether this `Extended` quality is augmented or diminished
        let quality: AugmentedOrDiminished

        /// The degree to which this quality is augmented or diminished (e.g., double augmented,
        /// etc.)
        let degree: Degree

        // MARK: Initializers

        /// Createss an `Extended` `NamedIntervalQuality` with the given `degree` and `quality.`
        public init(_ degree: Degree = .single, _ quality: AugmentedOrDiminished) {
            self.degree = degree
            self.quality = quality
        }
    }
}

extension SpelledIntervalQuality.Extended {

    // MARK: - Nested Types

    /// Either augmented or diminished
    public enum AugmentedOrDiminished: InvertibleEnum {

        // MARK: - Cases

        /// Augmented extended named interval quality.
        case augmented

        /// Diminished extended named interval quality.
        case diminished
    }

    /// The degree to which an `Extended` quality is augmented or diminished.
    public enum Degree: Int {

        /// Single extended named interval quality degree.
        case single = 1

        /// Double extended named interval quality degree.
        case double = 2

        /// Triple extended named interval quality degree.
        case triple = 3

        /// Quadruple extended named interval quality degree.
        case quadruple = 4

        /// Quintuple extended named interval quality degree.
        case quintuple = 5
    }
}

extension SpelledIntervalQuality {

    // MARK: - Instance Properties

    /// - Returns: Inversion of `self`
    public var inverse: SpelledIntervalQuality {
        switch self {
        case .perfect:
            return .perfect(.perfect)
        case .imperfect(let quality):
            return .imperfect(quality.inverse)
        case .extended(let quality):
            return .extended(quality.inverse)
        }
    }
}

extension SpelledIntervalQuality.Extended: Equatable { }
extension SpelledIntervalQuality.Extended: Hashable { }
extension SpelledIntervalQuality: Equatable { }
extension SpelledIntervalQuality: Hashable { }
