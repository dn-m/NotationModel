//
//  Rhythm.Spelling.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import Math
import Duration

extension Rhythm {

    public struct Spelling: Equatable {

        /// Information needed to abstractly represent all of the tuplet brackets for a single
        /// `Rhythm`.
        public typealias Grouping = Tree<Group.Context,Group.Context>

        /// Whether a tie is needed to start, stop, or not exist at all for a given metrical
        /// instance.
        public enum Tie {
            /// No ties needed.
            case none
            /// Start tie.
            case start
            /// Stop tie.
            case stop
            /// Continue a tie by stopping the previous and starting a new one.
            case maintain
        }

        /// Information necessary to render a tuplet bracket.
        public struct Group: Equatable {

            /// `Group` in context, applying to the indices of the leaves to which it applies.
            public struct Context: Equatable {

                // MARK: - Instance Properties

                /// `Group`.
                public let group: Group

                /// Range of leaves to which the `group` applies.
                public let leafRange: CountableClosedRange<Int>

                // MARK: - Initializers

                /// Createss a `Group.Context` with the given `group` for the given `range` of leaf
                /// indices.
                public init(for group: Group, in range: CountableClosedRange<Int>) {
                    self.group = group
                    self.leafRange = range
                }
            }

            // MARK: - Instance Properties

            /// `Duration` of a `Group`.
            public let duration: Duration

            /// The sum of the contents contained herein.
            public let contentsSum: Int

            // MARK: - Instance Methods

            /// - Returns: The `Group.Context`, applying the `self` to the given `range` of leaf
            /// indices.
            public func context(range: CountableClosedRange<Int>) -> Context {
                return Context(for: self, in: range)
            }
        }

        /// Information needed to abstractly represent a single metrical instance.
        public struct Item: Equatable {
            let beamItem: Beaming.Point.Vertical
            let tie: Tie
            let dots: Int
        }

        /// All of the information needed to abstractly represent all of the metrical instances
        /// within a single `Rhythm`.
        let items: [Item]

        /// All of the information needed to abstractly represent tuplet information
        let grouping: Grouping

        // MARK: - Initializers

        /// Creates a `Rhythm.Spelling` with the given `items`.
        public init(items: [Item], grouping: Grouping) {
            self.items = items
            self.grouping = grouping
        }

        /// Creates a `Rhythm.Spelling` for the given `rhythm` using the given `beamer`.
        public init(rhythm: Rhythm, using beamer: (Rhythm) -> Beaming) {
            let beaming = beamer(rhythm)
            let ties = makeTies(rhythm.leaves.map { $0.context })
            let dots = makeDots(rhythm.durationTree.leaves)
            let items = zip(beaming, ties, dots).map(Item.init)
            let grouping = Spelling.makeGroups(rhythm.durationTree)
            self.init(items: items, grouping: grouping)
        }
    }
}

extension Rhythm.Spelling: Collection {

    // MARK: - Collection

    public typealias Base = [Item]

    public var base: [Item] {
        return items
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

extension Rhythm.Spelling.Group: CustomStringConvertible {
    public var description: String {
        return "\(contentsSum):\(duration)"
    }
}

extension Rhythm.Spelling.Group {

    /// Createss a `Group` for the given `metricalDurationTree`.
    public init(_ metricalDurationTree: DurationTree) {

        guard case .branch(let duration, let trees) = metricalDurationTree else {
            fatalError("Ill-formed DurationTree!")
        }

        self.init(
            duration: duration,
            contentsSum: trees.map { $0.value.numerator }.sum
        )
    }
}

extension Rhythm.Spelling {

    /// - Returns: The `Grouping` required to represent the tuplets in the given `tree`.
    static func makeGroups(_ tree: DurationTree) -> Rhythm.Spelling.Grouping {

        func traverse(_ tree: DurationTree, offset: Int) -> Rhythm.Spelling.Grouping {

            switch tree {
            case .leaf:
                fatalError("Ill-formed DurationTree")

            case .branch(_, let trees):

                let group = Rhythm.Spelling.Group(tree)
                let range = offset ... offset + (tree.leaves.count - 1)

                // Replace with `Tree.branches`
                let trees = trees.filter {
                    switch $0 {
                    case .leaf:
                        return false
                    case .branch:
                        return true
                    }
                }

                // Refactor this as a reduce
                var newTrees: [Rhythm.Spelling.Grouping] = []
                var subOffset = offset
                for subTree in trees {
                    newTrees.append(traverse(subTree, offset: subOffset))
                    subOffset += subTree.leaves.count
                }

                let context = Rhythm.Spelling.Group.Context(for: group, in: range)
                if newTrees.isEmpty {
                    return .leaf(context)
                } else {
                    return .branch(context, newTrees)
                }
            }
        }

        return traverse(tree, offset: 0)
    }
}

/// - Returns: The amount of dots for each of the given `durations`.
func makeDots(_ durations: [Duration]) -> [Int] {
    return durations.map(dotCount)
}

/// - Returns: The amount of dots required to render the given `duration`.
func dotCount(_ duration: Duration) -> Int {
    let beats = duration.reduced.numerator
    guard beats > 1 else { return 0 }
    let powers = powersOfTwo(upTo: beats, overshooting: true)
    let powersMinusOne = powers.map { $0 - 1 }
    for (offset,divisor) in powersMinusOne.dropFirst().enumerated() {
        if beats.isMultiple(of: divisor) { return offset + 1 }
    }
    fatalError("\(duration) is not representable with beams")
}

/// - Returns: The ties necessary to represent the given `metricalContexts`.
func makeTies <T> (_ metricalContexts: [Rhythm<T>.Context]) -> [Rhythm<T>.Spelling.Tie] {

    return metricalContexts.indices.map { index in

        let cur = metricalContexts[index]

        guard let next = metricalContexts[safe: index + 1] else {
            switch cur {
            case .continuation:
                return .stop
            default:
                return .none
            }
        }

        switch (cur, next) {
        case (.continuation, .continuation):
            return .maintain
        case (.continuation, _):
            return .stop
        case (_, .continuation):
            return .start
        default:
            return .none
        }
    }
}
