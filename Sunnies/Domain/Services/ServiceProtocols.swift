import Foundation

// Provider-agnostic boundaries. The UI depends only on these; mock and
// (later) remote implementations live in the Data layer.

nonisolated protocol EyewearRecognitionService: Sendable {
    func analyze(
        request: RecognitionRequest
    ) async throws -> RecognitionResponse
}

nonisolated protocol EyewearCatalogService: Sendable {
    func search(
        query: FrameSearchQuery
    ) async throws -> [FrameProduct]
}

nonisolated protocol SavedFramesRepository: Sendable {
    func fetchSavedFrames() async throws -> [SavedFrame]
    func save(_ frame: SavedFrame) async throws
    func update(_ frame: SavedFrame) async throws
    func delete(id: SavedFrame.ID) async throws
}
