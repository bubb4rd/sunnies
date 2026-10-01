import Foundation

/// Development launch options, e.g. `-SunniesMockScenario likelyMatch`.
/// Only read in DEBUG builds (see `SunniesApp`).
nonisolated struct LaunchConfiguration: Equatable, Sendable {
    static let mockScenarioArgument = "-SunniesMockScenario"
    /// Shows a "Use sample photo" action, since UI tests can't drive PhotosPicker.
    static let sampleImageArgument = "-SunniesSampleImage"

    let mockScenario: MockScenario?
    let usesSampleImage: Bool

    init(arguments: [String]) {
        usesSampleImage = arguments.contains(Self.sampleImageArgument)
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
