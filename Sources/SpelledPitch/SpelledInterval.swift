//
//  SpelledInterval.swift
//  SpelledPitch
//
//  Created by James Bean on 8/17/18.
//

/// Interface for intervals of spelled pitches.
protocol SpelledInterval {

    // MARK: - Associated Types

    /// The `SpelledIntervalOrdinal` type for this `SpelledInterval`.
    associatedtype Ordinal: SpelledIntervalOrdinal

    // MARK: - Initializers

    /// Create a `SpelledInterval` with the given `quality` and the given `ordinal`.
    init(_ quality: SpelledIntervalQuality, _ ordinal: Ordinal)
}

extension SpelledInterval {

    /// Creates a `SpelledInterval`-conforming type with the given `interval` (i.e., the distance
    /// between the `NoteNumber` representations of `Pitch` or `Pitch.Class` values) and the given
    /// `steps` (i.e., the distance between the `LetterName` attributes of `Pitch.Spelling`
    /// values).
    init(interval: Double, steps: Int) {
        let (quality,ordinal) = Self.qualityAndOrdinal(interval: interval, steps: steps)
        self.init(quality,ordinal)
    }

    /// - Returns the `SpelledIntervalQuality` and `Ordinal` values for the given `interval` (i.e.,
    /// the distance between the `NoteNumber` representations of `Pitch` or `Pitch.Class` values)
    /// and the given `steps (i.e., the distance between the `LetterName` attributes of
    ///`Pitch.Spelling`  values).
    static func qualityAndOrdinal(interval: Double, steps: Int)
        -> (SpelledIntervalQuality, Ordinal)
    {
        let sanitized = Ordinal.sanitize(interval, steps: steps)
        let ordinal = Ordinal(steps: steps)!
        let threshold = ordinal.platonicThreshold
        return (quality(interval: sanitized, with: threshold), ordinal)
    }
}
