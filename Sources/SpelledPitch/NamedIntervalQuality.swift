//
//  NamedIntervalQuality.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import DataStructures

/// The quality of a `NamedInterval`.
public enum NamedIntervalQuality: Invertible {

    /// An augmented or diminished named interval quality
    public struct Extended: Invertible {

        /// Either augmented or diminished
        public enum AugmentedOrDiminished: InvertibleEnum {
            case augmented
            case diminished
        }

        /// The degree to which an `Extended` quality is augmented or diminished.
        public enum Degree {
            case single
            case double
            case triple
            case quadruple
            case quintuple
        }

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

    /// An imperfect interval quality.
    public enum Imperfect: InvertibleEnum {
        case major
        case minor
    }

    /// A perfect interval quality.
    public enum Perfect {
        case perfect
    }

    /// - Returns: Inversion of `self`
    public var inverse: NamedIntervalQuality {
        switch self {
        case .perfect:
            return .perfect(.perfect)
        case .imperfect(let quality):
            return .imperfect(quality.inverse)
        case .extended(let quality):
            return .extended(quality.inverse)
        }
    }

    case perfect(Perfect)
    case imperfect(Imperfect)
    case extended(Extended)

    /// Creates a `NamedIntervalQuality` with a "sanitized interval class` and the given `name`.
    ///
    // FIXME: Make internal or private
    public init (sanitizedIntervalClass: Double, name: NamedUnorderedInterval.Size) {

        func diminishedAndAugmentedThresholds(name: NamedUnorderedInterval.Size)
            -> (Double, Double)
        {
            var result: Double {
                switch name {
                case .perfect(let perfect):
                    switch perfect {
                    case .unison:
                        return 0.5
                    case .fourth:
                        return 1
                    }
                case .imperfect:
                    return 1.5
                }
            }

            return (-result, result)
        }

        /// The thresholds that need to be crossed in order to manage diminished and augmented
        /// intervals.
        let (diminished, augmented) = diminishedAndAugmentedThresholds(name: name)

        switch sanitizedIntervalClass {
        case diminished - 4:
            self = .extended(.init(.quintuple, .diminished))
        case diminished - 3:
            self = .extended(.init(.quadruple, .diminished))
        case diminished - 2.5:
            self = .extended(.init(.triple, .diminished))
        case diminished - 1:
            self = .extended(.init(.double, .diminished))
        case diminished:
            self = .extended(.init(.single, .diminished))
        case augmented:
            self = .extended(.init(.single, .augmented))
        case augmented + 1:
            self = .extended(.init(.double, .augmented))
        case augmented + 2.5:
            self = .extended(.init(.triple, .augmented))
        case augmented + 3:
            self = .extended(.init(.quadruple, .augmented))
        case augmented + 4:
            self = .extended(.init(.quintuple, .augmented))
        case -0.5:
            self = .imperfect(.minor)
        case +0.0:
            self = .perfect(.perfect)
        case +0.5:
            self = .imperfect(.major)
        default:
            fatalError("Not possible to create a NamedIntervalQuality with sanitized interval class \(sanitizedIntervalClass) and \(name)")
        }
    }
}

extension NamedIntervalQuality.Extended: Equatable, Hashable { }
extension NamedIntervalQuality: Equatable, Hashable { }
