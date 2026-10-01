import SwiftUI

/// Communicates how certain a result is. Always shows text and an icon,
/// never color alone.
struct ConfidenceBadge: View {
    let confidence: MatchConfidence

    struct Content: Equatable {
        let label: String
        let systemImage: String
        let tint: Color
    }

    static func content(for confidence: MatchConfidence) -> Content {
        switch confidence {
        case .exact:
            Content(label: "Exact match", systemImage: "checkmark.seal.fill", tint: SunniesColor.confidenceExact)
        case .likely:
            Content(label: "Likely match", systemImage: "checkmark.circle", tint: SunniesColor.confidenceLikely)
        case .similar:
            Content(label: "Similar styles", systemImage: "square.on.square", tint: SunniesColor.confidenceSimilar)
        case .styleOnly:
            Content(label: "Style analysis", systemImage: "eyeglasses", tint: SunniesColor.textSecondary)
        case .insufficientEvidence:
            Content(label: "Couldn’t identify", systemImage: "eye.slash", tint: SunniesColor.textSecondary)
        }
    }

    var body: some View {
        let content = Self.content(for: confidence)
        Label(content.label, systemImage: content.systemImage)
            .font(SunniesTypography.badge)
            .foregroundStyle(content.tint)
            .padding(.horizontal, SunniesSpacing.m - SunniesSpacing.xs)
            .padding(.vertical, SunniesSpacing.xs + 2)
            .background(content.tint.opacity(0.14), in: Capsule())
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Result confidence: \(content.label)")
    }
}

#Preview {
    VStack(alignment: .leading, spacing: SunniesSpacing.s) {
        ForEach(MatchConfidence.allCases, id: \.self) { ConfidenceBadge(confidence: $0) }
    }
    .padding()
    .background(SunniesColor.backgroundPrimary)
}
