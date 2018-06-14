//
//  AssignedNodeInfo.swift
//  PitchSpeller
//
//  Created by James Bean on 6/13/18.
//

/// The payload for a Flownetwork which has been assigned.
struct AssignedNodeInfo: Hashable {

    /// The offset of the `Pitch` that is being spelled in the original input array.
    let offset: Int

    /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
    /// `1`. This value will ultimately represent the index within a `TendencyPair`.
    let index: Int

    /// The "tendency" value assigned subsequent to finding the minium cut.
    let tendency: Tendency

    // MARK: - Initializers

    init(_ nodeInfo: UnassignedNodeInfo, tendency: Tendency) {
        self.offset = nodeInfo.offset
        self.index = nodeInfo.index
        self.tendency = tendency
    }
}
