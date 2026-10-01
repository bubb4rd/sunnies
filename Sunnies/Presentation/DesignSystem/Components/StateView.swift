import SwiftUI

/// Shared loading, empty, and error presentation. Every feature reuses this so
/// no state is left blank or silent.
struct StateView: View {
    enum Kind {
        case loading(message: String)
        case empty(title: String, message: String, systemImage: String)
        case error(title: String, message: String, retry: (() -> Void)?)
    }

    let kind: Kind

    var body: some View {
        VStack(spacing: SunniesSpacing.m) {
            switch kind {
            case .loading(let message):
                ProgressView()
                    .controlSize(.large)
                    .tint(SunniesColor.accent)
                Text(message)
                    .font(SunniesTypography.body)
                    .foregroundStyle(SunniesColor.textSecondary)

            case .empty(let title, let message, let systemImage):
                icon(systemImage, tint: SunniesColor.textTertiary)
                titleAndMessage(title, message)

            case .error(let title, let message, let retry):
                icon("exclamationmark.triangle", tint: SunniesColor.error)
                titleAndMessage(title, message)
                if let retry {
                    Button("Try again", action: retry)
                        .buttonStyle(.sunniesSecondary)
                        .padding(.top, SunniesSpacing.s)
                }
            }
        }
        .multilineTextAlignment(.center)
        .padding(SunniesSpacing.xl)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: announceErrorIfNeeded)
    }

    private func icon(_ systemImage: String, tint: Color) -> some View {
        Image(systemName: systemImage)
            .font(.largeTitle)
            .foregroundStyle(tint)
            .accessibilityHidden(true)
    }

    private func titleAndMessage(_ title: String, _ message: String) -> some View {
        VStack(spacing: SunniesSpacing.s) {
            Text(title)
                .font(SunniesTypography.sectionTitle)
                .foregroundStyle(SunniesColor.textPrimary)
            Text(message)
                .font(SunniesTypography.body)
                .foregroundStyle(SunniesColor.textSecondary)
        }
        .accessibilityElement(children: .combine)
    }

    private func announceErrorIfNeeded() {
        guard case .error(let title, let message, _) = kind else { return }
        AccessibilityNotification.Announcement("\(title). \(message)").post()
    }
}

#Preview("Empty") {
    StateView(kind: .empty(title: "No saved frames yet", message: "Frames you save will appear here.", systemImage: "heart"))
        .background(SunniesColor.backgroundPrimary)
}

#Preview("Error") {
    StateView(kind: .error(title: "Something went wrong", message: "We couldn’t reach the analysis service.", retry: {}))
        .background(SunniesColor.backgroundPrimary)
}

#Preview("Loading") {
    StateView(kind: .loading(message: "Reading visible details…"))
        .background(SunniesColor.backgroundPrimary)
}
