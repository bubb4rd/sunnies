import SwiftUI

@main
struct SunniesApp: App {
    private let environment = SunniesApp.makeEnvironment()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.appEnvironment, environment)
                .tint(SunniesColor.accent)
        }
    }

    // Mocks are the only implementation until the M7 backend spike.
    private static func makeEnvironment() -> AppEnvironment {
        #if DEBUG
        let configuration = LaunchConfiguration(arguments: ProcessInfo.processInfo.arguments)
        return .mock(scenario: configuration.mockScenario ?? .similarStyles)
        #else
        return .mock()
        #endif
    }
}
