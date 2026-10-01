import Foundation
import Testing
@testable import Sunnies

struct FixtureIntegrityTests {
    @Test func seedProductsAreMarkedAsDevelopmentData() {
        #expect(SeedProducts.all.allSatisfy { $0.source == .developmentSeed })
    }

    @Test func seedProductIDsAreUnique() {
        let ids = SeedProducts.all.map(\.id)
        #expect(Set(ids).count == ids.count)
    }

    @Test func matchScoresAreNormalized() {
        #expect(SeedProducts.all.allSatisfy { ($0.matchScore ?? 0) >= 0 && ($0.matchScore ?? 0) <= 1 })
    }

    /// No fixture may claim more certainty than its own evidence supports.
    @Test(arguments: [MockScenario.exactMatch, .likelyMatch, .similarStyles, .styleOnly, .noResults])
    func fixturePassesConfidencePolicyUnchanged(scenario: MockScenario) throws {
        let fixture = try RecognitionFixtures.response(for: scenario, requestID: UUID())
        #expect(ConfidencePolicy.validated(fixture) == fixture)
    }
}
