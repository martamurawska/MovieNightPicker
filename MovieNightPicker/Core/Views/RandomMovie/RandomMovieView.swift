import SwiftUI

struct RandomMovieView: View {
    @ObservedObject var vm: DiscoverViewModel
    var body: some View {
        
        if let movie = vm.randomMovie, !vm.isLoading {
            VStack(spacing: 16) {
                DiscoverCardView(movie: movie)
                    .animation(.easeInOut, value: movie)
                HStack {
                    CustomButton(label: "Spin again", style: .primary, icon: "arrow.trianglehead.counterclockwise", expanded: false) {
                        vm.randomMovie = nil
                        vm.onButtonTapped()
                    }
                    CustomButton(label: vm.isInWatchlist ? "In Watchlist" : "Add to Watchlist", style: vm.isInWatchlist ? .secondaryOutlined: .outlined, icon: vm.isInWatchlist ? "checkmark" : "plus", disabled: vm.isWatched, expanded: true) {
                        vm.updateWatchlist(state: .watchlist)
                    }
                }
            }.padding()
        } else if vm.isLoading {
            LoadingMovieView()
        }
    }
    
    var button: some View {
        Button {
            vm.updateWatchlist(state: .watched, remove: vm.isWatched)
        } label: {
            Image(systemName: vm.isWatched ? "eye.fill" : "eye")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .padding(12)
                .foregroundStyle(vm.isWatched ? Color.background : Color.textPrimary)
                .background(vm.isWatched ? Color.appPrimary.opacity(0.5) : Color.surfaceBackground.opacity(0.5))
                .cornerRadius(30)
        }
        .padding()
    }
}

#Preview {
    RandomMovieView(vm: DiscoverViewModel(randomMovie: MockedMovie.movie))
}
