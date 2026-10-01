import SwiftUI

/// Stand-in for the capture → crop → intent → analysis → results flow (M1–M4).
struct SearchFlowPlaceholderView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            StateView(kind: .empty(
                title: "Photo search is coming soon",
                message: "Choosing a photo and finding matching frames arrives in the next build.",
                systemImage: "photo.on.rectangle"
            ))
            .background(SunniesColor.backgroundPrimary)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    SearchFlowPlaceholderView()
}
