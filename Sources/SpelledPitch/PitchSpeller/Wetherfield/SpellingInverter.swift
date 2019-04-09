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
    typealias PitchedEdge = UnorderedPair<FlowNode<Cross<Pitch.Class,Tendency>>>
    
    let pitchClass: (Int) -> Pitch.Class?
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
        self.pitchClass = { int in spellings[int]?.pitchClass }
        
        let specificEdgeScheme: DirectedGraphScheme<PitchSpeller.UnassignedNode> = (upDownEdgeScheme.pullback(nodeMapper) + sameEdgeScheme.pullback(nodeMapper))
        * connectDifferentInts
        
        let sameIntEdgesScheme: DirectedGraphScheme<PitchSpeller.UnassignedNode> =
            sameIntsScheme * connectSameInts
        
        let specificSourceScheme: DirectedGraphScheme<PitchSpeller.UnassignedNode> =
            sourceEdgeLookupScheme.pullback(nodeMapper)
        
        let specificSinkScheme: DirectedGraphScheme<PitchSpeller.UnassignedNode> =
            sourceEdgeLookupScheme.pullback(nodeMapper)
        
        let maskScheme: DirectedGraphScheme<PitchSpeller.AssignedNode> =
            [specificEdgeScheme, sameIntEdgesScheme, specificSourceScheme, specificSinkScheme].reduce(DirectedGraphScheme { _ in false }, +)
                .pullback({ $0.unassigned })
        
        self.flowNetwork.mask(maskScheme)
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

extension DirectedGraph where Node == PitchSpeller.AssignedNode {
    
    /// Create a `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
    /// process.
    init(internalNodes: [PitchSpeller.InternalAssignedNode]) {
        self.init()
        let source = PitchSpeller.AssignedNode(.source, .down)
        let sink = PitchSpeller.AssignedNode(.sink, .up)
        self.insert(source)
        self.insert(sink)
        
        var mapInternal: (PitchSpeller.InternalAssignedNode) -> PitchSpeller.AssignedNode {
            return { .init(.internal($0.index), $0.assignment) }
        }
        
        for internalNode in internalNodes {
            let node = mapInternal(internalNode)
            insert(node)
            insertEdge(from: source, to: node)
            insertEdge(from: node, to: sink)
            for otherInternalNode in internalNodes where otherInternalNode != internalNode {
                let other = mapInternal(otherInternalNode)
                insertEdge(from: node, to: other)
            }
        }
    }
    
    mutating func mask <Scheme: UnweightedGraphSchemeProtocol> (_ adjacencyScheme: Scheme) where
        Scheme.Node == Node
    {
        for edge in edges where !adjacencyScheme.containsEdge(from: edge.a, to: edge.b) {
            remove(edge)
        }
    }
}

extension SpellingInverter {
    
    /// - Returns: A concrete distribution of weights to satisfy the weight relationships delimited by
    /// `weightDependencies`.
    var weights: [PitchedEdge: Double] {
        func dependeciesReducer (
            _ weights: inout [PitchedEdge: Double],
            _ dependency: (key: PitchedEdge, value: Set<PitchedEdge>)
            ) {
            
            func recursiveReducer (
                _ weights: inout [PitchedEdge: Double],
                _ dependency: (key: PitchedEdge, value: Set<PitchedEdge>)
                ) -> Double {
                return dependency.value.reduce(1.0) { result, edge in
                    if weights[edge] != nil { return weights[edge]! }
                    guard let dependencies = pitchedDependencies[edge] else { return result }
                    let edge = dependency.key
                    if dependencies.isEmpty {
                        weights[edge] = result
                        return result
                    } else {
                        let result = result + recursiveReducer(&weights, (key: edge, value: dependencies))
                        weights[edge] = result
                        return result
                    }
                }
            }
            
            let _ = recursiveReducer(&weights, dependency)
        }
        
        return pitchedDependencies.reduce(
            into: [PitchedEdge: Double](), dependeciesReducer)
    }
    
    var pitchClassMapper: (Cross<Int,Tendency>) -> Cross<Pitch.Class, Tendency> {
        return { input in
            Cross<Pitch.Class, Tendency>(self.pitchClass(input.a)!, input.b)
        }
    }
    
    var flowNodeMapper: (FlowNode<Cross<Int,Tendency>>) -> FlowNode<Cross<Pitch.Class,Tendency>> {
        return bind(pitchClassMapper)
    }
    
    var nodeMapper: (PitchSpeller.UnassignedNode) -> FlowNode<Cross<Pitch.Class,Tendency>> {
        return { self.flowNodeMapper($0.index) }
    }
    
    var pairMapper: (UnassignedEdge) -> PitchedEdge {
        return { pair in
            .init(self.nodeMapper(pair.a), self.nodeMapper(pair.b))
        }
    }
    
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
    
