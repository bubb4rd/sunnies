import Foundation
import Testing
@testable import Sunnies

struct ImageInputViewModelTests {
    private struct LoadFailure: Error {}

    @Test func loadsAndNormalizesSelectedPhoto() async {
        let viewModel = ImageInputViewModel()
        let data = TestImages.data(width: 1200, height: 800)
        await viewModel.load { data }
        #expect(viewModel.selectedImage?.pixelWidth == 1200)
        #expect(viewModel.selectedImage?.pixelHeight == 800)
    }

    @Test func missingDataFailsAsUnreadable() async {
        let viewModel = ImageInputViewModel()
        await viewModel.load { nil }
        #expect(viewModel.state == .failed(.unreadable))
    }

    @Test func throwingSourceFailsAsUnreadable() async {
        let viewModel = ImageInputViewModel()
        await viewModel.load { throw LoadFailure() }
        #expect(viewModel.state == .failed(.unreadable))
    }

    @Test func normalizerErrorsSurface() async {
        let viewModel = ImageInputViewModel()
        await viewModel.load { Data("not an image".utf8) }
        #expect(viewModel.state == .failed(.unsupportedFormat))
    }

    @Test func removeReturnsToEmpty() async {
        let viewModel = ImageInputViewModel()
        let data = TestImages.data(width: 400, height: 400)
        await viewModel.load { data }
        viewModel.remove()
        #expect(viewModel.state == .empty)
    }

    @Test func cancelledLoadDoesNotOverwriteNewerState() async {
        let viewModel = ImageInputViewModel()
        let data = TestImages.data(width: 400, height: 400)
        let task = Task {
            await viewModel.load {
                try await Task.sleep(for: .seconds(30))
                return data
            }
        }
        while viewModel.state != .loading { await Task.yield() }

        viewModel.remove()
        task.cancel()
        await task.value
        #expect(viewModel.state == .empty)
    }

    @Test func onlyTransientFailuresAreRetryable() {
        #expect(ImageInputError.unreadable.isRetryable)
        #expect(!ImageInputError.tooSmall.isRetryable)
        #expect(!ImageInputError.unsupportedFormat.isRetryable)
        #expect(!ImageInputError.tooLarge.isRetryable)
    }
}
