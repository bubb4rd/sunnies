import PhotosUI
import SwiftUI

struct ImageInputView: View {
    let onContinue: (NormalizedImage) -> Void

    @State private var viewModel = ImageInputViewModel()
    @State private var pickerItem: PhotosPickerItem?
    @State private var request: LoadRequest?
    @Environment(\.launchConfiguration) private var launchConfiguration

    /// Identity for `.task(id:)`; a new value cancels the in-flight load.
    private struct LoadRequest: Equatable {
        enum Source: Equatable {
            case picker(PhotosPickerItem)
            case sample
        }

        let source: Source
        var attempt = 0
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SunniesSpacing.l) {
                header
                content
                Label("Your photo stays on this device. Nothing is uploaded until you choose to analyze.", systemImage: "lock")
                    .font(SunniesTypography.caption)
                    .foregroundStyle(SunniesColor.textTertiary)
            }
            .padding(.horizontal, SunniesSpacing.l)
            .padding(.vertical, SunniesSpacing.m)
        }
        .background(SunniesColor.backgroundPrimary)
        .onChange(of: pickerItem) { _, item in
            // Cancelling the picker leaves the selection (and state) untouched.
            guard let item else { return }
            request = LoadRequest(source: .picker(item))
        }
        .task(id: request) {
            guard let request else { return }
            await viewModel.load(source(for: request))
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: SunniesSpacing.s) {
            Text("Choose a photo")
                .font(SunniesTypography.screenTitle)
                .foregroundStyle(SunniesColor.textPrimary)
                .accessibilityAddTraits(.isHeader)
            Text("A screenshot or photo where the glasses are clearly visible.")
                .font(SunniesTypography.body)
                .foregroundStyle(SunniesColor.textSecondary)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .empty:
            ImageUploadCard(title: "Add a photo", message: "You’ll crop around the glasses next.") {
                photoPicker(label: "Choose photo", systemImage: "photo.on.rectangle", style: .primary)
                if launchConfiguration.usesSampleImage {
                    Button("Use sample photo") { request = LoadRequest(source: .sample) }
                        .buttonStyle(.sunniesSecondary)
                }
            }

        case .loading:
            StateView(kind: .loading(message: "Preparing your photo…"))
                .frame(minHeight: 280)
                .background(SunniesColor.surface, in: RoundedRectangle(cornerRadius: SunniesRadius.large))

        case .loaded(let image):
            loaded(image)

        case .failed(let error):
            failed(error)
        }
    }

    private func failed(_ error: ImageInputError) -> some View {
        let retryAction: (() -> Void)? = error.isRetryable ? { retry() } : nil
        return VStack(spacing: SunniesSpacing.s) {
            StateView(kind: .error(title: error.title, message: error.message, retry: retryAction))
            photoPicker(label: "Choose another photo", systemImage: "photo.on.rectangle", style: .secondary)
        }
    }

    private func loaded(_ image: NormalizedImage) -> some View {
        VStack(spacing: SunniesSpacing.m) {
            Image(image.cgImage, scale: 1, label: Text("Selected photo"))
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 420)
                .clipShape(RoundedRectangle(cornerRadius: SunniesRadius.large))
                .sunniesShadow(.card)
                .accessibilityIdentifier("selectedPhotoPreview")

            Button {
                onContinue(image)
            } label: {
                Label("Continue", systemImage: "arrow.right")
            }
            .buttonStyle(.sunniesPrimary)

            HStack(spacing: SunniesSpacing.s) {
                photoPicker(label: "Replace", systemImage: "arrow.triangle.2.circlepath", style: .secondary)
                Button(role: .destructive, action: remove) {
                    Label("Remove", systemImage: "trash")
                }
                .buttonStyle(.sunniesSecondary)
            }
        }
    }

    private enum PickerStyle { case primary, secondary }

    @ViewBuilder
    private func photoPicker(label: String, systemImage: String, style: PickerStyle) -> some View {
        let picker = PhotosPicker(selection: $pickerItem, matching: .images) {
            Label(label, systemImage: systemImage)
        }
        switch style {
        case .primary: picker.buttonStyle(.sunniesPrimary)
        case .secondary: picker.buttonStyle(.sunniesSecondary)
        }
    }

    private func source(for request: LoadRequest) -> @Sendable () async throws -> Data? {
        switch request.source {
        case .picker(let item):
            return { try await item.loadTransferable(type: Data.self) }
        case .sample:
            #if DEBUG
            return { DebugSampleImage.pngData() }
            #else
            return { nil }
            #endif
        }
    }

    private func retry() {
        guard let request else { return }
        self.request = LoadRequest(source: request.source, attempt: request.attempt + 1)
    }

    private func remove() {
        request = nil
        pickerItem = nil
        viewModel.remove()
    }
}

#Preview {
    NavigationStack {
        ImageInputView { _ in }
    }
}
