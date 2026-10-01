import SwiftUI

/// Stand-in for the crop step (M2). Shows the image that will be cropped.
struct CropPlaceholderView: View {
    let image: NormalizedImage

    var body: some View {
        VStack(spacing: SunniesSpacing.l) {
            Image(image.cgImage, scale: 1, label: Text("Photo to crop"))
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 320)
                .clipShape(RoundedRectangle(cornerRadius: SunniesRadius.large))

            StateView(kind: .empty(
                title: "Cropping is coming next",
                message: "You’ll be able to center the glasses for better matches.",
                systemImage: "crop"
            ))
        }
        .padding(SunniesSpacing.l)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(SunniesColor.backgroundPrimary)
        .navigationTitle("Crop")
        .navigationBarTitleDisplayMode(.inline)
    }
}
