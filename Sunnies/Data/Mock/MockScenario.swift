import Foundation

/// Deterministic outcomes the mock recognition service can produce.
/// Selected at launch with `-SunniesMockScenario <rawValue>` in DEBUG builds.
nonisolated enum MockScenario: String, CaseIterable, Sendable {
    case exactMatch
    case likelyMatch
    case similarStyles
    case styleOnly
    case noResults
    case serviceFailure
    case timeout
    case malformedResponse
}
