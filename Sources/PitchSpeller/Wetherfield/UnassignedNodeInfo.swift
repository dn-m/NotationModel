//
//  UnassignedNodeInfo.swift
//  PitchSpeller
//
//  Created by James Bean on 6/13/18.
//

/// The payload for a FlowNetwork which has not yet been assigned.
struct UnassignedNodeInfo: Hashable {

    /// The unspelled pitch class and associated identifier which will ultimately be
    /// represented.
    let item: UnspelledPitchItem

    /// Index of the node in the `Box` for the given `pitchClass`. Will be either `0`, or
    /// `1`. This value will ultimately represent the index within a `TendencyPair`.
    let index: Index

    /// - Returns: An `AssignedNodeInfo` with the given `tendency` applied to `self`.
    func assigning(tendency: Tendency) -> AssignedNodeInfo {
        return AssignedNodeInfo(self, tendency: tendency)
    }
}
