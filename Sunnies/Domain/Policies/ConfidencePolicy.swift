import Foundation

/// Enforces "never show fictional certainty" on any recognition response,
/// regardless of source. Claims the response can't back up are downgraded,
/// never rejected, so the user still gets useful output.
nonisolated enum ConfidencePolicy {
    /// Evidence strong enough to support an exact brand/model claim.
    static let identifyingEvidence: Set<RecognitionEvidenceType> = [
        .visibleBrandText, .visibleModelText, .catalogImageMatch,
    ]

    static func validated(_ response: RecognitionResponse) -> RecognitionResponse {
        var result = response

        // A best-match candidate only belongs at exact/likely confidence.
        // Below that, keep the product but present it as a similar style.
        if let candidate = result.primaryCandidate, ![.exact, .likely].contains(result.confidence) {
            result.primaryCandidate = nil
            if !result.similarProducts.contains(where: { $0.id == candidate.id }) {
                result.similarProducts.insert(candidate, at: 0)
            }
        }

        result.confidence = supportedConfidence(for: result)

        if var candidate = result.primaryCandidate {
            candidate.matchType = result.confidence == .exact ? .exact : .likely
            result.primaryCandidate = candidate
        }
        result.similarProducts = result.similarProducts.map(cappedAsSimilar)

        return result
    }

    private static func supportedConfidence(for response: RecognitionResponse) -> MatchConfidence {
        var confidence = response.confidence
        while true {
            let next = downgrade(confidence, response)
            if next == confidence { return confidence }
            confidence = next
        }
    }

    private static func downgrade(_ confidence: MatchConfidence, _ response: RecognitionResponse) -> MatchConfidence {
        switch confidence {
        case .exact:
            let hasIdentifyingEvidence = response.evidence.contains { identifyingEvidence.contains($0.type) }
            return response.primaryCandidate != nil && hasIdentifyingEvidence ? .exact : .likely
        case .likely:
            if response.primaryCandidate != nil { return .likely }
            return response.similarProducts.isEmpty ? .styleOnly : .similar
        case .similar:
            if !response.similarProducts.isEmpty { return .similar }
            return response.styleAttributes == nil ? .insufficientEvidence : .styleOnly
        case .styleOnly:
            return response.styleAttributes == nil ? .insufficientEvidence : .styleOnly
        case .insufficientEvidence:
            return .insufficientEvidence
        }
    }

    /// Alternatives can be similar or editorial picks, never exact/likely claims.
    private static func cappedAsSimilar(_ product: FrameProduct) -> FrameProduct {
        guard product.matchType == .exact || product.matchType == .likely else { return product }
        var capped = product
        capped.matchType = .similar
        return capped
    }
}
