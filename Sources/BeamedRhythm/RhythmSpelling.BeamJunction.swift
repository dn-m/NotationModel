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
        
        typealias Ranges = (
            start: CountableClosedRange<Int>?,
            stop: CountableClosedRange<Int>?,
            maintain: CountableClosedRange<Int>?,
            beamlet: (CountableClosedRange<Int>, BeamletDirection)?
        )
        
        /// - returns: `Ranges` for a singleton value.
        func singleton(_ cur: Int) -> [State] {
            return (0..<cur).map { _ in .beamlet(direction: .forward) }
        }
        
        /// - returns: `Ranges` for a first value.
        func first(_ cur: Int, _ next: Int) -> [State] {

            guard cur > 0 else {
                return []
            }
            
            guard next > 0 else {
                return (0..<cur).map { _ in .beamlet(direction: .forward) }
            }
            
            let startRange = 1 ... min(cur,next)
            let beamletRange = cur > next ? (next + 1) ... cur : nil
            
            return (
                start: startRange,
                stop: nil,
                maintain: nil,
                beamlet: beamletRange == nil ? nil : (beamletRange!, .forward)
            )
        }
        
        /// - returns: `Ranges` for a middle value.
        func middle(_ prev: Int, _ cur: Int, _ next: Int) -> Ranges {

            guard cur > 0 else {
                return (start: nil, stop: nil, maintain: nil, beamlet: nil)
            }
            
            guard prev > 0 else {
                
                if next <= 0 {
                    return (
                        start: nil,
                        stop: nil,
                        maintain: nil,
                        beamlet: (cur - next) > 0 ? (0 ... (cur - next), .backward) : nil
                    )
                }
                
                return (
                    start: 1 ... next,
                    stop: nil,
                    maintain: nil,
                    beamlet: (cur - next) > 0 ? (0 ... (cur - next), .backward) : nil
                )
            }
            
            guard next > 0 else {
                
                if prev <= 0 {
                    return (
                        start: nil,
                        stop: nil,
                        maintain: nil,
                        beamlet: (cur - next) > 0 ? (0 ... (cur - next), .backward) : nil
                    )
                }
                
                return (
                    start: nil,
                    stop: 1 ... prev,
                    maintain: nil,
                    beamlet: (cur - prev) > 0 ? (1 ... (cur - prev), .backward) : nil
                )
            }

            let maintain = min(prev,cur,next)
            let startAmount = max(0, min(cur,next) - prev)
            let stopAmount = max(0, min(cur,prev) - next)
            let beamletAmount = cur - max(prev,next)

            var beamletRange: CountableClosedRange<Int>? {
                
                guard beamletAmount > 0 else {
                    return nil
                }
                
                let lowerBound = max(maintain,startAmount,stopAmount)
                return (lowerBound + 2) ... (lowerBound + 1) + beamletAmount
            }
            
            return (
                start: startAmount > 0 ? (maintain + 1) ... maintain + startAmount : nil,
                stop: stopAmount > 0 ? (maintain + 1) ... maintain + stopAmount : nil,
                maintain: 1 ... min(prev,cur,next),
                beamlet: beamletRange == nil ? nil : (beamletRange!, .backward)
            )
        }
        
        /// - returns: `Ranges` for a last value.
        func last(_ prev: Int, _ cur: Int) -> Ranges {
            
            guard cur > 0 else {
                return (start: nil, stop: nil, maintain: nil, beamlet: nil)
            }
            
            guard prev > 0 else {
                return (start: nil, stop: nil, maintain: nil, beamlet: (1...cur, .backward))
            }

            let stopRange =  1 ... min(cur,prev)
            let beamletRange = cur > prev ? (prev + 1) ... cur : nil
            
            return (
                start: nil,
                stop: stopRange,
                maintain: nil,
                beamlet: beamletRange == nil ? nil : (beamletRange!, .backward)
            )
        }
        
        /// - returns: `Ranges` for the given context.
        func ranges(_ prev: Int?, _ cur: Int, _ next: Int?) -> Ranges {
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
        
        // TODO: Refactor
        var result: [Int: State] = [:]
        let (start, stop, maintain, beamlets) = ranges(prev,cur,next)
        start?.forEach { result[$0] = .start }
        stop?.forEach { result[$0] = .stop }
        maintain?.forEach { result[$0] = .maintain }
        
        // TODO: Refactor
        let beamletDirection = beamlets?.1
        let beamletRange = beamlets?.0
        beamletRange?.forEach { result[$0] = .beamlet(direction: beamletDirection!) }
        
        self.init(result)
    }
}

extension RhythmSpelling.BeamJunction: CustomStringConvertible {
    
    public var description: String {
        return states.description
    }
}

