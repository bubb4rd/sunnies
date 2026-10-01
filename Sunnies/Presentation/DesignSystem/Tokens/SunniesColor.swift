import SwiftUI
import UIKit

/// Raw brand scale. Views use the semantic `SunniesColor` tokens, not these.
enum SunniesPalette {
    static let primary50: UInt32 = 0xFEFBE6
    static let primary100: UInt32 = 0xFDF5C2
    static let primary200: UInt32 = 0xFBEC88
    static let primary300: UInt32 = 0xF9E44F
    /// Paris daisy yellow.
    static let primary400: UInt32 = 0xF8E11A
    static let primary500: UInt32 = 0xDCC205
    static let primary600: UInt32 = 0xB09603
    static let primary700: UInt32 = 0x846E06
    static let primary800: UInt32 = 0x5C4C0A
    static let primary900: UInt32 = 0x463708
    /// App background in dark mode. Darker than the original #3E2A05.
    static let primary950: UInt32 = 0x2A1C04
}

/// Semantic color tokens with light and dark variants.
/// Confidence colors must always be paired with an icon and text.
enum SunniesColor {
    static let backgroundPrimary = Color(light: 0xFBF8EF, dark: SunniesPalette.primary950)
    static let backgroundSecondary = Color(light: 0xF4EEDC, dark: 0x33240A)
    static let surface = Color(light: 0xFFFFFF, dark: 0x3A2A0E)
    static let surfaceElevated = Color(light: 0xFFFFFF, dark: 0x463410)

    static let textPrimary = Color(light: 0x1F1503, dark: 0xFBF6E6)
    static let textSecondary = Color(light: 0x5E5238, dark: 0xD6CBAE)
    static let textTertiary = Color(light: 0x7D7156, dark: 0xA89C80)

    /// Tint for text and icons. Yellow on cream fails contrast, so light mode
    /// uses a deeper shade of the brand color.
    static let accent = Color(light: SunniesPalette.primary700, dark: SunniesPalette.primary400)
    /// Fill for primary buttons; pair with `onAccent`.
    static let accentFill = Color(light: SunniesPalette.primary400, dark: SunniesPalette.primary400)
    static let onAccent = Color(light: SunniesPalette.primary950, dark: SunniesPalette.primary950)

    static let success = Color(light: 0x2E7D4F, dark: 0x7DD3A0)
    static let warning = Color(light: 0xA15C00, dark: 0xF5B755)
    static let error = Color(light: 0xB3261E, dark: 0xF2938C)

    static let confidenceExact = Color(light: 0x2E7D4F, dark: 0x7DD3A0)
    static let confidenceLikely = Color(light: 0x8A5A00, dark: 0xF2C14E)
    static let confidenceSimilar = Color(light: 0x3F6683, dark: 0xA9C6DE)

    static let separator = Color(light: 0xE6DFC9, dark: 0x4A3A1C)
}

private extension Color {
    init(light: UInt32, dark: UInt32) {
        self.init(uiColor: UIColor { traits in
            UIColor(rgb: traits.userInterfaceStyle == .dark ? dark : light)
        })
    }
}

private extension UIColor {
    convenience init(rgb: UInt32) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: 1
        )
    }
}
