import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var vm: MovieDetailViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 8) {
                if let movie = vm.movie {
                    MovieImageView(movie: movie)
                        .cornerRadius(20)
                        .padding(.bottom, 8)
                    Text(movie.title)
                        .font(.title)
                        .foregroundStyle(Color.appPrimary)
                        .bold()
                    HStack(spacing: 8) {
                        Image(systemName: "calendar")
                        Text(movie.releaseYear)
                            .font(.subheadline)
                    }
                    .foregroundStyle(.secondaryText)
                    FlowLayout {
                        ForEach(movie.mappedGenres, id: \.self) { genre in
                            GenreTag(genre: genre, style: .primary, size: .small)
                        }
                    }
                    Text(movie.overview)
                    Spacer(minLength: 4)
                    buttons
                        .padding(.bottom)
                }
            }
        }
        .padding()
        .background(.secondaryText.opacity(0.15))
        .onAppear {
            Task {
                await vm.loadMovieDetail()
            }
        }
        
    }
    
    var buttons: some View {
        VStack(spacing: 12) {
            watchlistButton
            watchedButton
        }
        .animation(.easeInOut(duration: 0.3), value: vm.isWatched)
    }
    
    var watchlistButton: some View {
        CustomButton(label: vm.isInWatchlist ? "In Watchlist" : "Add to Watchlist", style: vm.isInWatchlist ? .secondary : .primary, icon: vm.isInWatchlist ? "checkmark" : "plus", disabled: vm.isWatched) {
            vm.updateWatchlist(state: .watchlist, removeFromSavedMovies: false)
        }
    }
    
    var watchedButton: some View {
        CustomButton(label: vm.isWatched ? "Watched" : "Mark as Watched", style: vm.isWatched ? .secondaryOutlined : .outlined, icon: "eye") {
            vm.updateWatchlist(state: .watched, removeFromSavedMovies: vm.isWatched)
        }
    }
}

#Preview {
    NavigationView {
        MovieDetailView(vm: MovieDetailViewModel(movie: MockedMovie.movie))
    }
}
