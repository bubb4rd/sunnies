import Foundation
import Testing
@testable import Sunnies

struct DomainCodingTests {
    @Test func frameProductRoundTrips() throws {
        let product = SeedProducts.haldenArlo.with(matchType: .likely)
        let decoded = try JSONDecoder().decode(FrameProduct.self, from: JSONEncoder().encode(product))
        #expect(decoded == product)
    }

    @Test func recognitionResponseRoundTrips() throws {
        let response = RecognitionFixtures.exactMatch(UUID())
        let decoded = try JSONDecoder().decode(RecognitionResponse.self, from: JSONEncoder().encode(response))
        #expect(decoded == response)
    }

    @Test func savedFrameRoundTrips() throws {
        let frame = SavedFrame(
            product: SeedProducts.verraPalma,
            status: .considering,
            note: "For reading",
            savedAt: Date(timeIntervalSinceReferenceDate: 800_000_000)
        )
        let decoded = try JSONDecoder().decode(SavedFrame.self, from: JSONEncoder().encode(frame))
        #expect(decoded == frame)
    }

    // Raw values are persisted and sent over the wire; changing them needs a migration.
    @Test func persistedRawValuesAreStable() {
        #expect(SavedFrameStatus.allCases.map(\.rawValue) == ["want", "considering", "bought", "archived"])
        #expect(MatchConfidence.allCases.map(\.rawValue) == ["exact", "likely", "similar", "styleOnly", "insufficientEvidence"])
        #expect([MatchType.exact, .likely, .similar, .editorial].map(\.rawValue) == ["exact", "likely", "similar", "editorial"])
    }

    @Test func recognitionRequestRedactsImageBytes() {
        let request = RecognitionRequest.fixture()
        #expect(request.description.contains("<redacted 1x1>"))
        #expect(!request.debugDescription.contains("bytes"))
    }

    @Test(arguments: [
        (PriceRange.under100, Decimal(99), true),
        (.under100, 100, false),
        (.from100To250, 100, true),
        (.from100To250, 250, false),
        (.from250To500, 499, true),
        (.luxury, 500, true),
    ])
    func priceRangeBoundaries(range: PriceRange, price: Decimal, expected: Bool) {
        #expect(range.contains(price) == expected)
    }
}
