//
//  PitchClassSetSpeller.swift
//  SpelledPitch
//
//  Created by James Bean on 8/24/16.
//
//

/*
import Collections
import Pitch

/// Defintion of a spelling rule that takes a cost multiplier and an input, returning a cost.
///
/// The cost multiplier can be used within the closure to worsen the penalty depending on 
/// more or less egregious offences.
///
/// The `Input` can be any of the following:
/// - `Node` (aka `PitchSpelling`)
/// - `Edge` (aka `(PitchSpelling, PitchSpelling)`)
/// - `Graph` (aka `[PitchSpelling]`)
//typealias Rule<Input> = (Float) -> (Input) -> Float

// MARK: - Rule collections

// Rules for individual spellings out of context
let nodeRules: [(Node) -> Float] = [
    doubleSharpOrDoubleFlat(1),
    badEnharmonic(1),
    quarterStepEighthStepCombination(1),
    threeQuarterSharpOrThreeQuarterFlat(1),
]

// Rules for which n-jeopardy may be applied
let edgeRules: [(Edge) -> Float] = [
    unison(1.0),
    augmentedOrDiminished(1.0),
    crossover(1.0),
    flatSharpIncompatibility(1.0)
]

// Rules for which double-jeopardy is not applied
let graphRules: [(Edge) -> Float] = [
    eighthStepDirectionIncompatibility(1.0)
]

// MARK: - Cost functions

// Node cost
func cost<A>(_ a: A, _ rules: [(A) -> Float]) -> Float {
    return rules.reduce(0) { $0 + $1(a) }
}

/// Cost of a single spelling in relationship to all of the other nodes in a graph
func cost(_ a: Node, _ graph: Graph, _ rules: [(Edge) -> Float]) -> Float {
    return graph.reduce(0) { $0 + cost((a,$1), rules) }
}

/// Graph cost (no double jeopardy applied)
func cost(_ graph: Graph, _ rules: [(Edge) -> Float]) -> Float {
    for ai in graph.indices {
        let a = graph[ai]
        for bi in ai + 1 ..< graph.endIndex {
            let b = graph[bi]
            let cost = rules.reduce(0) { $0 + $1(a,b) }
            if cost > 0 { return cost }
        }
    }
    return 0
}

public struct PitchClassSetSpeller {

    enum CostError: Error { case thresholdExceeded }
    
    struct SpellingContext {
        let spelling: PitchSpelling
        let totalCost: Float
        let nodeEdgeCost: Float
    }
    
    private let costThreshold: Float
    private var bestGraphs: [Graph] = []
    private let pitchClassSet: PitchClassSet
    
    // make an optional init for rules
    public init(_ pitchClassSet: PitchClassSet, costThreshold: Float = 100) {
        self.pitchClassSet = pitchClassSet
        self.costThreshold = costThreshold
    }
    
    public func spell() -> SpelledPitchClassSet {
        
        func traverseToSpell(
            _ pitchClasses: [PitchClass],
            graph: Graph,
            totalCost: Float,
            nodeEdgeCost: Float
        ) -> SpelledPitchClassSet
        {

            // Base case: all pitch classes have been spelled
            // FIXME: ensure `graph` is the right size!
            guard let (pitchClass, remaining) = pitchClasses.destructured else {
                return SpelledPitchClassSet(graph.map(SpelledPitchClass.init))
            }
            
            let contexts = spellingContexts(
                spellings: pitchClass.spellings,
                graph: graph,
                totalCost: totalCost,
                nodeEdgeCost: nodeEdgeCost
            )
            
            guard !contexts.isEmpty else { fatalError() } // TODO: throw error
            
            // FIXME: wrap
            for context in contexts.sorted(by: { $0.totalCost < $1.totalCost }) {
                guard context.totalCost < costThreshold else { continue }
                
                // FIXME: refactor `Graph` into reference semantic object
                var graph = graph
                graph.append(context.spelling)

                return traverseToSpell(
                    remaining,
                    graph: graph,
                    totalCost: context.totalCost,
                    nodeEdgeCost: context.nodeEdgeCost
                )
            }

            // FIXME: must return something real
            fatalError()
        }
        
        let pitchClasses = Array(pitchClassSet)
        return traverseToSpell(pitchClasses, graph: [], totalCost: 0, nodeEdgeCost: 0)
    }
    
    private func spellingContexts(
        spellings: [Node],
        graph: Graph,
        totalCost: Float,
        nodeEdgeCost: Float
    ) -> [SpellingContext]
    {
     
        return spellings.flatMap { spelling in
            
            var totalCost = totalCost
            
            do {
                
                let nodeCost = cost(spelling, nodeRules)
                try incrementTotalCost(&totalCost, with: nodeCost)
                let edgeCost = cost(spelling, graph, edgeRules)
                try incrementTotalCost(&totalCost, with: edgeCost)
                
                // FIXME: Refactor `Graph` into reference semantic object
                // Add method to `Graph.tryout(node: `Node`),
                // - returns cost of adding that node without adding the node.
                var tempGraph = graph
                tempGraph.append(spelling)
                
                let graphCost = cost(tempGraph, graphRules)
                try incrementTotalCost(&totalCost, with: graphCost)
                
                let spellingContext = SpellingContext(
                    spelling: spelling,
                    totalCost: totalCost,
                    nodeEdgeCost: nodeCost + edgeCost
                )
                
                tempGraph.removeLast()
                return spellingContext
                
            } catch {
                return nil
            }
        }
    }
    
    private func incrementTotalCost(_ totalCost: inout Float, with cost: Float) throws {
        totalCost += cost
        guard totalCost < costThreshold else { throw CostError.thresholdExceeded }
    }
}
*/
