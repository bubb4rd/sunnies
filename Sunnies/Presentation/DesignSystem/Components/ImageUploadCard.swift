import SwiftUI

/// Dashed drop-zone style card prompting the user to pick an image.
struct ImageUploadCard<Actions: View>: View {
    let title: String
    let message: String
    @ViewBuilder let actions: Actions

    var body: some View {
        VStack(spacing: SunniesSpacing.l) {
            Image(systemName: "eyeglasses")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(SunniesColor.accent)
                .accessibilityHidden(true)

            VStack(spacing: SunniesSpacing.s) {
                Text(title)
                    .font(SunniesTypography.sectionTitle)
                    .foregroundStyle(SunniesColor.textPrimary)
                Text(message)
                    .font(SunniesTypography.body)
                    .foregroundStyle(SunniesColor.textSecondary)
            }
            .multilineTextAlignment(.center)
            .accessibilityElement(children: .combine)

            VStack(spacing: SunniesSpacing.s) {
                actions
            }
        }
        .padding(SunniesSpacing.l)
        .padding(.vertical, SunniesSpacing.m)
        .frame(maxWidth: .infinity)
        .background(SunniesColor.surface, in: RoundedRectangle(cornerRadius: SunniesRadius.large))
        .overlay(
            RoundedRectangle(cornerRadius: SunniesRadius.large)
                .strokeBorder(SunniesColor.separator, style: StrokeStyle(lineWidth: 1.5, dash: [6, 6]))
        )
    }
}

#Preview {
    ImageUploadCard(title: "Add a photo", message: "A screenshot or photo where the glasses are visible.") {
        Button("Choose photo") {}.buttonStyle(.sunniesPrimary)
    }
    .padding()
    .background(SunniesColor.backgroundPrimary)
}
