import CoreGraphics
import Foundation
import ImageIO

/// Turns raw picker bytes into a `NormalizedImage`: EXIF orientation applied,
/// longest side capped, metadata dropped (only pixels are kept).
///
/// Uses ImageIO thumbnailing so a large photo is never fully decoded at
/// original resolution.
nonisolated struct ImageNormalizer: Sendable {
    var maxPixelDimension = 2048
    /// Below this on the shortest side, frames won't have enough detail to match.
    var minPixelDimension = 100
    var maxInputBytes = 60 * 1024 * 1024

    /// Normalizes off the caller's actor so large images never block the UI.
    @concurrent
    func normalized(from data: Data) async throws -> NormalizedImage {
        try normalize(data)
    }

    func normalize(_ data: Data) throws -> NormalizedImage {
        guard !data.isEmpty else { throw ImageInputError.unreadable }
        guard data.count <= maxInputBytes else { throw ImageInputError.tooLarge }

        let sourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard
            let source = CGImageSourceCreateWithData(data as CFData, sourceOptions),
            CGImageSourceGetCount(source) > 0,
            let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [CFString: Any],
            let width = properties[kCGImagePropertyPixelWidth] as? Int,
            let height = properties[kCGImagePropertyPixelHeight] as? Int
        else {
            throw ImageInputError.unsupportedFormat
        }

        guard min(width, height) >= minPixelDimension else { throw ImageInputError.tooSmall }

        let thumbnailOptions: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true,
            // Never upscale: cap at the original's longest side.
            kCGImageSourceThumbnailMaxPixelSize: min(maxPixelDimension, max(width, height)),
        ]
        guard let image = CGImageSourceCreateThumbnailAtIndex(source, 0, thumbnailOptions as CFDictionary) else {
            throw ImageInputError.unsupportedFormat
        }
        return NormalizedImage(cgImage: image)
    }
}
