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
    /// - prev: Previous beaming value (if it exists)
    /// - cur: Current beaming value
    /// - next: Next beaming value (if it exists)
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
        
        /// - returns: `Ranges` for a singleton value.
        func singleton(_ cur: Int) -> [State] {
            return beamlets(.forward, cur)
        }
        
        /// - returns: `Ranges` for a first value.
        func first(_ cur: Int, _ next: Int) -> [State] {
            guard cur > 0 else { return [] }
            guard next > 0 else { return beamlets(.forward, cur) }
            return starts(min(cur,next)) + beamlets(.forward, cur > next ? cur - next : 0)
        }
        
        /// - returns: `Ranges` for a middle value.
        func middle(_ prev: Int, _ cur: Int, _ next: Int) -> [State] {

            // FIXME: Sanitize this input so that negative numbers never get here!
            guard cur > 0 else { return [] }

            // FIXME: Sanitize this input so that negative numbers never get here!
            guard prev > 0 else {
                if next <= 0 { return beamlets(.backward, cur - next > 0 ? cur - next : 0) }
                return starts(next) + beamlets(.backward, cur - next > 0 ? cur - next : 0)
            }
            
            guard next > 0 else {
                if prev <= 0 { return beamlets(.backward, cur - next > 0 ? cur - next : 0) }
                return stops(prev) + beamlets(.backward, cur - prev > 0 ? cur - prev : 0)
            }

            return (
                maintains(min(prev,cur,next)) +
                starts(max(0, min(cur,next) - prev)) +
                stops(max(0, min(cur,prev) - next)) +
                beamlets(.backward, max(0, cur - max(prev,next)))
            )
        }
        
        /// - returns: `Ranges` for a last value.
        func last(_ prev: Int, _ cur: Int) -> [State] {
            
            guard cur > 0 else {
                return []
            }
            
            guard prev > 0 else {
                return beamlets(.backward, cur)
            }

            return stops(min(cur,prev)) + beamlets(.backward, cur > prev ? cur - prev : 0)
        }
        
        /// - returns: `Ranges` for the given context.
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

