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
    var flowNetwork: DirectedGraph<PitchSpeller.AssignedNode>
    
    let pitchSpelling: (PitchSpellingNode.Index) -> Pitch.Spelling?
    
    typealias AssignedEdge = OrderedPair<PitchSpeller.AssignedNode>
    typealias UnassignedEdge = OrderedPair<PitchSpeller.UnassignedNode>
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
private func internalNodes(spellings: [Int: Pitch.Spelling]) -> [PitchSpeller.AssignedNode] {
    return spellings.map {
        let (offset,pitchSpelling) = $0
        return [.down,.up].map { index in node(offset, index, pitchSpelling) }
        }.reduce([]) { (result: [PitchSpeller.AssignedNode],
            element: [PitchSpeller.AssignedNode]) -> [PitchSpeller.AssignedNode] in
            return result + element
        }
}

/// - Returns: The value of a node at the given offset (index of a `Pitch.Spelling` within `spellings`),
/// and an index (either `0` or `1`, which of the two nodes in the `FlowNetwork` that represent
/// the given `Pitch.Spelling`.)
private func node(_ offset: Int, _ index: Tendency, _ pitchSpelling: Pitch.Spelling) -> PitchSpeller.AssignedNode {
    let pitchCategory = Pitch.Spelling.Category.category(
        for: pitchSpelling.pitchClass
        )!
    let direction = pitchCategory.directionToModifier[value: pitchSpelling.modifier]!
    let tendencies = pitchCategory.tendenciesToDirection[value: direction]!
    return .init(.internal(.init(offset, index)), index == .up ? tendencies.a : tendencies.b)
//    return .init(.init(offset, index), index == .up ? tendencies.a : tendencies.b)
}

extension DirectedGraph where Node == PitchSpeller.AssignedNode {
    
    /// Create a `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
    /// process.
    init(internalNodes: [PitchSpeller.AssignedNode]) {
        self.init()
        let source = PitchSpeller.AssignedNode(.source, .down)
        let sink = PitchSpeller.AssignedNode(.sink, .up)
        self.insert(source)
        self.insert(sink)
        internalNodes.lazy.filter { node in
            switch node.index {
            case .source, .sink: return false
            case .internal(let index): return index.b == .down
            }
            }.forEach { node in
                insertEdge(from: source, to: node)
                internalNodes.lazy.filter { other in
                    switch other.index {
                    case .source, .sink: return false
                    case .internal(let otherIndex): return other != node && otherIndex.b == .down
                    }
                    }.forEach { other in
                        insertEdge(from: node, to: other)
            }
        }
        internalNodes.lazy.filter { node in
            switch node.index {
            case .source, .sink: return false
            case .internal(let index): return index.b == .up
            }
            }.forEach { node in
                insertEdge(from: node, to: sink)
                insertEdge(from: node, to: internalNodes.first { downVersion in
                    downVersion != node && downVersion.index.int! == node.index.int!
                }!)
                internalNodes.lazy.filter { other in
                    switch other.index {
                    case .source, .sink: return false
                    case .internal(let otherIndex): return other != node && otherIndex.b == .up
                    }
                    }.forEach { other in
                        insertEdge(from: node, to: other)
                }
        }
    }
}

extension SpellingInverter {
    
    /// - Returns: For each `Edge`, a `Set` of `Edge` values, the sum of whose weights, the edge's weight
    /// must be greater than for the inverse spelling procedure to be valid.
    var weightDependencies: [UnassignedEdge: Set<UnassignedEdge>] {
        var residualNetwork = flowNetwork
        var weightDependencies: [UnassignedEdge: Set<UnassignedEdge>] = flowNetwork.edges.lazy
            .map { UnassignedEdge($0.a.unassigned, $0.b.unassigned) }
            .reduce(into: [UnassignedEdge: Set<UnassignedEdge>]()) { dependencies, edge in
                dependencies[edge] = []
        }

        let source = PitchSpeller.AssignedNode(.source, .down)
        let sink = PitchSpeller.AssignedNode(.sink, .up)
        while let augmentingPath = residualNetwork.shortestUnweightedPath(from: source, to: sink) {
            let preCutIndex = augmentingPath.lastIndex { $0.assignment == .down }!
            let cutEdge = AssignedEdge(augmentingPath[preCutIndex], augmentingPath[preCutIndex+1])
            for edge in augmentingPath.pairs.map(AssignedEdge.init) where edge != cutEdge {
                weightDependencies[UnassignedEdge(edge.a.unassigned, edge.b.unassigned)]!.insert(
                    UnassignedEdge(cutEdge.a.unassigned, cutEdge.b.unassigned)
                )
            }
            residualNetwork.remove(cutEdge)
            residualNetwork.insertEdge(from: cutEdge.b, to: cutEdge.a)
        }
        
        return weightDependencies
    }
    
