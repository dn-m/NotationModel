//
//  Beaming.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import Rhythm

/// The beaming information for an entire `Rhythm`.
public struct Beaming: Equatable {

    /// The `Point.Vertical` values contained herein.
    var verticals: [Point.Vertical]

    // MARK: - Initializers

    /// Create a `Beaming` with the given `verticals`.
    public init(_ verticals: [Point.Vertical]) {
        self.verticals = verticals
    }

    /// Create a `Beaming` with the given `sequence`.
    public init <S> (_ sequence: S) where S: Sequence, S.Element == Point.Vertical {
        self.verticals = Array(sequence)
    }

    /// Subdivides beaming verticals by the given `amount` at the given `index`.
    ///
    /// - Throws: Error if the `Item` at the given `index` is empty.
    /// - Throws: Error if the `Item` at the given `index` is less than 1 or greater than equal
    /// to the amount of events contained herein.
    public func cut(amount: Int, at index: Int) throws -> Beaming {
        guard index > 0 && index < verticals.count else { throw Error.indexOutOfBounds(index) }
        let previous = try verticals[index - 1].cutAfter(amount: amount)
        let current = try verticals[index].cutAt(amount: amount)
        return Beaming(
            verticals.prefix(upTo: index - 1) +
            [previous,current] +
            verticals.suffix(from: index + 1)
        )
    }
}

extension Beaming {

    // MARK: - Errors

    /// Errors which may occur when performing an cutting operation on an `Item`.
    public enum Error: Swift.Error {
        case indexOutOfBounds(Int)
        case previousStackEmpty
        case currentStackEmpty
        case notEnoughPoints
    }
}

extension Beaming {

    /// Whether a beamlet is pointed forward or backward.
    public enum BeamletDirection: Double {
        case forward = 1
        case backward = -1
    }
}

extension Beaming {

    /// A single point of the beaming for a single beaming item (metrical context).
    public enum Point: Equatable {

        /// Maintain a beam on a given level.
        case maintain
        /// Start a beam on a given level.
        case start
        /// Stop a beam on a given level.
        case stop
        /// Add a beamlet on a given level.
        case beamlet(direction: BeamletDirection)
    }
}

extension Beaming.Point {

    /// A `Point` which can be either a `start` or `stop` or `none`.
    public enum StartOrStop: Equatable {

        // MARK: - Cases

        case none
        case start(count: Int)
        case stop(count: Int)

        // MARK: - Instance Properties

        /// The `Point` values contained herein.
        var points: [Beaming.Point] {
            switch self {
            case .none: return []
            case .start(let count):
                return Array(repeating: .start, count: count)
            case .stop(let count):
                return Array(repeating: .stop, count: count)
            }
        }

        // MARK: - Initializers

        /// Create a `StartOrStop.start` with the given `start` amount. If `start` is `0`, a
        /// `.none` value will be created.
        init(start: Int) {
            precondition(start >= 0)
            self = start == 0 ? .none : .start(count: start)
        }

        /// Create a `StartOrStop.stop` with the given `stop` amount. If `stop` is `0`, a
        /// `.none` value will be created.
        init(stop: Int) {
            precondition(stop >= 0)
            self = stop == 0 ? .none : .stop(count: stop)
        }

        // MARK: - Instance Methods

        /// - Returns: A `StartOrStop` transformed by reducing the count to the degree possible,
        /// along with the remaining amount that could not be absorbed.
        func cut(amount: Int) -> (StartOrStop, Int) {
            switch self {
            case .none:
                return (.none, amount)
            case .start(let count):
                let remaining = Swift.max(amount - count, 0)
                if count > amount {
                    return (.start(count: count - amount), remaining)
                } else {
                    return (.none, remaining)
                }
            case .stop(let count):
                let remaining = Swift.max(amount - count, 0)
                if count > amount {
                    return (.stop(count: count - amount), remaining)
                } else {
                    return (.none, remaining)
                }
            }
        }
    }
}

extension Beaming.Point {

    /// Rhythm.Beaming.Point.Vertical.
    public struct Vertical: Equatable {

        #warning("Implement beamlet direction if neither start nor stop")

        /// - Returns: The `Point` values contained herein.
        var points: [Beaming.Point] {
            return (
                Array(repeating: .maintain, count: maintainCount) +
                startOrStop.points +
                Array(repeating: .beamlet(direction: .forward), count: beamletCount)
            )
        }

        /// The amount of `.maintain` points.
        let maintainCount: Int

        /// The amount of `.start` or `.stop` points.
        let startOrStop: StartOrStop

        /// The amount of `.beamlet` points.
        let beamletCount: Int

        // MARK: - Initializers

        public init(maintain: Int = 0, startOrStop: StartOrStop = .none, beamlets: Int = 0) {
            self.maintainCount = maintain
            self.startOrStop = startOrStop
            self.beamletCount = beamlets
        }

        public init(maintain: Int = 0, start: Int, beamlets: Int = 0) {
            self.maintainCount = maintain
            self.startOrStop = .init(start: start)
            self.beamletCount = beamlets
        }

        public init(maintain: Int = 0, stop: Int, beamlets: Int = 0) {
            self.maintainCount = maintain
            self.startOrStop = .init(stop: stop)
            self.beamletCount = beamlets
        }

        // MARK: - Instance Methods

