import SwiftUI

struct SectionHeader: View {
    let title: String
    var subtitle: String?

    var body: some View {
        VStack(alignment: .leading, spacing: SunniesSpacing.xs) {
            Text(title)
                .font(SunniesTypography.sectionTitle)
                .foregroundStyle(SunniesColor.textPrimary)
            if let subtitle {
                Text(subtitle)
                    .font(SunniesTypography.caption)
                    .foregroundStyle(SunniesColor.textSecondary)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isHeader)
    }
}

#Preview {
    SectionHeader(title: "Similar styles", subtitle: "Shapes and finishes close to your photo")
        .padding()
        .background(SunniesColor.backgroundPrimary)
}
