//
//  RhythmSpelling.swift
//  RhythmSpellingTools
//
//  Created by James Bean on 2/13/17.
//
//

import func Math.countTrailingZeros
import StructureWrapping
import DataStructures
import MetricalDuration
import Rhythm

// FIXME: Rename as extension of `Rhythm`.
public struct RhythmSpelling {
    
    // MARK: - Nested Types
    
    /// Context for a single event in a `RhythmSpelling`.
    public struct Item {
        
        /// The actions necessary to render beams.
        public let beamJunction: BeamJunction
        
        /// The actions necessary to render ties.
        public let tieState: TieState
        
        /// The amount of dots necessary to represent duration.
        public let dots: Int
    }
    
    // MARK: - Instance Properties
    
    /// `RhythmSpelling.Item` values for each leaf.
    fileprivate let items: [Item]
    
    /// `Tree` structure which contains `Group` information, along with its span in terms of
    /// indices of leaves.
    fileprivate let groups: Grouping
    
    // MARK: - Initializers
    
    /// Creates a `RhythmSpelling` with the given `items`, and `groups`.
    public init(items: [Item], groups: Grouping) {
        self.items = items
        self.groups = groups
    }
    
    /// Creates a `RhythmSpelling` with the given `rhythmTree`.
    ///
    /// - TODO: Add ability to inject customized beaming algorithm.
    /// - Note: Currently, there is a default beaming algorithm which is not customizable.
    // FIXME: Move to RhythmBeamer
    public init(_ rhythm: Rhythm<Int>) {
        let leaves = rhythm.metricalDurationTree.leaves
        let junctions = makeJunctions(leaves)
        let tieStates = makeTieStates(rhythm.leaves.map { $0.context })
        let dots = leaves.map(dotCount)
        let items = zip(junctions, tieStates, dots).map(Item.init)
        let groups = makeGroups(rhythm.metricalDurationTree)
        self.init(items: items, groups: groups)
    }
    
    /// Creates a `RhythmSpelling` with the given `metricalDurationTree`, mapping generic 
    /// events as leaf contexts.
    public init(_ metricalDurationTree: MetricalDurationTree) {
        
        let contexts = metricalDurationTree.leaves.map {
            _ in MetricalContext.instance(.event(0))
        }
        
        let rhythmTree = Rhythm(metricalDurationTree, contexts)
        self.init(rhythmTree)
    }
}

extension RhythmSpelling: CollectionWrapping {
    
    public var base: [Item] {
        return items
    }
}

extension RhythmSpelling.Item: Equatable { }
extension RhythmSpelling: Equatable { }

extension RhythmSpelling: CustomStringConvertible {
    
    // MARK: - CustomStringConvertible
    
    /// Printed description.
    public var description: String {
        return items.description
    }
}

/// - returns: The amount of dots required to render the given `duration`.
internal func dotCount(_ duration: MetricalDuration) -> Int {

    let beats = duration.reduced.numerator
    
    guard [1,3,7].contains(beats) else {
        fatalError("Unsanitary duration for beamed representation: \(beats)")
    }
    
    return beats == 3 ? 1 : beats == 7 ? 2 : 0
}

/// - returns: An array of `BeamJunction` values for the given `counts` (amounts of beams).
internal func makeJunctions(_ counts: [Int]) -> [RhythmSpelling.BeamJunction] {
    
    return counts.indices.map { index in
        
        let prev = counts[safe: index - 1]
        let cur = counts[index]
        let next = counts[safe: index + 1]
        
        return RhythmSpelling.BeamJunction(prev, cur, next)
    }
}

internal func makeGroups(_ tree: MetricalDurationTree) -> Grouping {
    
    func traverse(_ tree: MetricalDurationTree, offset: Int) -> Grouping {
        
        switch tree {
        case .leaf:
            fatalError("Ill-formed MetricalDurationTree")
            
        case .branch(_, let trees):
            
            let group = Group(tree)
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
            var newTrees: [Grouping] = []
            var subOffset = offset
            for subTree in trees {
                newTrees.append(traverse(subTree, offset: subOffset))
                subOffset += subTree.leaves.count
            }
            
            let context = Group.Context(for: group, in: range)
            if newTrees.isEmpty {
                return .leaf(context)
            } else {
                return .branch(context, newTrees)
            }
        }
    }
    
    return traverse(tree, offset: 0)
}

/// - returns: An array of `BeamJunction` values for the given `leaves`.
//
// FIXME: Move to RhythmBeamer
internal func makeJunctions(_ leaves: [MetricalDuration]) -> [RhythmSpelling.BeamJunction] {
    return makeJunctions(leaves.map(beamCount))
}

/// - returns: Amount of beams needed to represent the given `duration`.
//
// FIXME: Move to RhythmBeamer
internal func beamCount(_ duration: MetricalDuration) -> Int {
    
    let reduced = duration.reduced
    
    guard [1,3,7].contains(reduced.numerator) else {
        fatalError("Unsanitary duration for beamed representation: \(reduced)")
    }
    
    let subdivisionCount = countTrailingZeros(reduced.denominator) - 2
    
    if reduced.numerator.isDivisible(by: 3) {
        return subdivisionCount - 1
    } else if reduced.numerator.isDivisible(by: 7) {
        return subdivisionCount - 2
    }
    
    return subdivisionCount
}

/// - returns: The `TieState` values necessary to render the given `MetricalContext` values.
//
// FIXME: Move to RhythmBeamer
internal func makeTieStates <T> (_ metricalContexts: [MetricalContext<T>])
    -> [RhythmSpelling.TieState]
{
    
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
