import Foundation

/// One deterministic response per successful mock scenario. Every fixture must
/// pass `ConfidencePolicy.validated` unchanged (enforced by tests).
nonisolated enum RecognitionFixtures {
    static func response(for scenario: MockScenario, requestID: UUID) throws -> RecognitionResponse {
        switch scenario {
        case .exactMatch: exactMatch(requestID)
        case .likelyMatch: likelyMatch(requestID)
        case .similarStyles: similarStyles(requestID)
        case .styleOnly: styleOnly(requestID)
        case .noResults: noResults(requestID)
        case .serviceFailure, .timeout, .malformedResponse:
            throw RecognitionError.invalidInput
        }
    }

    static let roundTortoiseAttributes = FrameAttributes(
        shape: .round,
        material: .acetate,
        frameColor: .tortoise,
        lensCharacteristics: [.clear],
        styleDescriptors: [.classic, .vintageInspired]
    )

    static let chunkySquareAttributes = FrameAttributes(
        shape: .square,
        material: .acetate,
        frameColor: .black,
        lensCharacteristics: [.grey],
        styleDescriptors: [.chunky, .bold]
    )

    static func exactMatch(_ requestID: UUID) -> RecognitionResponse {
        RecognitionResponse(
            requestID: requestID,
            confidence: .exact,
            primaryCandidate: with(SeedProducts.haldenArlo, .exact),
            styleAttributes: roundTortoiseAttributes,
            similarProducts: [
                with(SeedProducts.northlightWren, .similar),
                with(SeedProducts.verraPalma, .similar),
            ],
            evidence: [
                RecognitionEvidence(
                    type: .visibleModelText,
                    summary: "Model code printed on the inner temple matches the catalog entry.",
                    relatedProductID: SeedProducts.haldenArlo.id
                ),
                RecognitionEvidence(
                    type: .catalogImageMatch,
                    summary: "Frame silhouette and bridge match the catalog product photo.",
                    relatedProductID: SeedProducts.haldenArlo.id
                ),
            ]
        )
    }

    static func likelyMatch(_ requestID: UUID) -> RecognitionResponse {
        RecognitionResponse(
            requestID: requestID,
            confidence: .likely,
            primaryCandidate: with(SeedProducts.marisolPikeDune, .likely),
            styleAttributes: chunkySquareAttributes,
            similarProducts: [
                with(SeedProducts.okonFlint, .similar),
                with(SeedProducts.haldenMira, .similar),
                with(SeedProducts.northlightLane, .similar),
            ],
            evidence: [
                RecognitionEvidence(
                    type: .visualSimilarity,
                    summary: "Similar thick square acetate front and dark grey lenses.",
                    relatedProductID: SeedProducts.marisolPikeDune.id
                ),
            ]
        )
    }

    static func similarStyles(_ requestID: UUID) -> RecognitionResponse {
        RecognitionResponse(
            requestID: requestID,
            confidence: .similar,
            primaryCandidate: nil,
            styleAttributes: roundTortoiseAttributes,
            similarProducts: [
                with(SeedProducts.haldenArlo, .similar),
                with(SeedProducts.northlightWren, .similar),
                with(SeedProducts.verraPalma, .similar),
                with(SeedProducts.verraSol, .similar),
            ],
            evidence: [
                RecognitionEvidence(
                    type: .visualSimilarity,
                    summary: "Rounded acetate silhouette with a warm tortoise finish.",
                    relatedProductID: nil
                ),
            ]
        )
    }

    static func styleOnly(_ requestID: UUID) -> RecognitionResponse {
        RecognitionResponse(
            requestID: requestID,
            confidence: .styleOnly,
            primaryCandidate: nil,
            styleAttributes: FrameAttributes(
                shape: .geometric,
                material: .metal,
                frameColor: .gold,
                lensCharacteristics: [.tinted],
                styleDescriptors: [.angular, .slim]
            ),
            similarProducts: [],
            evidence: []
        )
    }

    static func noResults(_ requestID: UUID) -> RecognitionResponse {
        RecognitionResponse(
            requestID: requestID,
            confidence: .insufficientEvidence,
            primaryCandidate: nil,
            styleAttributes: nil,
            similarProducts: [],
            evidence: []
        )
    }

    private static func with(_ product: FrameProduct, _ matchType: MatchType) -> FrameProduct {
        var copy = product
        copy.matchType = matchType
        return copy
    }
}
