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

extension SpellingInverter {
    
    // Produces weights that would yield the `Pitch.Spelling` values that were passed in
    // if just the `Pitch` values were solved for using a `PitchSpeller` with said weights
    func getWeights () -> [OrderedPair<Int>: Double] {
        return [:]
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
    return .init(.init(offset, index), index == .down ? tendencies.a : tendencies.b)
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
