import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    @Published var movie: Movie?
    
    private let watchlistService = WatchlistService.shared
    private let movieDetailsService = MovieDetailsService()
    private var cancellables = Set<AnyCancellable>()
    
    init(movie: Movie?) {
        self.movie = movie
        addSubscribers()
    }
    
    func addSubscribers() {
        watchlistService.$savedMovies
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                // Trigger UI update
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    var isInWatchlist: Bool {
        guard let movie else { return false }
        return watchlistService.isInWatchlist(movie: movie)
    }
    
    var isWatched: Bool {
        guard let movie else { return false }
        return watchlistService.isWatched(movie: movie)
    }
    
    func updateWatchlist(state: MovieState = .watchlist, removeFromSavedMovies: Bool = false) {
        guard let movie else { return }
        watchlistService.updateWatchlist(movie: movie, state: state, removeFromSavedMovies: removeFromSavedMovies)
    }
    
    // needed only for SavedMovie - response from /discover/movies gives movie details as well
    func loadMovieDetail() async {
        guard let movie, movie.hasFullyDetail == false else { return }
        do {
            let response = try await movieDetailsService.loadMovieDetails(id: movie.id)
            
            await MainActor.run {
                self.movie = response
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}
