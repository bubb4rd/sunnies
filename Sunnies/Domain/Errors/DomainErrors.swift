import Foundation

/// Failures while loading and preparing a user-selected image.
/// Picker cancellation is not an error; it leaves the current state untouched.
nonisolated enum ImageInputError: Error, Equatable, Sendable {
    /// The photo couldn't be loaded, e.g. it's still downloading from iCloud.
    case unreadable
    case unsupportedFormat
    case tooSmall
    case tooLarge
}

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
