import SwiftUI

struct WatchlistView: View {
    @ObservedObject var vm: WatchlistViewModel
    @State var selectedIndex: Int = 0
    
    var filteredMovies: [Movie] {
        switch selectedIndex {
        case 0:
            return vm.savedMovies.filter { $0.state == .watchlist }
        case 1:
            return vm.savedMovies.filter { $0.state == .watched }
        default:
            return []
        }
    }
    
    var body: some View {
        ScrollView {
            SegmentedPicker(selectedIndex: $selectedIndex)
                .fixedSize(horizontal: false, vertical: true)
            VStack(alignment: .leading, spacing: 8) {
                if filteredMovies.isEmpty {
                    Text("No movies in this category")
                        .font(.title2)
                        .foregroundStyle(Color.appSecondary)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    ForEach(filteredMovies) { movie in
                        NavigationLink(value: movie) {
                            SavedMovieCardView(movie: movie) {
                                // onDelete
                                vm.updateWatchlist(movie: movie, removeFromSavedMovies: true)
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }    .navigationDestination(for: Movie.self) { movie in
            MovieDetailView(vm: MovieDetailViewModel(movie: movie))
        }
        .padding()
        .animation(.easeInOut, value: filteredMovies)
        .navigationTitle("My movies")
    }
}

#Preview {
    WatchlistView(vm: WatchlistViewModel())
}
