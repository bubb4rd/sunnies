import Foundation

/// Decodes untrusted response bytes. Any failure becomes
/// `RecognitionError.malformedResponse`; decoder details never reach the UI.
/// M7 replaces direct decoding with a DTO layer.
nonisolated enum RecognitionResponseDecoder {
    static func decode(_ data: Data) throws -> RecognitionResponse {
        guard !data.isEmpty else { throw RecognitionError.malformedResponse }
        do {
            return try JSONDecoder().decode(RecognitionResponse.self, from: data)
        } catch {
            throw RecognitionError.malformedResponse
        }
    }
}
