import Foundation

nonisolated enum MatchType: String, Codable, Sendable {
    case exact
    case likely
    case similar
    case editorial
}

nonisolated enum MatchConfidence: String, Codable, CaseIterable, Sendable {
    case exact
    case likely
    case similar
    case styleOnly
    case insufficientEvidence
}
