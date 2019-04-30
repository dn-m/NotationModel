//
//  Wetherfield.swift
//  PitchSpeller
//
//  Created by James Bean on 5/23/18.
//

import DataStructures
import Pitch

enum FlowNode<Index>: Hashable where Index: Hashable {
    case `internal`(Index)
    case source
    case sink
}

func bind <S: Hashable, A: Hashable> (_ f: @escaping (S) -> A) -> (FlowNode<S>) -> FlowNode<A> {
    return { flowNodeS in
        switch flowNodeS {
        case .internal(let index): return .internal(f(index))
        case .source: return .source
        case .sink: return .sink
        }
    }
}

extension FlowNode where Index == Cross<Int,Tendency> {
    var tendency: Tendency {
        switch self {
        case .source: return .down
        case .sink: return .up
        case .internal(let index): return index.b
        }
    }
    var int: Int? {
        switch self {
        case .internal(let index): return index.a
        case .source, .sink: return nil
        }
    }
}

extension FlowNode where Index: Pair, Index.A == Int {
    var int: Int? {
        switch self {
        case .internal(let index): return index.a
        default: return nil
        }
    }
}

extension FlowNode where Index: Pair, Index.A == Pitch.Class {
    var pitchClass: Pitch.Class? {
        switch self {
        case .internal(let index): return index.a
        case .source, .sink: return nil
        }
    }
}

extension FlowNode where Index: Pair, Index.B == Tendency {
    var tendency: Tendency? {
        switch self {
        case .internal(let index): return index.b
        default: return nil
        }
    }
}

protocol PitchSpellingNode: Hashable {
    typealias Index = FlowNode<Cross<Int,Tendency>>
    var index: Index { get }
}

struct PitchSpeller {

    // MARK: - Instance Properties

    /// The `FlowNetwork` which will be manipulated in order to spell the unspelled `pitches`.
    var flowNetwork: FlowNetwork<PitchSpellingNode.Index,Double>

    /// The unspelled `Pitch` values to be spelled.
    let pitch: (PitchSpellingNode.Index) -> Pitch?
}

extension PitchSpeller {

    // MARK: - Nested Types

    struct UnassignedNode: PitchSpellingNode {
        let index: Index
    }

    struct AssignedNode: PitchSpellingNode {
        let index: Index
        let assignment: Tendency
        init(_ index: Index, _ assignment: Tendency) {
            self.index = index
            self.assignment = assignment
        }
    }

    struct InternalAssignedNode: Hashable {
        let index: Cross<Int, Tendency>
        let assignment: Tendency
        init(_ index: Cross<Int, Tendency>, _ assignment: Tendency) {
            self.index = index
            self.assignment = assignment
        }
    }
}

extension PitchSpeller.AssignedNode {
    
    var unassigned: PitchSpeller.UnassignedNode {
        return .init(index: index)
    }
}

extension PitchSpeller {

    // MARK: - Initializers

    /// Creates a `PitchSpeller` to spell the given `pitches`, with the given `parsimonyPivot`.
    init(pitches: [Int: Pitch], parsimonyPivot: Pitch.Spelling = .init(.d)) {
        self.flowNetwork = FlowNetwork(internalNodes: internalNodes(pitches: pitches))
        self.pitch = { index in
            switch index {
            case .source, .sink:
                return Pitch(value: parsimonyPivot.pitchClass.value)
            case .internal(let cross):
                return pitches[cross.a]
            }
        }
        
        let internalPitchClassTendency = { (cross: Cross<Int, Tendency>) in
            Cross(pitches[cross.a]!.class, cross.b)
        }
        let pitchClassTendencyGetter = bind(internalPitchClassTendency)

        let specificSourceEdges: WeightedDirectedGraphScheme<PitchSpellingNode.Index, Double> =
            sourceEdges.pullback(pitchClassTendencyGetter)
        let specificInternalEdges: WeightedDirectedGraphScheme<PitchSpellingNode.Index, Double> =
            internalEdges.pullback(pitchClassTendencyGetter)
        let specificSinkEdges: WeightedDirectedGraphScheme<PitchSpellingNode.Index, Double> =
            sinkEdges.pullback(pitchClassTendencyGetter)
        
        // All the connections that rely on pitch class specific information
        let connections: WeightedDirectedGraphScheme<PitchSpellingNode.Index, Double> =
            (connectDifferentInts * specificInternalEdges) + specificSourceEdges + specificSinkEdges
        
        // Combination of pitch class specific information and connections within each `Int` index
        // regardless of pitch class.
        let maskArgument: WeightedDirectedGraphScheme<PitchSpellingNode.Index, Double> =
            connections + bigMAssignment
        flowNetwork.mask(maskArgument)
    }
}

