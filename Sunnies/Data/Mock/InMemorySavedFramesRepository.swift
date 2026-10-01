import Foundation

/// Non-persistent repository used until the JSON file repository lands in M5.
actor InMemorySavedFramesRepository: SavedFramesRepository {
    private var frames: [SavedFrame.ID: SavedFrame]

    init(frames: [SavedFrame] = []) {
        self.frames = Dictionary(uniqueKeysWithValues: frames.map { ($0.id, $0) })
    }

    func fetchSavedFrames() async throws -> [SavedFrame] {
        frames.values.sorted { $0.savedAt > $1.savedAt }
    }

    func save(_ frame: SavedFrame) async throws {
        frames[frame.id] = frame
    }

    func update(_ frame: SavedFrame) async throws {
        guard frames[frame.id] != nil else { throw PersistenceError.notFound }
        frames[frame.id] = frame
    }

    func delete(id: SavedFrame.ID) async throws {
        guard frames.removeValue(forKey: id) != nil else { throw PersistenceError.notFound }
    }
}
