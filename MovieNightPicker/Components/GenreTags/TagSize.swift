import SwiftUI

enum TagSize: CaseIterable {
    case small
    case medium
    case large
}

extension TagSize {
    var font: Font {
        switch self {
        case .small:
            Font.caption
        case .medium:
            Font.body
        case .large:
            Font.title2
        }
    }
}
