//
//  Beaming.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import Duration

/// The beaming information for an entire `Rhythm`.
public struct Beaming: Equatable {

    /// The `Point.Vertical` values contained herein.
    var verticals: [Point.Vertical]

    // MARK: - Initializers

    /// Creates a `Beaming` with the given `verticals`.
    public init <C> (_ verticals: C) where C: Collection, C.Element == Point.Vertical {
        self.verticals = Array(sanitizingBeamletDirections(for: verticals))
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

/// - Returns: An `Array` of `Beaming.Point.Vertical` values which have a reasonable initial default
/// of beamlet directions. For now, it only does two things: ensures that the first (or single)
/// vertical is `.forward`, and that the last vertical is `.backward`.
///
/// - Note: A much more thoughtful algorithm could and should be implemented (that is syncopation-,
/// and hierarchically-aware).
public func sanitizingBeamletDirections <C> (for verticals: C) -> [Beaming.Point.Vertical]
    where C: Collection, C.Element == Beaming.Point.Vertical
{
    return verticals.enumerated().map { (index,vertical) in
        if vertical.startOrStop == .none && vertical.beamletCount > 0 {
            if index == 0 {
                return vertical.with(beamletDirection: .forward)
            } else if index == verticals.count - 1 {
                return vertical.with(beamletDirection: .backward)
            }
        }
        return vertical
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

        /// Creates a `StartOrStop.start` with the given `start` amount. If `start` is `0`, a
        /// `.none` value will be created.
        public init(start: Int) {
            precondition(start >= 0)
            self = start == 0 ? .none : .start(count: start)
        }

        /// Creates a `StartOrStop.stop` with the given `stop` amount. If `stop` is `0`, a
        /// `.none` value will be created.
        public init(stop: Int) {
            precondition(stop >= 0)
            self = stop == 0 ? .none : .stop(count: stop)
        }

        // MARK: - Instance Methods

        /// - Returns: A `StartOrStop` transformed by reducing the count to the degree possible,
        /// along with the remaining amount that could not be absorbed.
        func cut(amount: Int) -> (StartOrStop,Int) {
            switch self {
            case .none:
                return (.none, amount)
            case .start(let count):
                return (.init(start: max(0, count - amount)), max(amount - count, 0))
            case .stop(let count):
                return (.init(stop: max(0, count - amount)), max(amount - count, 0))
            }
        }

        var beamletDirection: Beaming.BeamletDirection? {
            switch self {
            case .none:
                return nil
            case .start:
                return .forward
            case .stop:
                return .backward
            }
        }

    }
}

extension Beaming.Point {

    /// Rhythm.Beaming.Point.Vertical.
    public struct Vertical: Equatable {

        /// - Returns: The `Point` values contained herein.
        public var points: [Beaming.Point] {
            return (
                Array(repeating: .maintain, count: maintainCount) +
                startOrStop.points +
                Array(
                    repeating: .beamlet(direction: beamletDirection ?? .forward),
                    count: beamletCount
                )
            )
        }

        /// The amount of `.maintain` points.
        let maintainCount: Int

        /// The amount of `.start` or `.stop` points.
        let startOrStop: StartOrStop

        /// The amount of `.beamlet` points.
        let beamletCount: Int

        /// The direction of beamlets if they are present.
        let beamletDirection: Beaming.BeamletDirection?

        // MARK: - Initializers

        /// Creates a `Beaming.Point.Vertical` with the given beaming attributes.
        public init(maintain: Int = 0, startOrStop: StartOrStop = .none, beamlets: Int = 0) {
            self.maintainCount = maintain
            self.startOrStop = startOrStop
            self.beamletCount = beamlets
            self.beamletDirection = startOrStop.beamletDirection
        }

        /// Creates a `Beaming.Point.Vertical` with the given beaming attributes.
        public init(maintain: Int = 0, start: Int, beamlets: Int = 0) {
            self.maintainCount = maintain
            self.startOrStop = .init(start: start)
            self.beamletCount = beamlets
            self.beamletDirection = startOrStop.beamletDirection
        }

        /// Creates a `Beaming.Point.Vertical` with the given beaming attributes.
        public init(maintain: Int = 0, stop: Int, beamlets: Int = 0) {
            self.maintainCount = maintain
            self.startOrStop = .init(stop: stop)
            self.beamletCount = beamlets
            self.beamletDirection = startOrStop.beamletDirection
        }

        /// Creates a `Beaming.Point.Vertical` with the given beaming attributes.
        public init(
            maintainCount: Int,
            startOrStop: StartOrStop,
            beamletCount: Int,
            beamletDirection: Beaming.BeamletDirection?
        )
        {
            self.maintainCount = maintainCount
            self.startOrStop = startOrStop
            self.beamletCount = beamletCount
            self.beamletDirection = beamletDirection
        }

        // MARK: - Instance Methods

        /// - Returns: `Vertical` with the given `beamletDirection`.
        func with(beamletDirection: Beaming.BeamletDirection) -> Vertical {
            return .init(
                maintainCount: maintainCount,
                startOrStop: startOrStop,
                beamletCount: beamletCount,
                beamletDirection: beamletDirection
            )
        }

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
                let remaining = Swift.max(amount - maintainCount, 0)
                let vertical = Vertical(
                    maintain: Swift.max(maintainCount - amount, 0),
                    start: Swift.min(amount, maintainCount),
                    beamlets: beamletCount
                )
                return (vertical, remaining)
            case .start(let count):
                let remaining = Swift.max(amount - maintainCount, 0)
                let vertical = Vertical(
                    maintain: Swift.max(maintainCount - amount, 0),
                    start: Swift.min(amount, maintainCount) + count,
                    beamlets: beamletCount
                )
                return (vertical, remaining)
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
                let remaining = Swift.max(amount - maintainCount, 0)
                let vertical = Vertical(
                    maintain: Swift.max(maintainCount - amount, 0),
                    stop: Swift.min(amount, maintainCount),
                    beamlets: beamletCount
                )
                return (vertical, remaining)
            case .stop(let count):
                let remaining = Swift.max(amount - maintainCount, 0)
                let vertical = Vertical(
                    maintain: Swift.max(maintainCount - amount, 0),
                    stop: Swift.min(amount, maintainCount) + count,
                    beamlets: beamletCount
                )
                return (vertical, remaining)
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
            guard remaining1 > 0 else { return vertical1 }

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
            let (vertical1, remaining1) = startsToBeamlets(amount: amount)
            guard remaining1 > 0 else { return vertical1 }

            // 2. Convert maintains to stops
            let (vertical2, remaining2) = vertical1.maintainsToStops(amount: remaining1)
            guard remaining2 == 0 else { throw Beaming.Error.notEnoughPoints }
            return vertical2
        }
    }
}

extension Beaming.Point.Vertical: Collection {

