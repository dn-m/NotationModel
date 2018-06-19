//
//  Rhythm.Spelling.swift
//  SpelledRhythm
//
//  Created by James Bean on 6/18/18.
//

import DataStructures
import StructureWrapping
import MetricalDuration
import Rhythm

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

                /// Creates a `Group.Context` with the given `group` for the given `range` of leaf
                /// indices.
                public init(for group: Group, in range: CountableClosedRange<Int>) {
                    self.group = group
                    self.leafRange = range
                }
            }

            // MARK: - Instance Properties

            /// `MetricalDuration` of a `Group`.
            public let duration: MetricalDuration

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
            let beamItem: Beaming.Item
            let tie: Tie
            let dots: Int
        }

        /// All of the information needed to abstractly represent all of the metrical instances
        /// within a single `Rhythm`.
        let items: [Item]
    }
}

extension Rhythm.Spelling: CollectionWrapping {
    public var base: [Item] {
        return items
    }
}

extension Rhythm.Spelling.Group: CustomStringConvertible {
    public var description: String {
        return "\(contentsSum):\(duration)"
    }
}

extension Rhythm.Spelling.Group {

    /// Creates a `Group` for the given `metricalDurationTree`.
    public init(_ metricalDurationTree: MetricalDurationTree) {

        guard case .branch(let duration, let trees) = metricalDurationTree else {
            fatalError("Ill-formed MetricalDurationTree!")
        }

        self.init(
            duration: duration,
            contentsSum: trees.map { $0.value.numerator }.sum
        )
    }
}

extension Rhythm.Spelling {

    static func makeGroups(_ tree: MetricalDurationTree) -> Rhythm.Spelling.Grouping {

        func traverse(_ tree: MetricalDurationTree, offset: Int) -> Rhythm.Spelling.Grouping {

            switch tree {
            case .leaf:
                fatalError("Ill-formed MetricalDurationTree")

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

func makeTieStates <T> (_ metricalContexts: [MetricalContext<T>]) -> [Rhythm<T>.Spelling.Tie] {

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