extension PitchSpeller {

    // MARK: - Instance Methods

    /// - Returns: An array of `SpelledPitch` values with the same indices as the original
    /// unspelled `Pitch` values.
    func spell() -> [Int: SpelledPitch] {

        var assignedNodes: [AssignedNode] {
            var (sourceSide, sinkSide) = flowNetwork.minimumCut
            sourceSide.remove(flowNetwork.source)
            sinkSide.remove(flowNetwork.sink)
            let downNodes = sourceSide.map { index in AssignedNode(index, .down) }
            let upNodes = sinkSide.map { index in AssignedNode(index, .up) }
            return downNodes + upNodes
        }
        return assignedNodes
            .compactMap { (assignedNode) -> InternalAssignedNode? in
                switch assignedNode.index {
                case .source, .sink:
                    return nil
                case .internal(let index):
                    return InternalAssignedNode(index, assignedNode.assignment)
                }
            }
            .reduce(into: [Int: (InternalAssignedNode, InternalAssignedNode)]()) { pairs, node in
                if !pairs.keys.contains(node.index.a) {
                    pairs[node.index.a] = (node, node)
                } else {
                    switch node.index.b {
                    case .up: pairs[node.index.a]!.0 = node
                    case .down: pairs[node.index.a]!.1 = node
                    }
                }
            }.mapValues(spellPitch)
    }

    private func spellPitch(
        _ up: InternalAssignedNode,
        _ down: InternalAssignedNode
    ) -> SpelledPitch
    {
        let pitch = self.pitch(.internal(up.index))!
        let tendencies = TendencyPair(up.assignment, down.assignment)
        let spelling = Pitch.Spelling(pitchClass: pitch.class, tendencies: tendencies)!
        return try! pitch.spelled(with: spelling)
    }
}

private let connectUpToDown: DirectedGraphScheme<PitchSpellingNode.Index> =
    DirectedGraphScheme<Tendency> { edge in edge.a == .up && edge.b == .down }
        .pullback { node in node.tendency }

private let bigMAdjacency: DirectedGraphScheme<PitchSpellingNode.Index> =
    connectSameInts * connectUpToDown

private let bigMAssignment: WeightedDirectedGraphScheme<PitchSpellingNode.Index, Double> =
    Double.infinity * bigMAdjacency

private let connectSameInts: GraphScheme<PitchSpellingNode.Index> =
    GraphScheme<Int?> { edge in edge.a == edge.b && edge.a != nil }.pullback { node in node.int }

private let connectDifferentInts: GraphScheme<PitchSpellingNode.Index> =
    GraphScheme<Int?> { edge in !(edge.a == edge.b && edge.a != nil) }.pullback { node in node.int }

private let sourceEdges =
    WeightedDirectedGraphScheme<FlowNode<Cross<Pitch.Class, Tendency>>, Double> { edge in
        (edge.a == .source && edge.b.tendency == .down)
            ? edge.b.pitchClass.flatMap { index in sourceEdgeLookup[index] }
            : nil
}

// Default weights:
let heavyWeight: Double = 3
let middleWeight: Double = 2
// welterWeight (if necessary)
let lightWeight: Double = 1.5
let featherWeight: Double = 1
// bantamWeight (if necessary)
let flyWeight: Double = 0.5

private let sourceEdgeLookup: [Pitch.Class: Double] = [
    00: middleWeight,
    01: heavyWeight,
    02: heavyWeight,
    03: featherWeight,
    04: heavyWeight,
    05: middleWeight,
    06: heavyWeight,
    07: heavyWeight,

    09: heavyWeight,
    10: featherWeight,
    11: heavyWeight,
]

