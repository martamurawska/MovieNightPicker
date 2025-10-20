import Foundation
import SwiftUI

enum ButtonStyle {
    case primary
    case secondary
    case outlined
    case secondaryOutlined
}

extension ButtonStyle {
    var fontColor: Color {
        switch self {
        case .primary:
            return .background
        case .secondary:
            return .appPrimary
        case .outlined:
            return .appPrimary
        case .secondaryOutlined:
            return .appPrimary
        }
    }
    
    var background: Color {
        switch self {
        case .primary:
            return .appPrimary
        case .secondary:
            return .appSecondary
        case .outlined:
            return .clear
        case .secondaryOutlined:
            return .appSecondary
        }
    }
    
    var strokeColor: Color {
        switch self {
        case .primary, .secondary:
            return .clear
        case .outlined, .secondaryOutlined:
            return .appPrimary
        }
    }
}
