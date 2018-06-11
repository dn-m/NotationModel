//
//  Wetherfield.swift
//  PitchSpeller
//
//  Created by James Bean on 5/23/18.
//

import Pitch

/// "Namespace" for Wetherfield Pitch Speller.
public enum Wetherfield {

    /// Pitch spelling mechanism which implements the formalization proposed in Wetherfield's thesis
    /// _A Graphical Theory of Musical Pitch Spelling_.
    final class PitchSpeller {

        /// The payload for a FlowNetwork which has not yet been assigned.
        struct UnassignedNodeInfo: Hashable {

            /// The unspelled pitch class and associated identifier which will ultimately be
            /// represented.
            let item: UnspelledPitchItem

            /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
            /// `1`. This value will ultimately represent the index within a `TendencyPair`.
            let index: Int
        }

        /// The payload for a Flownetwork which has been assigned.
        struct AssignedNodeInfo: Hashable {

            /// The unspelled pitch class and associated identifier which is now representable.
            let item: UnspelledPitchItem

            /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
            /// `1`. This value will ultimately represent the index within a `TendencyPair`.
            let index: Int

            /// The "tendency" value assigned subsequent to finding the minium cut.
            let tendency: Tendency

            // MARK: - Initializers

            init(_ nodeInfo: UnassignedNodeInfo, tendency: Tendency) {
                self.item = nodeInfo.item
                self.index = nodeInfo.index
                self.tendency = tendency
            }
        }

        /// The `Pitch` values to be spelled.
        let pitches: [Pitch]

        /// The omnipresent tie-breaking pitch class
        let parsimonyPivot: Pitch.Class

        // MARK: - Initializers

        /// Create a `PitchSpeller` to spell the given `pitches`.
        init(pitches: [Pitch], parsimonyPivot: Pitch.Class) {
            self.pitches = pitches
            self.parsimonyPivot = parsimonyPivot
        }

        // MARK: - Instance Methods

        // TODO: Implement
        func flowNetwork() -> FlowNetwork<UnassignedNodeInfo> {

            // 1. Create Graph
            // 2. Create Source
            // 3. Create Sink
            // 4. Create nodes for all pitches
            // 5. Connect Source to all internal nodes
            // 6. Connect all internal nodes to all other internal nodes
            // 7. Connect all internal nodes to sink
            // 8. Create `FlowNetwork` with graph, source, and sink

            fatalError()
        }
    }
}