        /// - Returns: The `Vertical` updated by transforming its `.maintain` points into
        /// `.start` points, to the degree possible, along with the remaining amount which
        /// was not absorbable by the `Vertical`.
        ///
        /// This should only be used by the `cutAt` method.
        func maintainsToStarts(amount: Int) -> (Vertical,Int) {
            switch startOrStop {
            case .stop:
                return (self,amount)
            case .none:
                if maintainCount >= amount {
                    let vertical = Vertical(
                        maintain: maintainCount - amount,
                        start: amount,
                        beamlets: beamletCount
                    )
                    return (vertical, 0)
                } else {
                    let remaining = amount - maintainCount
                    let vertical = Vertical(
                        maintain: 0,
                        start: maintainCount,
                        beamlets: beamletCount
                    )
                    return (vertical, remaining)
                }
            case .start(let count):
                if maintainCount >= amount {
                    let vertical = Vertical(
                        maintain: maintainCount - amount,
                        start: count + amount,
                        beamlets: beamletCount
                    )
                    return (vertical, 0)
                } else {
                    let remaining = amount - maintainCount
                    let vertical = Vertical(
                        maintain: 0,
                        start: count + maintainCount,
                        beamlets: beamletCount
                    )
                    return (vertical, remaining)
                }
            }
        }

        /// - Returns: The `Vertical` updated by transforming its `.maintain` points into
        /// `.stop` points, to the degree possible, along with the remaining amount which
        /// was not absorbable by the `Vertical`.
        ///
        /// This should only be used by the `cutAfter` method.
        func maintainsToStops(amount: Int) -> (Vertical,Int) {
            switch startOrStop {
            case .start:
                return (self,amount)
            case .none:
                if maintainCount >= amount {
                    let vertical = Vertical(
                        maintain: maintainCount - amount,
                        stop: amount,
                        beamlets: beamletCount
                    )
                    return (vertical, 0)
                } else {
                    let remaining = amount - maintainCount
                    let vertical = Vertical(
                        maintain: 0,
                        stop: maintainCount,
                        beamlets: beamletCount
                    )
                    return (vertical, remaining)
                }
            case .stop(let count):
                if maintainCount >= amount {
                    let vertical = Vertical(
                        maintain: maintainCount - amount,
                        stop: count + amount,
                        beamlets: beamletCount
                    )
                    return (vertical, 0)
                } else {
                    let remaining = amount - maintainCount
                    let vertical = Vertical(
                        maintain: 0,
                        stop: count + maintainCount,
                        beamlets: beamletCount
                    )
                    return (vertical, remaining)
                }
            }
        }

        /// - Returns: The `Vertical` updated by transforming its `.stop` points into
        /// `.beamlet` points, to the degree possible, along with the remaining amount which
        /// was not absorbable by the `Vertical`.
        ///
        /// Should only be used by the `cutAt` method.
        func stopsToBeamlets(amount: Int) -> (Vertical,Int) {
            guard case .stop = startOrStop else { return (self,amount) }
            return startOrStopToBeamlets(amount: amount)
        }

        /// - Returns: The `Vertical` updated by transforming its `.start` points into
        /// `.beamlet` points, to the degree possible, along with the remaining amount which
        /// was not absorbable by the `Vertical`.
        ///
        /// Should only be used by the `cutAfter` method.
        func startsToBeamlets(amount: Int) -> (Vertical,Int) {
            guard case .start = startOrStop else { return (self,amount) }
            return startOrStopToBeamlets(amount: amount)
        }

        /// - Returns: The `Vertical` updated by transforming is `.startOrStop` points into
        /// the given `amount` of `.beamlet` points, to the degree possible.
        private func startOrStopToBeamlets(amount: Int) -> (Vertical,Int) {
            let (newStartOrStop, remaining) = startOrStop.cut(amount: amount)
            let vertical = Vertical(
                maintain: maintainCount,
                startOrStop: newStartOrStop,
                beamlets: beamletCount + (amount - remaining)
            )
            return (vertical, remaining)
        }

        /// Cuts `Vertical` when the current is `current`.
        func cutAt(amount: Int) throws -> Vertical {
            precondition(amount >= 0)
            guard !isEmpty else { throw Beaming.Error.currentStackEmpty }

            // Phase 1: Convert stops to beamlets
            let (vertical1, remaining1) = stopsToBeamlets(amount: amount)
            if remaining1 == 0 { return vertical1 }

            // Phase 2. Convert maintains to starts
            let (vertical2, remaining2) = vertical1.maintainsToStarts(amount: remaining1)

            guard remaining2 == 0 else { throw Beaming.Error.notEnoughPoints }
            return vertical2
        }

        /// Cuts `Vertical` when the current is `previous`.
        func cutAfter(amount: Int) throws -> Vertical {
            precondition(amount >= 0)
            guard !isEmpty else { throw Beaming.Error.previousStackEmpty }

            // 1. Convert starts to beamlets
            let (vertical1, remaining1) = self.startsToBeamlets(amount: amount)
            guard remaining1 > 0 else { return vertical1 }

            // 2. Convert maintains to stops
            let (vertical2, remaining2) = vertical1.maintainsToStops(amount: remaining1)
            guard remaining2 == 0 else { throw Beaming.Error.notEnoughPoints }
            return vertical2
        }
    }
}

extension Beaming.Point.Vertical: CollectionWrapping {
    public var base: [Beaming.Point] {
        return points
    }
}

extension Beaming.Point.Vertical: CustomStringConvertible {
    public var description: String {
        return points.map { "\($0)" }.joined(separator: "\n")
    }
}

extension Beaming: CollectionWrapping {
    public var base: [Point.Vertical] {
        return verticals
    }
}

extension Beaming: CustomStringConvertible {
    public var description: String {
        return verticals.enumerated()
            .map { (index,vertical) in "\(index): \(vertical)" }
            .joined(separator: "\n")
    }
}
