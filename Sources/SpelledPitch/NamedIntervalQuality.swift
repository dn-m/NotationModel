//
//  NamedIntervalQuality.swift
//  SpelledPitch
//
//  Created by James Bean on 1/8/17.
//
//

import Structure

/// - FIXME: Documentation
public struct NamedIntervalQuality: InvertibleOptionSet {
    
    // MARK: - Nested Types
    
    public enum Degree: Int {
        case single = 1
        case double = 2
    }
    
    // MARK: - Cases
    
    public static let diminished = NamedIntervalQuality(rawValue: 1 << 0)
    public static let minor = NamedIntervalQuality(rawValue: 1 << 1)
    public static let perfect = NamedIntervalQuality(rawValue: 1 << 2)
    public static let major = NamedIntervalQuality(rawValue: 1 << 3)
    public static let augmented = NamedIntervalQuality(rawValue: 1 << 4)
    
    public static let perfects: NamedIntervalQuality = [
        diminished,
        perfect,
        augmented
    ]
    
    public static let imperfects: NamedIntervalQuality = [
        diminished,
        minor,
        major,
        augmented
    ]
    
    // MARK: - Instance Properties
    
    /// Amount of options contained herein.
    public var optionsCount: Int {
        return 5
    }
    
    /// Raw value.
    public let rawValue: Int

    /// Degree (single)
    public let degree: Degree
    
    /// - returns: `true` if this `NamedIntervalQuality` is in the perfect class.
    public var isPerfect: Bool {
        return NamedIntervalQuality.perfects.contains(self)
    }
    
    /// - returns: `true` if this `NamedIntervalQuality` is in the imperfect class.
    public var isImperfect: Bool {
        return NamedIntervalQuality.imperfects.contains(self)
    }
    
    // MARK: - Initializers
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
        self.degree = .single
    }
    
    public init(rawValue: Int, degree: Degree) {
        self.rawValue = rawValue
        self.degree = degree
    }
    
    public init <Ordinal: NamedIntervalOrdinal> (
        sanitizedIntervalClass: Double,
        ordinal: Ordinal
    )
    {
        func diminishedAndAugmentedThresholds(ordinal: Ordinal) -> (Double, Double) {
            let result: Double = ordinal == Ordinal.unison ? 0.5 : ordinal.isPerfect ? 1 : 1.5
            return (-result, result)
        }
        
        /// The thresholds that need to be crossed in order to manage diminished and augmented
        /// intervals.
        let (diminished, augmented) = diminishedAndAugmentedThresholds(ordinal: ordinal)
        
        switch sanitizedIntervalClass {
        case diminished:
            self = NamedIntervalQuality.diminished
        case augmented:
            self = NamedIntervalQuality.augmented
        case _ where sanitizedIntervalClass < diminished:
            
            print("Warning: only support up to double diminished!")
            self = NamedIntervalQuality.diminished[.double]!
            
        case -0.5:
            self = NamedIntervalQuality.minor
        case +0.0:
            self = NamedIntervalQuality.perfect
        case +0.5:
            self = NamedIntervalQuality.major
        case _ where sanitizedIntervalClass > augmented:
            
            print("Warning: only support up to double augmented!")
            self = NamedIntervalQuality.augmented[.double]!
            
        default:
            fatalError("Not possible to create a NamedIntervalQuality with")
        }
    }
    
    // MARK: - Subscripts
    
    public subscript(degree: Degree) -> NamedIntervalQuality? {
        switch (degree, self) {
        case
        (.single, _),
        (_, NamedIntervalQuality.diminished),
        (_, NamedIntervalQuality.augmented):
            return NamedIntervalQuality(rawValue: rawValue, degree: degree)
        default:
            return nil
        }
    }
}

extension NamedIntervalQuality: Equatable {
    
    // MARK: - `Equatable`
    
    /// - returns: `true` if both `NamedIntervalQuality` values are equivalent. Otherwise,
    /// `false.`
    public static func == (lhs: NamedIntervalQuality, rhs: NamedIntervalQuality) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}

