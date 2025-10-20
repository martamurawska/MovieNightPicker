import SwiftUI

//https://stackoverflow.com/questions/60804512/swiftui-create-a-custom-segmented-control-also-in-a-scrollview
struct SegmentedPicker: View {
    @Binding var selectedIndex: Int
    var titles = ["To Watch", "Watched"]
    @State private var frames = Array<CGRect>(repeating: .zero, count: 3)
    
    var body: some View {
        VStack {
            ZStack {
                HStack(spacing: 10) {
                    ForEach(titles.indices, id: \.self) { index in
                        Button(action: { selectedIndex = index }) {
                            Text(titles[index])
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(Color.textPrimary)
                        }
                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                            .background(
                                GeometryReader { geo in
                                    Color.clear
                                        .onChange(of: geo.size) {
                                        self.setFrame(index: index, frame: geo.frame(in: .global))
                                    }
                                }
                            )
                    }
                }
                .background(
                    Capsule().fill(Color.appSecondary)
                    .frame(width: self.frames[self.selectedIndex].width,
                           height: self.frames[self.selectedIndex].height, alignment: .topLeading)
                    .offset(x: self.frames[self.selectedIndex].minX - self.frames[0].minX)
                    .shadow(color: Color.appPrimary.opacity(0.15), radius: 10, x: 0, y: 0)
                    , alignment: .leading
                )
            }
            .animation(.default, value: selectedIndex)
            .padding(4)
            .background(Capsule().fill(Color.surface.opacity(0.15)))
           
        }
    }
    
    func setFrame(index: Int, frame: CGRect) {
        self.frames[index] = frame
    }
}

#Preview {
    NavigationStack {
        SegmentedPicker(selectedIndex: .constant(1))
    }
}
