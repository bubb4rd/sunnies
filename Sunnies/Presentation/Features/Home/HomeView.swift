import SwiftUI

struct HomeView: View {
    @State private var isSearchFlowPresented = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: SunniesSpacing.xl) {
                    hero

                    VStack(alignment: .leading, spacing: SunniesSpacing.m) {
                        Button {
                            isSearchFlowPresented = true
                        } label: {
                            Label("Find these glasses", systemImage: "eyeglasses")
                        }
                        .buttonStyle(.sunniesPrimary)

                        Text("Nothing is uploaded until you choose to analyze a photo.")
                            .font(SunniesTypography.caption)
                            .foregroundStyle(SunniesColor.textTertiary)
                    }
                }
                .padding(.horizontal, SunniesSpacing.l)
                .padding(.vertical, SunniesSpacing.xl)
            }
            .background(SunniesColor.backgroundPrimary)
            .toolbar(.hidden, for: .navigationBar)
        }
        .fullScreenCover(isPresented: $isSearchFlowPresented) {
            SearchFlowPlaceholderView()
        }
    }

    private var hero: some View {
        VStack(alignment: .leading, spacing: SunniesSpacing.m) {
            Text("Sunnies")
                .font(SunniesTypography.badge)
                .textCase(.uppercase)
                .tracking(2)
                .foregroundStyle(SunniesColor.accent)
                .accessibilityHidden(true)

            Text("See glasses you like.\nFind the pair.")
                .font(SunniesTypography.largeDisplay)
                .foregroundStyle(SunniesColor.textPrimary)
                .accessibilityAddTraits(.isHeader)

            Text("Upload a photo or screenshot of glasses you like. Sunnies will help you identify them or find similar styles you can shop.")
                .font(SunniesTypography.body)
                .foregroundStyle(SunniesColor.textSecondary)
        }
    }
}

#Preview {
    HomeView()
}
