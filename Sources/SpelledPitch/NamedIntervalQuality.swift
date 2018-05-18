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

    /// - Returns: Inversion of `self`
    public var inverse: NamedIntervalQuality {
        switch self {
        case .perfect:
            return .perfect
        case .imperfect(let quality):
            return .imperfect(quality.inverse)
        case .augmentedOrDiminished(let quality):
            return .augmentedOrDiminished(quality.inverse)
        }
    }

    case perfect
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
            self = NamedIntervalQuality.perfect
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


///// - FIXME: Documentation
//public enum NamedIntervalQuality: Int, InvertibleEnum {
//
//    // MARK: - Nested Types
//
//    public enum Degree: Int {
//        case single = 1
//        case double = 2
//    }
//
//    // MARK: - Cases
//
//    case diminished = -2
//    case minor = -1
//    case perfect = 0
//    case major = 1
//    case augmented = 2
//
//    public static let perfects: Set<NamedIntervalQuality> = [
//        .diminished,
//        .perfect,
//        .augmented
//    ]
//
//    public static let imperfects: Set<NamedIntervalQuality> = [
//        .diminished,
//        .minor,
//        .major,
//        .augmented
//    ]
//
//    /// Degree (single)
//    //public let degree: Degree
//
//    /// - returns: `true` if this `NamedIntervalQuality` is in the perfect class.
//    public var isPerfect: Bool {
//        return NamedIntervalQuality.perfects.contains(self)
//    }
//
//    /// - returns: `true` if this `NamedIntervalQuality` is in the imperfect class.
//    public var isImperfect: Bool {
//        return NamedIntervalQuality.imperfects.contains(self)
//    }
//
//    // MARK: - Initializers
////
////    public init(rawValue: Int) {
////        self.rawValue = rawValue
////        self.degree = .single
////    }
////
////    public init(rawValue: Int, degree: Degree) {
////        self.rawValue = rawValue
////        self.degree = degree
////    }
//
//    public init <Ordinal: NamedIntervalOrdinal> (
//        sanitizedIntervalClass: Double,
//        ordinal: Ordinal
//    )
//    {
//        func diminishedAndAugmentedThresholds(ordinal: Ordinal) -> (Double, Double) {
//            let result: Double = ordinal == Ordinal.unison ? 0.5 : ordinal.isPerfect ? 1 : 1.5
//            return (-result, result)
//        }
//
//        /// The thresholds that need to be crossed in order to manage diminished and augmented
//        /// intervals.
//        let (diminished, augmented) = diminishedAndAugmentedThresholds(ordinal: ordinal)
//
//        switch sanitizedIntervalClass {
//        case diminished:
//            self = NamedIntervalQuality.diminished
//        case augmented:
//            self = NamedIntervalQuality.augmented
//        case _ where sanitizedIntervalClass < diminished:
//
//            print("Warning: only support up to double diminished!")
//            self = NamedIntervalQuality.diminished[.double]!
//
//        case -0.5:
//            self = NamedIntervalQuality.minor
//        case +0.0:
//            self = NamedIntervalQuality.perfect
//        case +0.5:
//            self = NamedIntervalQuality.major
//        case _ where sanitizedIntervalClass > augmented:
//
//            print("Warning: only support up to double augmented!")
//            self = NamedIntervalQuality.augmented[.double]!
//
//        default:
//            fatalError("Not possible to create a NamedIntervalQuality with \(sanitizedIntervalClass) and \(ordinal)"
//            )
//        }
//    }
//
////    // MARK: - Subscripts
////
////    public subscript(degree: Degree) -> NamedIntervalQuality? {
////        switch (degree, self) {
////        case
////        (.single, _),
////        (_, NamedIntervalQuality.diminished),
////        (_, NamedIntervalQuality.augmented):
////            return NamedIntervalQuality(rawValue: rawValue, degree: degree)
////        default:
////            return nil
////        }
////    }
//}