    /// - Returns: For each `Edge`, a `Set` of `Edge` values, the sum of whose weights, the edge's weight
    /// must be greater than for the inverse spelling procedure to be valid.
    var pitchedDependencies: [PitchedEdge: Set<PitchedEdge>] {
        var residualNetwork = flowNetwork
        var weightDependencies: [PitchedEdge: Set<PitchedEdge>] = flowNetwork.edges.lazy
                .map { .init(self.nodeMapper($0.a.unassigned), self.nodeMapper($0.b.unassigned)) }
                .reduce(into: [PitchedEdge: Set<PitchedEdge>]()) { dependencies, edge in
                dependencies[edge] = []
        }
        
        let source = PitchSpeller.AssignedNode(.source, .down)
        let sink = PitchSpeller.AssignedNode(.sink, .up)
        while let augmentingPath = residualNetwork.shortestUnweightedPath(from: source, to: sink) {
            let preCutIndex = augmentingPath.lastIndex { $0.assignment == .down }!
            let cutEdge = AssignedEdge(augmentingPath[preCutIndex], augmentingPath[preCutIndex+1])
            for edge in augmentingPath.pairs.map(AssignedEdge.init) where edge != cutEdge {
                weightDependencies[PitchedEdge(
                    self.nodeMapper(edge.a.unassigned),
                    self.nodeMapper(edge.b.unassigned))
                    ]!.insert(PitchedEdge(
                        self.nodeMapper(cutEdge.a.unassigned),
                        self.nodeMapper(cutEdge.b.unassigned)
                        )
                )
            }
            residualNetwork.remove(cutEdge)
            residualNetwork.insertEdge(from: cutEdge.b, to: cutEdge.a)
        }
        
        return weightDependencies
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

private let sameIntsScheme: DirectedGraphScheme<PitchSpeller.UnassignedNode> =
    DirectedGraphScheme<Tendency?> {edge in edge.a == .up && edge.b == .down }
        .pullback { node in node.index.tendency}

private let sourceEdgeLookupScheme: DirectedGraphScheme<FlowNode<Cross<Pitch.Class, Tendency>>> =
    DirectedGraphScheme<FlowNode<Pitch.Class>> { edge in
        edge.a == .source && edge.b != .internal(8)
        }.pullback(bind({ (cross: Cross<Pitch.Class, Tendency>) -> Pitch.Class in cross.a }))
    * DirectedGraphScheme<FlowNode<Tendency>> { edge in
        edge.a == .source && edge.b == .internal(.down)
        }.pullback(bind ({ cross in cross.b }))

private let sinkEdgeLookupScheme: DirectedGraphScheme<FlowNode<Cross<Pitch.Class, Tendency>>> =
    DirectedGraphScheme<FlowNode<Pitch.Class>> { edge in
        edge.a != .internal(8) && edge.b == .sink
        }.pullback(bind({ (cross: Cross<Pitch.Class, Tendency>) -> Pitch.Class in cross.a }))
    * DirectedGraphScheme<FlowNode<Tendency>> { edge in
        edge.a == .internal(.up) && edge.b == .sink
        }.pullback(bind ({ cross in cross.b }))

private let connectSameInts: GraphScheme<PitchSpeller.UnassignedNode> =
    GraphScheme<Int?> { edge in edge.a == edge.b && edge.a != nil }.pullback { node in node.index.int }

private let connectDifferentInts: GraphScheme<PitchSpeller.UnassignedNode> =
    GraphScheme<Int?> { edge in !(edge.a == edge.b && edge.a != nil) }.pullback { node in node.index.int }

private let upDownEdgeScheme: DirectedGraphScheme<FlowNode<Cross<Pitch.Class, Tendency>>> =
    GraphScheme { edge in
        switch (edge.a, edge.b) {
        case (.internal(let source), .internal(let destination)):
            return source.b != destination.b && upDownEdgeLookup.contains(.init(source.a, destination.a))
        default: return false
        }
        }.directed

private let sameEdgeScheme: DirectedGraphScheme<FlowNode<Cross<Pitch.Class, Tendency>>> =
    GraphScheme { edge in
        switch (edge.a, edge.b) {
        case (.internal(let source), .internal(let destination)):
            return source.b == destination.b && !upDownEdgeLookup.contains(.init(source.a, destination.a))
        default: return false
        }
        }.directed

private let upDownEdgeLookup: [UnorderedPair<Pitch.Class>] = [
    .init(00, 01),
    .init(00, 04),
    .init(00, 08),
    .init(01, 03),
    .init(01, 05),
    .init(01, 09),
    .init(03, 04),
    .init(03, 06),
    .init(03, 08),
    .init(03, 11),
    .init(04, 05),
    .init(05, 06),
    .init(05, 08),
    .init(05, 11),
    .init(06, 09),
    .init(07, 08),
    .init(08, 10),
    .init(10, 11)
    ]