    // MARK: - Collection

    public typealias Base = [Beaming.Point]

    public var base: [Beaming.Point] {
        return points
    }

    /// Start index.
    public var startIndex: Base.Index {
        return base.startIndex
    }

    /// End index.
    public var endIndex: Base.Index {
        return base.endIndex
    }

    /// Index after given index `i`.
    public func index(after i: Base.Index) -> Base.Index {
        return base.index(after: i)
    }

    /// - returns: Element at the given `index`.
    public subscript (index: Base.Index) -> Base.Element {
        return base[index]
    }
}

extension Beaming.Point.Vertical: CustomStringConvertible {
    public var description: String {
        return points.map { "\($0)" }.joined(separator: "\n")
    }
}

extension Beaming.Point: CustomStringConvertible {

    public var description: String {
        switch self {
        case .maintain:
            return "maintain"
        case .start:
            return "start"
        case .stop:
            return "stop"
        case .beamlet(let direction):
            switch direction {
            case .backward:
                return "< beamlet"
            case .forward:
                return "beamlet >"
            }
        }
    }
}

extension Beaming: RandomAccessCollection {

    // MARK: - RandomAccessCollection

    public typealias Base = [Point.Vertical]

    public var base: [Point.Vertical] {
        return verticals
    }

    /// Start index.
    ///
    /// - Complexity: O(1)
    ///
    public var startIndex: Base.Index {
        return base.startIndex
    }

    /// End index.
    ///
    /// - Complexity: O(1)
    ///
    public var endIndex: Base.Index {
        return base.endIndex
    }

