//
//  SpelledRhythm.TieState.swift
//  RhythmSpellingTools
//
//  Created by James Bean on 2/13/17.
//
//

extension RhythmSpelling {
    
    /// Whether a tie is needed to start, stop, or not exist at all for a given
    /// `RhythmSpelling.Context`.
    public struct TieState: OptionSet {
        
        /// Raw value.
        public let rawValue: Int
        
        /// Creates a `TieState` with the given `rawValue`.
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        /// No ties needed.
        public static let none = TieState(rawValue: 0)
        
        /// Start tie.
        public static let start = TieState(rawValue: 1 << 0)
        
        /// Stop tie.
        public static let stop = TieState(rawValue: 1 << 1)
        
        /// Continue a tie by stopping the previous and starting a new one.
        public static let maintain: TieState = [start, stop]
    }
}
