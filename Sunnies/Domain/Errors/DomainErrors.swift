import Foundation

/// Failures from recognition. "No result" is not an error — it's a valid
/// response with `.insufficientEvidence`. Cancellation uses `CancellationError`.
nonisolated enum RecognitionError: Error, Equatable, Sendable {
    case offline
    case timeout
    case serviceUnavailable
    case rateLimited
    case malformedResponse
    case invalidInput
}

nonisolated enum CatalogError: Error, Equatable, Sendable {
    case offline
    case timeout
    case serviceUnavailable
    case malformedResponse
}

nonisolated enum PersistenceError: Error, Equatable, Sendable {
    case unavailable
    case notFound
    case writeFailed
    case corruptData
}
