import Foundation
import Observation

@Observable
final class ImageInputViewModel {
    enum State: Equatable {
        case empty
        case loading
        case loaded(NormalizedImage)
        case failed(ImageInputError)
    }

    private(set) var state: State = .empty
    private let normalizer: ImageNormalizer

    init(normalizer: ImageNormalizer = ImageNormalizer()) {
        self.normalizer = normalizer
    }

    var selectedImage: NormalizedImage? {
        if case .loaded(let image) = state { image } else { nil }
    }

    /// Loads and normalizes a photo. Call from `.task(id:)` so SwiftUI cancels
    /// a load superseded by a new selection or removal.
    func load(_ source: @Sendable () async throws -> Data?) async {
        state = .loading
        do {
            guard let data = try await source() else { throw ImageInputError.unreadable }
            let image = try await normalizer.normalized(from: data)
            try Task.checkCancellation()
            state = .loaded(image)
        } catch {
            // A cancelled load was superseded; the newer action owns the state.
            guard !Task.isCancelled, !(error is CancellationError) else { return }
            state = .failed(error as? ImageInputError ?? .unreadable)
        }
    }

    func remove() {
        state = .empty
    }
}

extension ImageInputError {
    var title: String {
        switch self {
        case .unreadable: "We couldn’t open that photo"
        case .unsupportedFormat: "That file isn’t a supported image"
        case .tooSmall: "That photo is too small"
        case .tooLarge: "That photo is too large"
        }
    }

    var message: String {
        switch self {
        case .unreadable: "It may still be downloading from iCloud. Try again or choose another photo."
        case .unsupportedFormat: "Choose a photo or screenshot in a standard format like JPEG, HEIC, or PNG."
        case .tooSmall: "Choose a larger image so the frames have enough detail to match."
        case .tooLarge: "Choose a smaller photo or a screenshot."
        }
    }

    /// Only transient load failures are worth retrying with the same photo.
    var isRetryable: Bool { self == .unreadable }
}
