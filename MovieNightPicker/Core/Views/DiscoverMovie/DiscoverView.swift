import SwiftUI

struct DiscoverView: View {
    @ObservedObject var vm: DiscoverViewModel
    @State var showMovie: Bool = false
    @State private var selectedPlatform: Platform?
    
    var body: some View {
        ZStack {
            Color.surface.ignoresSafeArea(edges: .top)
            card
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .background(
                    NavigationLink(destination: RandomMovieView(vm: vm),
                                   isActive: $showMovie,
                                   label: { EmptyView() }
                                  )
                    .hidden()
                )
        }
    }
    
    var title: some View {
        Text("Discover your next favorite movie!")
            .font(.title)
            .foregroundStyle(Color.appPrimary)
            .bold()
            .multilineTextAlignment(.center)
            .padding(.top, 32)
    }
    
    var button: some View {
        CustomButton(label: "Generate random movie", style: .primary) {
            vm.onButtonTapped()
            showMovie = true
        }
    }
    
    var card: some View {
        VStack(spacing: 56) {
            title
            VStack(spacing: 24) {
                WheelSelector(selection: $vm.selectedGenre, items: GenreStore.shared.genres, title: "Genre")
                WheelSelector(selection: $vm.selectedPlatform, items: allPlatforms, title: "Streaming platform")
                WheelSelector(selection: $vm.selectedLanguage, items: allLanguages, title: "Origin language")
                button
            }
            .padding(32)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.accent, lineWidth: 1)
                
            )
            .background(Color.background)
            .cornerRadius(20)
            .shadow(color: .secondaryText.opacity(0.15), radius: 10, x: 0, y: 0)
        }
    }
}

#Preview {
    DiscoverView(vm: DiscoverViewModel())
}



