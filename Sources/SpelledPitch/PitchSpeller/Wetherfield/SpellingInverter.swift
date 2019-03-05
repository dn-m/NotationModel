//
//  SpellingInverter.swift
//  SpelledPitch
//
//  Created by Benjamin Wetherfield on 2/14/19.
//

import DataStructures
import Pitch

struct SpellingInverter {
    
    // The `Tendency` `DirectedGraph` which stands in for the `FlowNetwork` that
    // would solve to the set of spellings passed into the `SpellingInverter`.
    var flowNetwork: DirectedGraph<FlowNode<PitchSpeller.InternalAssignedNode>>
    
    let pitchSpelling: (PitchSpellingNode.Index) -> Pitch.Spelling?
}

extension SpellingInverter {
    init(spellings: [Int: Pitch.Spelling], parsimonyPivot: Pitch.Spelling = .init(.d)) {
        self.flowNetwork = DirectedGraph(internalNodes: internalNodes(spellings: spellings))
        self.pitchSpelling = { index in
            switch index {
            case .source, .sink:
                return parsimonyPivot
            case .internal(let cross):
                return spellings[cross.a]
            }
        }
    }
}

/// - Returns: Index and assignment of all internal nodes of the `flowNetwork`.
private func internalNodes(spellings: [Int: Pitch.Spelling]) -> [PitchSpeller.InternalAssignedNode] {
    return spellings.map {
        let (offset,pitchSpelling) = $0
        return [.down,.up].map { index in node(offset, index, pitchSpelling) }
        }.reduce([]) { (result: [PitchSpeller.InternalAssignedNode],
            element: [PitchSpeller.InternalAssignedNode]) -> [PitchSpeller.InternalAssignedNode] in
            return result + element
        }
}

/// - Returns: The value of a node at the given offset (index of a `Pitch.Spelling` within `spellings`),
/// and an index (either `0` or `1`, which of the two nodes in the `FlowNetwork` that represent
/// the given `Pitch.Spelling`.)
private func node(_ offset: Int, _ index: Tendency, _ pitchSpelling: Pitch.Spelling) -> PitchSpeller.InternalAssignedNode {
    let pitchCategory = Pitch.Spelling.Category.category(
        for: pitchSpelling.pitchClass
        )!
    let direction = pitchCategory.directionToModifier[value: pitchSpelling.modifier]!
    let tendencies = pitchCategory.tendenciesToDirection[value: direction]!
    return .init(.init(offset, index), index == .up ? tendencies.a : tendencies.b)
}

extension DirectedGraph where Node == FlowNode<PitchSpeller.InternalAssignedNode> {
    
    /// Create a `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
    /// process.
    init(internalNodes: [PitchSpeller.InternalAssignedNode]) {
        self.init()
        self.insert(.source)
        self.insert(.sink)
        for node in internalNodes {
            insertEdge(from: .source, to: .internal(node))
            insertEdge(from: .internal(node), to: .sink)
            for other in internalNodes.lazy.filter({ $0 != node }) {
                insertEdge(from: .internal(node), to: .internal(other))
            }
        }
    }
}

extension DirectedGraph where Node == FlowNode<PitchSpeller.InternalAssignedNode> {
    
    /// - Returns: For each `Edge`, a `Set` of `Edge` values, the sum of whose weights, the edge's weight
    /// must be greater than for the inverse spelling procedure to be valid.
    var weightDependencies: [Edge: Set<Edge>] {
        var residualNetwork = self
        var weightDependencies: [Edge: Set<Edge>] = [:]
        
        while let augmentingPath = residualNetwork.shortestUnweightedPath(from: .source, to: .sink) {
            let preCutIndex = augmentingPath.lastIndex { node in
                switch node {
                case .source: return true
                case .sink: return false
                case .internal(let internalNode): return internalNode.assignment == .down
                }
            }!
            let cutEdge = Edge(augmentingPath[preCutIndex], augmentingPath[preCutIndex+1])
            for edge in augmentingPath.pairs.map(Edge.init) where edge != cutEdge {
                weightDependencies[edge]!.insert(cutEdge)
            }
            residualNetwork.remove(cutEdge)
            residualNetwork.insertEdge(from: cutEdge.b, to: cutEdge.a)
        }
        
        return weightDependencies
    }
    
    /// - Returns: A concrete distribution of weights to satisfy the weight relationships delimited by
    /// `weightDependencies`.
    var weights: [Edge: Double] {
        func dependeciesReducer (
            _ weights: inout [Edge: Double],
            _ dependency: (key: Edge, value: Set<Edge>)
            ) {
            
            func recursiveReducer (
                _ weights: inout [Edge: Double],
                _ dependency: (key: Edge, value: Set<Edge>)
                ) -> Double {
                return dependency.value.reduce(1.0) { result, edge in
                    guard let dependencies = weightDependencies[edge] else { return result }
                    if dependencies.isEmpty {
                        return result
                    } else {
                        return result + recursiveReducer(&weights, (key: edge, value: dependencies))
                    }
                }
            }
            
            let _ = recursiveReducer(&weights, dependency)
        }
        
        return weightDependencies.reduce(into: [Edge: Double](), dependeciesReducer)
    }
    
    func contains(_ indexing: (index: Int, offset: Tendency), _ assignment: Tendency) -> Bool {
        return contains(
            .internal(
                PitchSpeller.InternalAssignedNode(
                    Cross(indexing.index, indexing.offset),
                    assignment
                )
            )
        )
    }
}
