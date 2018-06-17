//
//  RhythmSpelling.BeamJunction.swift
//  RhythmSpellingTools
//
//  Created by James Bean on 2/13/17.
//
//

import Rhythm

extension RhythmSpelling {
    
    /// Model of `State` values for each beam-level
    public struct BeamJunction: Equatable {
        
        /// Whether a beamlet is pointed forward or backward.
        public enum BeamletDirection: Double {
            case forward = 1
            case backward = -1
        }
        
        /// Whether to start, stop, or maintain a beam for a given beam-level
        public enum State: Equatable {
            
            /// Start a beam on a given level.
            case start
            
            /// Stop a beam on a given level.
            case stop
            
            /// Maintain a beam on a given level.
            case maintain
            
            /// Add a beamlet on a given level.
            case beamlet(direction: BeamletDirection)
        }
        
        // MARK: - Instance Properties
        
        public let states: [State]
        
        // MARK: - Initializers
        
        /// Creates a `Junction` with a mapping of `State` to beam-level.
        public init(_ states: [State] = []) {
            self.states = states
        }
    }
}

extension RhythmSpelling.BeamJunction {
    
    /// Create a `Junction` with the given context:
    ///
    /// - prev: Previous beaming count (if it exists)
    /// - cur: Current beaming count
    /// - next: Next beaming count (if it exists)
    public init(_ prev: Int?, _ cur: Int, _ next: Int?) {

        func maintains(_ count: Int) -> [State] {
            return .init(repeating: .maintain, count: count)
        }

        func starts(_ count: Int) -> [State] {
            return .init(repeating: .start, count: count)
        }

        func stops(_ count: Int) -> [State] {
            return .init(repeating: .stop, count: count)
        }

        func beamlets(_ direction: BeamletDirection, _ count: Int) -> [State] {
            return .init(repeating: .beamlet(direction: direction), count: count)
        }
        
        /// - Returns: Array of `State` values for a singleton `BeamJunction`.
        func singleton(_ cur: Int) -> [State] {
            return beamlets(.forward, cur)
        }
        
        /// - Returns: Array of `State` values for a first `BeamJunction` in a sequence.
        func first(_ cur: Int, _ next: Int) -> [State] {
            guard cur > 0 else { return [] }
            guard next > 0 else { return beamlets(.forward, cur) }
            return starts(min(cur,next)) + beamlets(.forward, max(0, cur - next))
        }
        
        /// - Returns: Array of `State` values for a middle `BeamJunction` in a sequence.
        func middle(_ prev: Int, _ cur: Int, _ next: Int) -> [State] {

            guard cur > 0 else { return [] }

            guard prev > 0 else {
                if next <= 0 { return beamlets(.backward, max(0, cur - prev)) }
                return starts(next) + beamlets(.backward, max(0, cur - next))
            }
            
            guard next > 0 else {
                if prev <= 0 { return beamlets(.backward, max(0, cur - next)) }
                return stops(prev) + beamlets(.backward, max(0, cur - prev))
            }

            return (
                maintains(min(prev,cur,next)) +
                starts(max(0, min(cur,next) - prev)) +
                stops(max(0, min(cur,prev) - next)) +
                beamlets(.backward, max(0, cur - max(prev,next)))
            )
        }
        
        /// - Returns: Array of `State` values for a last `BeamJunction` in a sequence.
        func last(_ prev: Int, _ cur: Int) -> [State] {
            guard cur > 0 else { return [] }
            guard prev > 0 else { return beamlets(.backward, cur) }
            return stops(min(cur,prev)) + beamlets(.backward, max(0, cur - prev))
        }
        
        /// - Returns: Array of `State` values for a given `BeamJunction` context.
        func states(_ prev: Int?, _ cur: Int, _ next: Int?) -> [State] {
            switch (prev, cur, next) {
            case (nil, cur, nil):
                return singleton(cur)
            case (nil, let cur, let next?):
                return first(cur, next)
            case (let prev?, let cur, let next?):
                return middle(prev, cur, next)
            case (let prev?, let cur, nil):
                return last(prev, cur)
            default:
                fatalError("Ill-formed context")
            }
        }

        self.init(states(prev,cur,next))
    }
}

extension RhythmSpelling.BeamJunction: CustomStringConvertible {
    
    public var description: String {
        return states.description
    }
}
