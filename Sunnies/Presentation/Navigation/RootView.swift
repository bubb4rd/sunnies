import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Label("Discover", systemImage: "sparkles") }
            SavedCollectionView()
                .tabItem { Label("Saved", systemImage: "heart") }
        }
    }
}

#Preview {
    RootView()
}
