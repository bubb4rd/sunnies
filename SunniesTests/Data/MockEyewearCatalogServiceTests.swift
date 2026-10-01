import Foundation
import Testing
@testable import Sunnies

struct MockEyewearCatalogServiceTests {
    private let service = MockEyewearCatalogService()

    @Test func filtersByShape() async throws {
        let results = try await service.search(query: FrameSearchQuery(attributes: FrameAttributes(shape: .aviator)))
        #expect(!results.isEmpty)
        #expect(results.allSatisfy { $0.shape == .aviator })
    }

    @Test func filtersByCategoryAndPrice() async throws {
        let results = try await service.search(query: FrameSearchQuery(category: .sunglasses, priceRange: .under100))
        #expect(results.map(\.id) == [SeedProducts.verraSol.id, SeedProducts.okonFlint.id])
    }

    @Test func prescriptionFilterExcludesUnknownCompatibility() async throws {
        let results = try await service.search(query: FrameSearchQuery(prescriptionCompatibleOnly: true))
        #expect(!results.isEmpty)
        #expect(results.allSatisfy { $0.prescriptionCompatible == true })
    }

    @Test func ordersByScoreThenID() async throws {
        let tied = [
            SeedProducts.verraSol, SeedProducts.okonFlint, SeedProducts.haldenArlo,
        ].map { product -> FrameProduct in
            var copy = product
            copy.matchScore = 0.5
            return copy
        }
        let results = try await MockEyewearCatalogService(products: tied).search(query: FrameSearchQuery())
        #expect(results.map(\.id) == tied.map(\.id).sorted())

        let ranked = try await service.search(query: FrameSearchQuery())
        let scores = ranked.compactMap(\.matchScore)
        #expect(scores == scores.sorted(by: >))
    }

    @Test func respectsLimit() async throws {
        let results = try await service.search(query: FrameSearchQuery(limit: 3))
        #expect(results.count == 3)
    }

    @Test func returnsEmptyWhenNothingMatches() async throws {
        let query = FrameSearchQuery(attributes: FrameAttributes(shape: .wraparound))
        #expect(try await service.search(query: query).isEmpty)
    }
}