    /// First element, if there is at least one element. Otherwise, `nil`.
    ///
    /// - Complexity: O(1)
    ///
    public var first: Base.Element? {
        return base.first
    }

    /// Last element, if there is at least one element. Otherwise, `nil`.
    ///
    /// - Complexity: O(1)
    ///
    public var last: Base.Element? {
        return base.last
    }

    /// Amount of elements.
    ///
    /// - Complexity: O(1)
    ///
    public var count: Int {
        return base.count
    }

    /// - Returns: `true` if there are no elements contained herein. Otherwise, `false`.
    ///
    /// - Complexity: O(1)
    ///
    public var isEmpty: Bool {
        return base.isEmpty
    }

    /// - Returns: The element at the given `index`.
    ///
    /// - Complexity: O(1)
    ///
    public subscript(position: Base.Index) -> Base.Element {
        return base[position]
    }

    /// - Returns: Index after the given `index`.
    ///
    /// - Complexity: O(1)
    public func index(after index: Base.Index) -> Base.Index {
        return base.index(after: index)
    }

    /// - Returns: Index before the given `index`.
    ///
    /// - Complexity: O(1)
    ///
    public func index(before index: Base.Index) -> Base.Index {
        return base.index(before: index)
    }
}

extension Beaming: CustomStringConvertible {

    /// - Returns: An `ASCII` representation which looks vaguely like real-world rhythms, for the
    /// purposes of eye-balling beam(let) computation errors not caught in logic testing.
    public var description: String {

        let stem = ":"
        let beamSegment = "--"
        let beamlet = "-"
        let air = " "
        let beamlessStem = air + air + stem + air + air

        /// - Returns: An `ASCII` represenation of a `Beaming.Point.Vertical`.
        func toASCII(vertical: Beaming.Point.Vertical) -> [String] {
            return vertical.map(toASCII)
        }

        /// - Returns: An `ASCII` representation of a `Beaming.Point`.
        func toASCII(point: Beaming.Point) -> String {
            switch point {
            case .maintain:
                return beamSegment + stem + beamSegment
            case .start:
                return air + air + stem + beamSegment
            case .stop:
                return beamSegment + stem + air + air
            case .beamlet(let direction):
                switch direction {
                case .backward:
                    return air + beamlet + stem + air + air
                case .forward:
                    return air + air + stem + beamlet + air
                }
            }
        }

        /// - Returns: A `String` representation of a `Vertical` with the amount of beam counts
        /// (which should be present) prepended.
        func addingBeamCounts(index: Int, event: [String]) -> [String] {
            let beamCountString = String(verticals[index].count)
            let width = beamCountString.count
            // This assumes knowledge of the ASCII representation of beaming events
            let padding = 3 - width
            let result = "  \(beamCountString)" + repeatElement(" ", count: padding)
            return [result] + event
        }

        /// - Returns: A `String` representation of a `Vertical` with little stemlets appended
        /// to match the maximum height.
        func normalizing(_ event: [String]) -> (_ maxHeight: Int) -> [String] {
            return { maxHeight in
                event + repeatElement(beamlessStem, count: maxHeight - event.count)
            }
        }

        /// - Returns: A `String` representation of a `Vertical` with a little stemlet appended.
        func addingTrailingStem(event: [String]) -> [String] {
            return event + [beamlessStem]
        }

        /// - Returns: Strings arranged by level from strings arranged by vertical.
        func pivot(_ events: [[String]]) -> [[String]] {
            var result: [[String]] = Array(repeating: [], count: events.first?.count ?? 0 + 1)
            for event in events {
                for (index,point) in event.enumerated() {
                    result[index].append(point)
                }
            }
            return result
        }

        /// - Returns: A single `String`representation of the nested array of `Beaming.Point` string
        /// representations.
        func joining(_ levels: [[String]]) -> String {
            return levels.map { level in level.joined() }.joined(separator: "\n")
        }

        let maxHeight = verticals.map { $0.count }.max() ?? 0

        return joining(
            pivot(
                verticals
                    .map(toASCII)
                    .map { normalizing($0)(maxHeight) }
                    .map(addingTrailingStem)
                    .enumerated()
                    .map(addingBeamCounts)
            )
        )
    }
}
