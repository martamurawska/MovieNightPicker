import SwiftUI

enum TagStyle: CaseIterable {
    case primary
    case secondary
    case selected
}

extension TagStyle {
    var backgroundColor: Color {
        switch self {
        case .primary:
            Color.surface
        case .selected:
            Color.appPrimary
        case .secondary:
            Color.background
        }
    }
    
    var strokeColor: Color {
        switch self {
        case .primary:
            Color.textPrimary
        case .selected:
            Color.appPrimary
        case .secondary:
            Color.accent
        }
    }
    
    var textColor: Color {
        switch self {
        case .primary:
            Color.textPrimary
        case .selected:
            Color.background
        case .secondary:
            Color.accent
        }
    }
    
    var fontWeight: Font.Weight {
        switch self {
        case .secondary, .selected:
                .medium
        default:
                .regular
        }
    }
}
