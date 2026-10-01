import SwiftUI

/// Full-screen capture → crop → intent → analysis → results flow, kept apart
/// from tab navigation. Steps beyond image input arrive in M2–M4.
struct SearchFlowView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var path: [SearchFlowRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            ImageInputView { image in
                path.append(.crop(image))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
            .navigationDestination(for: SearchFlowRoute.self) { route in
                switch route {
                case .crop(let image):
                    CropPlaceholderView(image: image)
                }
            }
        }
    }
}

#Preview {
    SearchFlowView()
}
