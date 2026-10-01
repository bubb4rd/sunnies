import Testing
@testable import Sunnies

struct LaunchConfigurationTests {
    @Test func parsesKnownScenario() {
        let configuration = LaunchConfiguration(arguments: ["Sunnies", "-SunniesMockScenario", "likelyMatch"])
        #expect(configuration.mockScenario == .likelyMatch)
    }

    @Test func ignoresUnknownScenario() {
        let configuration = LaunchConfiguration(arguments: ["Sunnies", "-SunniesMockScenario", "certain"])
        #expect(configuration.mockScenario == nil)
    }

    @Test func handlesMissingOrDanglingFlag() {
        #expect(LaunchConfiguration(arguments: ["Sunnies"]).mockScenario == nil)
        #expect(LaunchConfiguration(arguments: ["Sunnies", "-SunniesMockScenario"]).mockScenario == nil)
    }

    @Test func sampleImageFlagIsOptIn() {
        #expect(LaunchConfiguration(arguments: ["Sunnies", "-SunniesSampleImage"]).usesSampleImage)
        #expect(!LaunchConfiguration(arguments: ["Sunnies"]).usesSampleImage)
    }
}
