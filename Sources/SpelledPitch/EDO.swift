//
//  EDO.swift
//  SpelledPitch
//
//  Created by James Bean on 8/18/18.
//

/// Namespace for the `EDO12` (12 equal divisions of the octave) `TuningSystem`.
public enum EDO12: TuningSystem {

    public enum Modifier: PitchSpellingModifier {

        case natural
        case sharp(Int)
        case flat(Int)

        public var adjustment: Double {
            switch self {
            case .natural: return 0
            case .sharp(let count): return Double(count)
            case .flat(let count): return -Double(count)
            }
        }
    }
}

extension EDO12.Modifier: CustomStringConvertible {
    public var description: String {
        switch self {
        case .natural: return "natural"
        case .sharp(let count): return "sharp \(count)"
        case .flat(let count): return "flat: \(count)"
        }
    }
}

/// Namespace for the `EDO24` (24 equal divisions of the octave) `TuningSystem`.
public struct EDO24: TuningSystem {

    public struct Modifier: PitchSpellingModifier {
        public enum Modifier: Double {
            case quarter = 0.5
            case none = 1
            case threeQuarter = 1.5
        }

        public let edo12: EDO12.Modifier
        public let modifier: Modifier
        public var adjustment: Double { return edo12.adjustment * modifier.rawValue }
    }
}

extension EDO24.Modifier: CustomStringConvertible {
    public var description: String {
        var string: String? {
            switch self.modifier {
            case .quarter: return "quarter"
            case .none: return nil
            case .threeQuarter: return "three quarter"
            }
        }
        return [string, edo12.description].compactMap { $0 }.joined(separator: " ")
    }
}

/// Namespace for the `EDO48` (48 equal divisions of the octave) `TuningSystem`.
public enum EDO48: TuningSystem {

    public struct Modifier: PitchSpellingModifier {

        public enum Modifier: Double {
            case up = 0.25
            case none = 0
            case down = -0.25

        }

        public let edo24: EDO24.Modifier
        public let modifier: Modifier
        public var adjustment: Double { return edo24.adjustment + modifier.rawValue }
    }
}

extension EDO48.Modifier: CustomStringConvertible {
    public var description: String {
        var string: String? {
            switch self.modifier {
            case .down: return "down"
            case .none: return nil
            case .up: return "up"
            }
        }
        return [string, edo24.description].compactMap { $0 }.joined(separator: " ")
    }
}

