import SwiftUI

/// Saved collection. Loading from the repository arrives with M5 persistence.
struct SavedCollectionView: View {
    var body: some View {
        NavigationStack {
            StateView(kind: .empty(
                title: "No saved frames yet",
                message: "Frames you save will appear here, ready to revisit.",
                systemImage: "heart"
            ))
            .background(SunniesColor.backgroundPrimary)
            .navigationTitle("Saved")
        }
    }
}

#Preview {
    SavedCollectionView()
}
