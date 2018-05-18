//
//  Group.swift
//  RhythmSpellingTools
//
//  Created by James Bean on 2/13/17.
//
//

import DataStructures
import MetricalDuration
import Rhythm

public typealias Grouping = Tree<Group.Context,Group.Context>

/// Information necessary to render a tuplet bracket.
public struct Group {
    
    /// `Group` in context, applying to the indices of the leaves to which it applies.
    public struct Context {
        
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

extension Group {
    
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

extension Group: Equatable {
    
    public static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.duration == rhs.duration && lhs.contentsSum == rhs.contentsSum
    }
}

extension Group: CustomStringConvertible {
    
    public var description: String {
        return "\(contentsSum):\(duration)"
    }
}

extension Group.Context {
    
    public static func == (lhs: Group.Context, rhs: Group.Context) -> Bool {
        return lhs.group == rhs.group && lhs.leafRange == rhs.leafRange
    }
}
