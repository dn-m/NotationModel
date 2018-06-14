//
//  AssignedNodeInfo.swift
//  PitchSpeller
//
//  Created by James Bean on 6/13/18.
//

/// The payload for a Flownetwork which has been assigned.
struct AssignedNodeInfo: Hashable {

    /// The unspelled pitch class and associated identifier which is now representable.
    let item: UnspelledPitchItem

    /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
    /// `1`. This value will ultimately represent the index within a `TendencyPair`.
    let index: Index

    /// The "tendency" value assigned subsequent to finding the minium cut.
    let tendency: Tendency

    // MARK: - Initializers

    init(_ nodeInfo: UnassignedNodeInfo, tendency: Tendency) {
        self.item = nodeInfo.item
        self.index = nodeInfo.index
        self.tendency = tendency
    }
}
