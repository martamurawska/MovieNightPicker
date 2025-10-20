import SwiftUI

struct CustomButton: View {
    let label: String
    let style: ButtonStyle
    let icon: String?
    let disabled: Bool
    let expanded: Bool
    let onTap: (() -> Void)?
    
    init(label: String, style: ButtonStyle, icon: String? = nil, disabled: Bool = false, expanded: Bool = true, onTap: (() -> Void)? = nil) {
        self.label = label
        self.style = style
        self.icon = icon
        self.disabled = disabled
        self.expanded = expanded
        self.onTap = onTap
    }
    
    var body: some View {
        Button {
            onTap?()
        } label: {
            HStack(spacing: 12) {
                if let icon {
                    Image(systemName: icon)
                }
                Text(label)
                    .font(.headline)
                    .fontWeight(.bold)
            }.foregroundStyle(style.fontColor)
                .padding()
        }
        .disabled(disabled)
        .frame(maxWidth: expanded ? .infinity : .none)
        .background(style.background.opacity(disabled ? 0.3 : 1))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(style.strokeColor, lineWidth: 1)
        )
    }
}


#Preview {
    CustomButton(label: "Button", style: .primary)
    CustomButton(label: "Button", style: .secondary, icon: "trash")
    CustomButton(label: "Button", style: .primary, icon: "trash", disabled: true)
    CustomButton(label: "Watched", style: .outlined, icon: "eye", expanded: false)
}
