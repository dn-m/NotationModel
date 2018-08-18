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

        /// Creates an `Extended` `NamedIntervalQuality` with the given `degree` and `quality.`
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
    public enum Degree {

        /// Single extended named interval quality degree.
        case single

        /// Double extended named interval quality degree.
        case double

        /// Triple extended named interval quality degree.
        case triple

        /// Quadruple extended named interval quality degree.
        case quadruple

        /// Quintuple extended named interval quality degree.
        case quintuple
    }
}

func quality(interval: Double, with platonicThreshold: Double) -> SpelledIntervalQuality {
    let (diminished, augmented) = (-platonicThreshold,platonicThreshold)
    switch interval {
    case diminished - 4:
        return .extended(.init(.quintuple, .diminished))
    case diminished - 3:
        return .extended(.init(.quadruple, .diminished))
    case diminished - 2:
        return .extended(.init(.triple, .diminished))
    case diminished - 1:
        return .extended(.init(.double, .diminished))
    case diminished:
        return .extended(.init(.single, .diminished))
    case augmented:
        return .extended(.init(.single, .augmented))
    case augmented + 1:
        return .extended(.init(.double, .augmented))
    case augmented + 2:
        return .extended(.init(.triple, .augmented))
    case augmented + 3:
        return .extended(.init(.quadruple, .augmented))
    case augmented + 4:
        return .extended(.init(.quintuple, .augmented))
    case -0.5:
        return .imperfect(.minor)
    case +0.0:
        return .perfect(.perfect)
    case +0.5:
        return.imperfect(.major)
    default:
        fatalError("Not possible to create a NamedIntervalQuality with interval \(interval)")
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

extension SpelledIntervalQuality.Extended: Equatable, Hashable { }
extension SpelledIntervalQuality: Equatable, Hashable { }
