import SwiftUI

struct WheelSelector<Item: SelectableItem>: View {
    @Binding var selection: Item?
    let items: [Item]
    let title: String

    @State private var showPicker = false

    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .font(.title3)
                .fontWeight(.medium)
                .foregroundStyle(Color.appPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)
            Button {
                showPicker = true
            } label: {
                HStack {
                    Text(selection?.name ?? "All")
                        .foregroundStyle(selection == nil ? .appPrimary : Color.appPrimary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.appSecondary.opacity(0.2))
                .cornerRadius(20)
            }
        }
        .sheet(isPresented: $showPicker) {
            sheet
        }
    }
    
    var sheet: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") { showPicker = false }
                    .bold()
            }
            .padding()

            Picker(title, selection: $selection) {
                Text("All").tag(Optional<Item>.none)
                ForEach(items) { item in
                    Text(item.name).tag(Optional(item))
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
        }
        .presentationDetents([.height(300)])
    }
}

#Preview {
    WheelSelector(selection: .constant(nil), items: [Genre(id: 2, name: "lol")], title: "Genre")
        .padding()
}
