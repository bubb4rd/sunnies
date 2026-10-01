import Foundation

nonisolated enum SearchIntent: String, Codable, CaseIterable, Sendable {
    case findExact
    case findSimilar
    case analyzeStyle
}

/// A single analysis request. Holds the normalized crop in memory only —
/// deliberately not `Codable` so it can't be persisted by accident.
nonisolated struct RecognitionRequest: Identifiable, Sendable {
    let id: UUID
    let intent: SearchIntent
    /// Normalized JPEG crop of the eyewear region.
    let imageData: Data
    let pixelWidth: Int
    let pixelHeight: Int

    init(id: UUID = UUID(), intent: SearchIntent, imageData: Data, pixelWidth: Int, pixelHeight: Int) {
        self.id = id
        self.intent = intent
        self.imageData = imageData
        self.pixelWidth = pixelWidth
        self.pixelHeight = pixelHeight
    }
}

// Redact image bytes so a request can never leak into logs via interpolation.
extension RecognitionRequest: CustomStringConvertible, CustomDebugStringConvertible {
    nonisolated var description: String {
        "RecognitionRequest(id: \(id), intent: \(intent.rawValue), image: <redacted \(pixelWidth)x\(pixelHeight)>)"
    }

    nonisolated var debugDescription: String { description }
}

nonisolated struct RecognitionResponse: Codable, Hashable, Sendable {
    var requestID: UUID
    var confidence: MatchConfidence
    var primaryCandidate: FrameProduct?
    var styleAttributes: FrameAttributes?
    var similarProducts: [FrameProduct]
    var evidence: [RecognitionEvidence]
    /// Untrusted provider text. The UI writes its own copy from `confidence`.
    var userMessage: String?
}

nonisolated enum RecognitionEvidenceType: String, Codable, Sendable {
    case visualSimilarity
    case visibleBrandText
    case visibleModelText
    case catalogImageMatch
    case webReference
    case userProvidedContext
}

nonisolated struct RecognitionEvidence: Codable, Hashable, Sendable {
    var type: RecognitionEvidenceType
    var summary: String
    var relatedProductID: FrameProduct.ID?
}