    /// - Returns: A concrete distribution of weights to satisfy the weight relationships delimited by
    /// `weightDependencies`.
    var weights: [UnassignedEdge: Double] {
        func dependeciesReducer (
            _ weights: inout [UnassignedEdge: Double],
            _ dependency: (key: UnassignedEdge, value: Set<UnassignedEdge>)
            ) {
            
            func recursiveReducer (
                _ weights: inout [UnassignedEdge: Double],
                _ dependency: (key: UnassignedEdge, value: Set<UnassignedEdge>)
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
        
        return weightDependencies.reduce(into: [UnassignedEdge: Double](), dependeciesReducer)
    }
    
    func contains(_ indexing: (index: Int, offset: Tendency), _ assignment: Tendency) -> Bool {
        return flowNetwork.contains(
            PitchSpeller.AssignedNode(.internal(Cross(indexing.index, indexing.offset)), assignment)
        )
    }
    
    func containsEdge(
        from source: (index: Int, offset: Tendency),
        to destination: (index: Int, offset: Tendency)
        ) -> Bool {
        return [(.up,.up),(.up,.down),(.down,.down)].reduce(false) {
            (accumulating: Bool, next: (Tendency, Tendency)) -> Bool in
            accumulating || containsEdge(from: (source.index, source.offset, next.0),
                                         to: (destination.index, destination.offset, next.1)
            )
        }
    }
    
    func containsEdge(
        from source: (index: Int, offset: Tendency, assignment: Tendency),
        to destination: (index: Int, offset: Tendency, assignment: Tendency)
        ) -> Bool {
        return flowNetwork.containsEdge(
            from: PitchSpeller.AssignedNode(
                .internal(Cross(source.index, source.offset)), source.assignment
            ),
            to: PitchSpeller.AssignedNode(
                .internal(Cross(destination.index, destination.offset)), destination.assignment
            )
            )
    }
    
    func containsSourceEdge(
        to destination: (index: Int, offset: Tendency)
        ) -> Bool {
        return [.up, .down].reduce(false) {
            (accumulating: Bool, next: Tendency) -> Bool in
            accumulating || containsSourceEdge(
                from: .down,
                to: (destination.index, destination.offset, next)
            )
        }
    }
    
    func containsSinkEdge(
        from source: (index: Int, offset: Tendency)
        ) -> Bool {
        return [.up, .down].reduce(false) {
            (accumulating: Bool, next: Tendency) -> Bool in
            accumulating || containsSinkEdge(
                from: (source.index, source.offset, next),
                to: .up
            )
        }
    }
    
    func containsSourceEdge(
        from sourceTendency: Tendency,
        to destination: (index: Int, offset: Tendency, assignment: Tendency)
        ) -> Bool {
        return flowNetwork.containsEdge(
            from: PitchSpeller.AssignedNode(.source, sourceTendency),
            to: PitchSpeller.AssignedNode(
                .internal(Cross(destination.index, destination.offset)), destination.assignment
        )
        )
    }
    
    func containsSinkEdge(
        from source: (index: Int, offset: Tendency, assignment: Tendency),
        to destinationTendency: Tendency
        ) -> Bool {
        return flowNetwork.containsEdge(
            from: PitchSpeller.AssignedNode(
                .internal(Cross(source.index, source.offset)), source.assignment
            ),
            to: PitchSpeller.AssignedNode(.sink, destinationTendency)
        )
    }
}
