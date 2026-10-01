import Foundation
@testable import Sunnies

extension RecognitionRequest {
    static func fixture(id: UUID = UUID()) -> RecognitionRequest {
        RecognitionRequest(id: id, intent: .findSimilar, imageData: Data([0xFF, 0xD8]), pixelWidth: 1, pixelHeight: 1)
    }
}

extension RecognitionResponse {
    static func make(
        confidence: MatchConfidence,
        primaryCandidate: FrameProduct? = nil,
        styleAttributes: FrameAttributes? = nil,
        similarProducts: [FrameProduct] = [],
        evidence: [RecognitionEvidence] = []
    ) -> RecognitionResponse {
        RecognitionResponse(
            requestID: UUID(),
            confidence: confidence,
            primaryCandidate: primaryCandidate,
            styleAttributes: styleAttributes,
            similarProducts: similarProducts,
            evidence: evidence
        )
    }
}

extension FrameProduct {
    func with(matchType: MatchType?) -> FrameProduct {
        var copy = self
        copy.matchType = matchType
        return copy
    }
}
