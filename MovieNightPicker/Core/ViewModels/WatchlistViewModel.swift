import Foundation
import Combine

class WatchlistViewModel: ObservableObject {
    @Published var savedMovies: [Movie] = []
    
    private let watchlistService = WatchlistService.shared
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        watchlistService.$savedMovies
            .map { entities in
                entities.compactMap { $0.toMovie() }
            }
        
            .sink { [weak self] mapped in
                self?.savedMovies = mapped
            }
            .store(in: &cancellables)
    }
    
    func updateWatchlist(movie: Movie, state: MovieState = .watchlist, removeFromSavedMovies: Bool = false) {
        watchlistService.updateWatchlist(movie: movie, state: state, removeFromSavedMovies: removeFromSavedMovies)
    }
}
