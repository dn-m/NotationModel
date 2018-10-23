//
//  LetterName.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

/// Letter name component of a `Pitch.Spelling`
public enum LetterName: String, CaseIterable {

    // MARK: - Cases

    /// A, la.
    case a

    /// B, si.
    case b

    /// C, do.
    case c

    /// D, re.
    case d

    /// E, mi.
    case e

    /// F, fa.
    case f

    /// G, sol.
    case g
}

extension LetterName {

    // MARK: - Computed Properties

    /// Amount of steps from c
    public var steps: Int {
        switch self {
        case .c: return 0
        case .d: return 1
        case .e: return 2
        case .f: return 3
        case .g: return 4
        case .a: return 5
        case .b: return 6
        }
    }

    /// Default pitch class for a given `LetterName`.
    public var pitchClass: Double {
        switch self {
        case .c: return 0
        case .d: return 2
        case .e: return 4
        case .f: return 5
        case .g: return 7
        case .a: return 9
        case .b: return 11
        }
    }
}

extension LetterName {

    // MARK: - Initializers

    /// Creates a `LetterName` with the amount of diatonic steps from `c`.
    public init(steps: Int) {
        switch steps % 7 {
        case 0: self = .c
        case 1: self = .d
        case 2: self = .e
        case 3: self = .f
        case 4: self = .g
        case 5: self = .a
        case 6: self = .b
        default: fatalError("Impossible")
        }
    }

    /// Creates a `LetterName` with a given `string` value. Uppercase and lowercase values are
    /// accepted here.
    public init?(string: String) {
        switch string {
        case "a", "A": self = .a
        case "b", "B": self = .b
        case "c", "C": self = .c
        case "d", "D": self = .d
        case "e", "E": self = .e
        case "f", "F": self = .f
        case "g", "G": self = .g
        default: return nil
        }
    }
}

extension LetterName {

    // MARK: - Instance Properties

    /// - Returns: The `LetterName` value displaced by the given amount of `steps`.
    public func displaced(by steps: Int) -> LetterName {
        return .init(steps: self.steps + steps)
    }
}
