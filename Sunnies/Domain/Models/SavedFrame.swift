import Foundation

nonisolated struct SavedFrame: Identifiable, Codable, Hashable, Sendable {
    let id: UUID
    /// Snapshot of the product at save time.
    var product: FrameProduct
    var status: SavedFrameStatus
    var note: String?
    let savedAt: Date
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        product: FrameProduct,
        status: SavedFrameStatus = .want,
        note: String? = nil,
        savedAt: Date = .now,
        updatedAt: Date? = nil
    ) {
        self.id = id
        self.product = product
        self.status = status
        self.note = note
        self.savedAt = savedAt
        self.updatedAt = updatedAt ?? savedAt
    }
}

nonisolated enum SavedFrameStatus: String, Codable, CaseIterable, Sendable {
    case want
    case considering
    case bought
    case archived
}
