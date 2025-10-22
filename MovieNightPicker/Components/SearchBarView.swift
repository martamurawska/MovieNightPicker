import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(searchText.isEmpty ? .secondaryText : .accent)
            TextField("Search by name", text: $searchText)
                .foregroundStyle(.textPrimary)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding() // for tapable area
                        .offset(x: 10)
                        .foregroundStyle(Color.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.background)
                .shadow(color: .accent.opacity(0.15), radius: 10, x: 0, y: 0)
        )
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
