//
//  NamedIntervalQuality.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import DataStructures

public enum NamedIntervalQuality: Invertible, Equatable {

    /// An augmented or diminished named interval quality
    public struct AugmentedOrDiminishedQuality: Invertible, Equatable {

        public enum AugmentedOrDiminished {
            case augmented
            case diminished
        }

        public enum Degree {
            case single
            case double
            case triple
            case quadruple
            case quintuple
        }

        /// - Returns: Inversion of `self`.
        public var inverse: AugmentedOrDiminishedQuality {
            switch quality {
            case .augmented:
                return AugmentedOrDiminishedQuality(degree, .diminished)
            case .diminished:
                return AugmentedOrDiminishedQuality(degree, .augmented)
            }
        }

        let quality: AugmentedOrDiminished
        let degree: Degree

        public init(_ degree: Degree = .single, _ quality: AugmentedOrDiminished) {
            self.degree = degree
            self.quality = quality
        }
    }

    /// An imperect interval quality
    public enum ImperfectQuality: InvertibleEnum {
        case major
        case minor
    }

    public enum PerfectQuality {
        case perfect
    }

    /// - Returns: Inversion of `self`
    public var inverse: NamedIntervalQuality {
        switch self {
        case .perfect:
            return .perfect(.perfect)
        case .imperfect(let quality):
            return .imperfect(quality.inverse)
        case .augmentedOrDiminished(let quality):
            return .augmentedOrDiminished(quality.inverse)
        }
    }

    case perfect(PerfectQuality)
    case imperfect(ImperfectQuality)
    case augmentedOrDiminished(AugmentedOrDiminishedQuality)

    public init (sanitizedIntervalClass: Double, ordinal: RelativeNamedInterval.Ordinal) {

        func diminishedAndAugmentedThresholds(ordinal: RelativeNamedInterval.Ordinal)
            -> (Double, Double)
        {
            let result: Double = ordinal == .unison ? 0.5 : ordinal.isPerfect ? 1 : 1.5
            return (-result, result)
        }

        /// The thresholds that need to be crossed in order to manage diminished and augmented
        /// intervals.
        let (diminished, augmented) = diminishedAndAugmentedThresholds(ordinal: ordinal)

        switch sanitizedIntervalClass {
        case diminished:
            self = NamedIntervalQuality.augmentedOrDiminished(.init(.single, .diminished))
        case augmented:
            self = NamedIntervalQuality.augmentedOrDiminished(.init(.single, .augmented))
        case _ where sanitizedIntervalClass < diminished:
            print("Warning: only support up to double diminished!")
            self = NamedIntervalQuality.augmentedOrDiminished(.init(.double, .diminished))
        case -0.5:
            self = NamedIntervalQuality.imperfect(.minor)
        case +0.0:
            self = NamedIntervalQuality.perfect(.perfect)
        case +0.5:
            self = NamedIntervalQuality.imperfect(.major)
        case _ where sanitizedIntervalClass > augmented:
            print("Warning: only support up to double augmented!")
            self = NamedIntervalQuality.augmentedOrDiminished(.init(.double, .augmented))
        default:
            fatalError("Not possible to create a NamedIntervalQuality with \(sanitizedIntervalClass) and \(ordinal)"
            )
        }
    }
}

