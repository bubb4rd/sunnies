import SwiftUI

/// Dynamic Type text styles only, so every token scales with the user's setting.
/// Display and titles use New York (serif) for an editorial feel; body uses SF.
enum SunniesTypography {
    static let largeDisplay = Font.system(.largeTitle, design: .serif).weight(.semibold)
    static let screenTitle = Font.system(.title, design: .serif).weight(.semibold)
    static let sectionTitle = Font.system(.title3, design: .serif).weight(.semibold)
    static let body = Font.body
    static let caption = Font.footnote
    static let productMetadata = Font.subheadline
    static let badge = Font.caption.weight(.semibold)
    static let button = Font.headline
}

enum SunniesSpacing {
    static let xs: CGFloat = 4
    static let s: CGFloat = 8
    static let m: CGFloat = 16
    static let l: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
}

/// Corner radii. Use `Capsule()` for the full pill.
enum SunniesRadius {
    static let small: CGFloat = 8
    static let medium: CGFloat = 14
    static let large: CGFloat = 22
}

/// Minimum tap target from the Human Interface Guidelines.
enum SunniesHitTarget {
    static let minimum: CGFloat = 44
}

enum SunniesShadow {
    case card
    case elevated
    case imageOverlay

    fileprivate var opacity: Double {
        switch self {
        case .card: 0.08
        case .elevated: 0.16
        case .imageOverlay: 0.35
        }
    }

    fileprivate var radius: CGFloat {
        switch self {
        case .card: 8
        case .elevated: 18
        case .imageOverlay: 12
        }
    }

    fileprivate var yOffset: CGFloat {
        switch self {
        case .card: 2
        case .elevated: 8
        case .imageOverlay: 4
        }
    }
}

extension View {
    func sunniesShadow(_ shadow: SunniesShadow) -> some View {
        self.shadow(color: .black.opacity(shadow.opacity), radius: shadow.radius, x: 0, y: shadow.yOffset)
    }
}
