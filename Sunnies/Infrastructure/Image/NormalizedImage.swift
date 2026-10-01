import CoreGraphics
import Foundation

/// An image upright, downscaled, and stripped of metadata, ready for crop.
/// Held in memory only; never persisted or uploaded at this stage.
nonisolated struct NormalizedImage: Identifiable, Hashable, Sendable {
    let id: UUID
    let cgImage: CGImage

    init(id: UUID = UUID(), cgImage: CGImage) {
        self.id = id
        self.cgImage = cgImage
    }

    var pixelWidth: Int { cgImage.width }
    var pixelHeight: Int { cgImage.height }

    static func == (lhs: NormalizedImage, rhs: NormalizedImage) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
