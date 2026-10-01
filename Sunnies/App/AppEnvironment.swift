import SwiftUI

/// Service container injected through the SwiftUI environment. Feature view
/// models receive these services in `init`; views never call services directly.
nonisolated struct AppEnvironment: Sendable {
    let recognition: any EyewearRecognitionService
    let catalog: any EyewearCatalogService
    let savedFrames: any SavedFramesRepository
}

nonisolated extension AppEnvironment {
    /// Fully offline environment backed by deterministic fixtures.
    static func mock(
        scenario: MockScenario = .similarStyles,
        latency: Duration = .milliseconds(1200)
    ) -> AppEnvironment {
        AppEnvironment(
            recognition: MockEyewearRecognitionService(scenario: scenario, latency: latency),
            catalog: MockEyewearCatalogService(),
            savedFrames: InMemorySavedFramesRepository()
        )
    }

    static let preview = AppEnvironment.mock(latency: .milliseconds(300))
}

extension EnvironmentValues {
    @Entry var appEnvironment: AppEnvironment = .preview
}
