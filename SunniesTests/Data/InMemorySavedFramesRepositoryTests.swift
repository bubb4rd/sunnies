import Foundation
import Testing
@testable import Sunnies

struct InMemorySavedFramesRepositoryTests {
    @Test func savesAndFetchesNewestFirst() async throws {
        let repository = InMemorySavedFramesRepository()
        let older = SavedFrame(product: SeedProducts.haldenArlo, savedAt: Date(timeIntervalSinceReferenceDate: 1))
        let newer = SavedFrame(product: SeedProducts.verraSol, savedAt: Date(timeIntervalSinceReferenceDate: 2))
        try await repository.save(older)
        try await repository.save(newer)
        #expect(try await repository.fetchSavedFrames().map(\.id) == [newer.id, older.id])
    }

    @Test func updatesStatus() async throws {
        var frame = SavedFrame(product: SeedProducts.haldenArlo)
        let repository = InMemorySavedFramesRepository(frames: [frame])
        frame.status = .bought
        try await repository.update(frame)
        #expect(try await repository.fetchSavedFrames().first?.status == .bought)
    }

    @Test func deletesFrame() async throws {
        let frame = SavedFrame(product: SeedProducts.haldenArlo)
        let repository = InMemorySavedFramesRepository(frames: [frame])
        try await repository.delete(id: frame.id)
        #expect(try await repository.fetchSavedFrames().isEmpty)
    }

    @Test func updateOrDeleteOfMissingFrameThrowsNotFound() async {
        let repository = InMemorySavedFramesRepository()
        let missing = SavedFrame(product: SeedProducts.haldenArlo)
        await #expect(throws: PersistenceError.notFound) { try await repository.update(missing) }
        await #expect(throws: PersistenceError.notFound) { try await repository.delete(id: missing.id) }
    }
}