private let sinkEdges =
    WeightedDirectedGraphScheme<FlowNode<Cross<Pitch.Class, Tendency>>, Double> { edge in
        (edge.b == .sink && edge.a.tendency == .up)
            ? edge.a.pitchClass.flatMap { index in sinkEdgeLookup[index] }
            : nil
}

private let sinkEdgeLookup: [Pitch.Class: Double] = [
    00: heavyWeight,
    01: featherWeight,
    02: middleWeight,
    03: heavyWeight,
    04: heavyWeight,
    05: heavyWeight,
    06: featherWeight,
    07: heavyWeight,
    
    09: heavyWeight,
    10: heavyWeight,
    11: middleWeight,
]

private let internalEdges: WeightedDirectedGraphScheme<FlowNode<Cross<Pitch.Class, Tendency>>, Double> =
        WeightedGraphScheme { edge in
            switch (edge.a, edge.b) {
            case (.internal(let source), .internal(let destination)):
                return internalEdgeLookup[.init(source, destination)]
            default: return nil
            }
}.directed

private let internalEdgeLookup: [UnorderedPair<Cross<Pitch.Class, Tendency>>: Double] = [
    
    // Replacement for eightTendencyLink
    .init(.init(00, .down), .init(08,   .up)): featherWeight,
    .init(.init(01,   .up), .init(08,   .up)): featherWeight,
    .init(.init(03, .down), .init(08,   .up)): featherWeight,
    .init(.init(04,   .up), .init(08,   .up)): featherWeight,
    .init(.init(05, .down), .init(08,   .up)): featherWeight,
    .init(.init(06,   .up), .init(08,   .up)): featherWeight,
    .init(.init(07, .down), .init(08,   .up)): featherWeight,
    .init(.init(08,   .up), .init(08,   .up)): featherWeight,
    .init(.init(09,   .up), .init(08,   .up)): featherWeight,
    .init(.init(10, .down), .init(08,   .up)): featherWeight,
    .init(.init(11,   .up), .init(08,   .up)): featherWeight,

    .init(.init(00, .down), .init(01,   .up)): lightWeight,
    .init(.init(00,   .up), .init(01, .down)): flyWeight,
    
    .init(.init(01, .down), .init(03,   .up)): featherWeight,
    .init(.init(01,   .up), .init(03, .down)): featherWeight,
    
    .init(.init(01, .down), .init(05,   .up)): flyWeight,
    .init(.init(01,   .up), .init(05, .down)): lightWeight
]

extension FlowNetwork where Node == PitchSpellingNode.Index, Weight == Double {

    /// Create a `FlowNetwork` which is hooked up as neccesary for the Wetherfield pitch-spelling
    /// process.
    init(internalNodes: [PitchSpellingNode.Index]) {
        self.init(source: .source, sink: .sink)
        for node in internalNodes {
            insertEdge(from: source, to: node, weight: featherWeight)
            insertEdge(from: node, to: sink, weight: featherWeight)
            for other in internalNodes.lazy.filter({ $0 != node }) {
                insertEdge(from: node, to: other, weight: featherWeight)
            }
        }
    }

    /// Creates an empty `FlowNetwork` ready to be used incrementally constructed for the purposes
    /// of pitch spelling.
    init() {
        self.source = .source
        self.sink = .sink
        self.nodes = []
        self.weights = [:]
    }
}

/// - Returns: An array of nodes, each representing the index of the unassigned node in
/// `pitchNodes`.
private func internalNodes(pitches: [Int: Pitch]) -> [PitchSpellingNode.Index] {
    return pitches.keys.flatMap { offset in [.down,.up].map { index in node(offset, index) } }
}

/// - Returns: The value of a node at the given offset (index of a `Pitch` within `pitches`),
/// and an index (either `0` or `1`, which of the two nodes in the `FlowNetwork` that represent
/// the given `Pitch`.)
private func node(_ offset: Int, _ index: Tendency) -> PitchSpellingNode.Index {
    return .internal(.init(offset, index))
}

extension FlowNode: CustomStringConvertible {

    // MARK: - CustomStringConvertible

    /// Printable description of `FlowNode`.
    public var description: String {
        switch self {
        case .source:
            return "source"
        case .sink:
            return "sink"
        case .internal(let index):
            return "\(index)"
        }
    }
}
