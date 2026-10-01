import Foundation
import Testing
import UniformTypeIdentifiers
@testable import Sunnies

struct ImageNormalizerTests {
    private let normalizer = ImageNormalizer()

    @Test func downscalesLongestSideToCap() throws {
        let image = try normalizer.normalize(TestImages.data(width: 4000, height: 1000))
        #expect(image.pixelWidth == 2048)
        #expect(image.pixelHeight == 512)
    }

    @Test func neverUpscales() throws {
        let image = try normalizer.normalize(TestImages.data(width: 300, height: 200, type: .png))
        #expect(image.pixelWidth == 300)
        #expect(image.pixelHeight == 200)
    }

    @Test func appliesEXIFOrientation() throws {
        // Orientation 6 = rotated 90° clockwise; the upright image is portrait.
        let image = try normalizer.normalize(TestImages.data(width: 400, height: 200, orientation: 6))
        #expect(image.pixelWidth == 200)
        #expect(image.pixelHeight == 400)
    }

    @Test func rejectsImagesWithTooLittleDetail() {
        #expect(throws: ImageInputError.tooSmall) {
            try normalizer.normalize(TestImages.data(width: 400, height: 60))
        }
    }

    @Test func rejectsOversizedInput() {
        var limited = ImageNormalizer()
        limited.maxInputBytes = 100
        #expect(throws: ImageInputError.tooLarge) {
            try limited.normalize(TestImages.data(width: 400, height: 400))
        }
    }

    @Test func rejectsEmptyData() {
        #expect(throws: ImageInputError.unreadable) { try normalizer.normalize(Data()) }
    }

    @Test func rejectsNonImageData() {
        #expect(throws: ImageInputError.unsupportedFormat) {
            try normalizer.normalize(Data("not an image".utf8))
        }
    }

    @Test func asyncVariantMatchesSync() async throws {
        let image = try await normalizer.normalized(from: TestImages.data(width: 3000, height: 3000))
        #expect(image.pixelWidth == 2048)
    }
}
