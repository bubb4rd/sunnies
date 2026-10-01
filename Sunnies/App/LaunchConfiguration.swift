import Foundation

/// Development launch options, e.g. `-SunniesMockScenario likelyMatch`.
/// Only read in DEBUG builds (see `SunniesApp`).
nonisolated struct LaunchConfiguration: Equatable, Sendable {
    static let mockScenarioArgument = "-SunniesMockScenario"

    let mockScenario: MockScenario?

    init(arguments: [String]) {
        guard
            let flagIndex = arguments.firstIndex(of: Self.mockScenarioArgument),
            arguments.indices.contains(flagIndex + 1)
        else {
            mockScenario = nil
            return
        }
        mockScenario = MockScenario(rawValue: arguments[flagIndex + 1])
    }
}
