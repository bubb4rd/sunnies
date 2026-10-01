import Foundation
import Testing
@testable import Sunnies

struct ConfidencePolicyTests {
    private let candidate = SeedProducts.haldenArlo
    private let alternative = SeedProducts.northlightWren.with(matchType: .similar)
    private let attributes = RecognitionFixtures.roundTortoiseAttributes
    private let modelText = RecognitionEvidence(type: .visibleModelText, summary: "Model code visible", relatedProductID: nil)
    private let visual = RecognitionEvidence(type: .visualSimilarity, summary: "Similar shape", relatedProductID: nil)

    @Test func supportedExactPassesThrough() {
        let response = RecognitionResponse.make(
            confidence: .exact,
            primaryCandidate: candidate.with(matchType: .exact),
            styleAttributes: attributes,
            similarProducts: [alternative],
            evidence: [modelText]
        )
        #expect(ConfidencePolicy.validated(response) == response)
    }

    @Test func exactWithoutIdentifyingEvidenceBecomesLikely() {
        let response = RecognitionResponse.make(
            confidence: .exact,
            primaryCandidate: candidate.with(matchType: .exact),
            evidence: [visual]
        )
        let result = ConfidencePolicy.validated(response)
        #expect(result.confidence == .likely)
        #expect(result.primaryCandidate?.matchType == .likely)
    }

    @Test func exactWithoutCandidateFallsToSimilar() {
        let response = RecognitionResponse.make(confidence: .exact, similarProducts: [alternative], evidence: [modelText])
        #expect(ConfidencePolicy.validated(response).confidence == .similar)
    }

    @Test func likelyWithoutCandidateOrProductsFallsToStyleOnly() {
        let response = RecognitionResponse.make(confidence: .likely, styleAttributes: attributes)
        #expect(ConfidencePolicy.validated(response).confidence == .styleOnly)
    }

    @Test func similarWithoutProductsFallsToStyleOnly() {
        let response = RecognitionResponse.make(confidence: .similar, styleAttributes: attributes)
        #expect(ConfidencePolicy.validated(response).confidence == .styleOnly)
    }

    @Test func similarWithNothingFallsToInsufficientEvidence() {
        let response = RecognitionResponse.make(confidence: .similar)
        #expect(ConfidencePolicy.validated(response).confidence == .insufficientEvidence)
    }

    @Test func styleOnlyWithoutAttributesFallsToInsufficientEvidence() {
        let response = RecognitionResponse.make(confidence: .styleOnly)
        #expect(ConfidencePolicy.validated(response).confidence == .insufficientEvidence)
    }

    @Test func candidateBelowLikelyMovesIntoAlternatives() {
        let response = RecognitionResponse.make(
            confidence: .similar,
            primaryCandidate: candidate.with(matchType: .exact),
            similarProducts: [alternative]
        )
        let result = ConfidencePolicy.validated(response)
        #expect(result.primaryCandidate == nil)
        #expect(result.similarProducts.map(\.id) == [candidate.id, alternative.id])
        #expect(result.similarProducts.allSatisfy { $0.matchType == .similar })
    }

    @Test func alternativesNeverClaimExactOrLikely() {
        let response = RecognitionResponse.make(
            confidence: .similar,
            similarProducts: [
                SeedProducts.okonFlint.with(matchType: .exact),
                SeedProducts.verraSol.with(matchType: .likely),
                SeedProducts.ivoCorsa.with(matchType: .editorial),
            ]
        )
        let result = ConfidencePolicy.validated(response)
        #expect(result.similarProducts.map(\.matchType) == [.similar, .similar, .editorial])
    }
}
