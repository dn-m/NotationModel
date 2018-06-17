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

            guard cur > 0 else {
                return []
            }

            guard next > 0 else {
                return .init(repeating: .beamlet(direction: .forward), count: cur)
            }

            let beamletAmount = cur > next ? cur - next : 0

            let starts = Array(repeating: State.start, count: min(cur,next))
            let beamlets = Array(repeating: State.beamlet(direction: .forward), count: beamletAmount)

            return starts + beamlets
        }
        
        /// - returns: `Ranges` for a middle value.
        func middle(_ prev: Int, _ cur: Int, _ next: Int) -> [State] {

            // FIXME: Sanitize this input so that negative numbers never get here!
            guard cur > 0 else {
                return []
            }

            // FIXME: Sanitize this input so that negative numbers never get here!
            guard prev > 0 else {
                
                if next <= 0 {
                    let beamletAmount = cur - next > 0 ? cur - next : 0
                    return .init(repeating: .beamlet(direction: .backward), count: beamletAmount)
                }

                let starts = Array(repeating: State.start, count: next)
                let beamletAmount = cur - next > 0 ? cur - next : 0
                let beamlets = Array(repeating: State.beamlet(direction: .backward), count: beamletAmount)
                return starts + beamlets
            }
            
            guard next > 0 else {
                
                if prev <= 0 {
                    let beamletAmount = cur - next > 0 ? cur - next : 0
                    return Array(repeating: State.beamlet(direction: .backward), count: beamletAmount)
                }

                let stops = Array(repeating: State.stop, count: prev)
                let beamletCount = cur - prev > 0 ? cur - prev : 0
                let beamlets = Array(repeating: State.beamlet(direction: .backward), count: beamletCount)
                return stops + beamlets
            }

            let maintains = Array(repeating: State.maintain, count: min(prev,cur,next))
            let starts = Array(repeating: State.start, count: max(0, min(cur,next) - prev))
            let stops = Array(repeating: State.stop, count: max(0, min(cur,prev) - next))

            let beamlets = Array(
                repeating: State.beamlet(direction: .backward),
                count: max(0, cur - max(prev,next))
            )

            return maintains + starts + stops + beamlets
        }
        
        /// - returns: `Ranges` for a last value.
        func last(_ prev: Int, _ cur: Int) -> [State] {
            
            guard cur > 0 else {
                return []
            }
            
            guard prev > 0 else {
                return Array(repeating: .beamlet(direction: .backward), count: cur)
            }

            let stops = Array(repeating: State.stop, count: min(cur,prev))
            let beamletCount = cur > prev ? cur - prev : 0
            let beamlets = Array(repeating: State.beamlet(direction: .backward), count: beamletCount)
            return stops + beamlets
        }
        
        /// - returns: `Ranges` for the given context.
        func ranges(_ prev: Int?, _ cur: Int, _ next: Int?) -> [State] {
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

        self.init(ranges(prev,cur,next))
    }
}

extension RhythmSpelling.BeamJunction: CustomStringConvertible {
    
    public var description: String {
        return states.description
    }
}

