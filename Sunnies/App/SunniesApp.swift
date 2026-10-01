import SwiftUI

@main
struct SunniesApp: App {
    private let launchConfiguration = SunniesApp.makeLaunchConfiguration()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.appEnvironment, .mock(scenario: launchConfiguration.mockScenario ?? .similarStyles))
                .environment(\.launchConfiguration, launchConfiguration)
                .tint(SunniesColor.accent)
        }
    }

    // Development launch options are honored only in DEBUG builds.
    // Mocks are the only implementation until the M7 backend spike.
    private static func makeLaunchConfiguration() -> LaunchConfiguration {
        #if DEBUG
        LaunchConfiguration(arguments: ProcessInfo.processInfo.arguments)
        #else
        LaunchConfiguration(arguments: [])
        #endif
    }
}
