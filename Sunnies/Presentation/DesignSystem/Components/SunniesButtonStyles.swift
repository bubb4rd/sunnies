import SwiftUI

struct SunniesPrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(SunniesTypography.button)
            .multilineTextAlignment(.center)
            .foregroundStyle(SunniesColor.onAccent)
            .padding(.horizontal, SunniesSpacing.l)
            .padding(.vertical, SunniesSpacing.m)
            .frame(maxWidth: .infinity, minHeight: SunniesHitTarget.minimum)
            .background(SunniesColor.accentFill, in: Capsule())
            .opacity(configuration.isPressed ? 0.85 : 1)
            .opacity(isEnabled ? 1 : 0.45)
    }
}

struct SunniesSecondaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(SunniesTypography.button)
            .multilineTextAlignment(.center)
            .foregroundStyle(SunniesColor.textPrimary)
            .padding(.horizontal, SunniesSpacing.l)
            .padding(.vertical, SunniesSpacing.m)
            .frame(maxWidth: .infinity, minHeight: SunniesHitTarget.minimum)
            .background(SunniesColor.surface, in: Capsule())
            .overlay(Capsule().strokeBorder(SunniesColor.separator, lineWidth: 1))
            .opacity(configuration.isPressed ? 0.7 : 1)
            .opacity(isEnabled ? 1 : 0.45)
    }
}

struct SunniesTextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(SunniesTypography.button)
            .foregroundStyle(SunniesColor.accent)
            .frame(minHeight: SunniesHitTarget.minimum)
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.6 : 1)
    }
}

extension ButtonStyle where Self == SunniesPrimaryButtonStyle {
    static var sunniesPrimary: Self { .init() }
}

extension ButtonStyle where Self == SunniesSecondaryButtonStyle {
    static var sunniesSecondary: Self { .init() }
}

extension ButtonStyle where Self == SunniesTextButtonStyle {
    static var sunniesText: Self { .init() }
}

#Preview {
    VStack(spacing: SunniesSpacing.m) {
        Button("Find these glasses") {}.buttonStyle(.sunniesPrimary)
        Button("Search again") {}.buttonStyle(.sunniesSecondary)
        Button("Not now") {}.buttonStyle(.sunniesText)
        Button("Disabled") {}.buttonStyle(.sunniesPrimary).disabled(true)
    }
    .padding()
    .background(SunniesColor.backgroundPrimary)
}
