import Foundation
import Combine

class DiscoverViewModel: ObservableObject {
    @Published var randomMovie: Movie?
    /// in case user personalize generation
    @Published var selectedGenre: Genre?
    @Published var selectedPlatform: Platform?
    @Published var isLoading: Bool = false
    
    let moviesDataService = MoviesDataService()
    private let watchlistService = WatchlistService.shared
    private var cancellables = Set<AnyCancellable>()
    
    var isInWatchlist: Bool {
        guard let randomMovie else { return false }
        return watchlistService.isInWatchlist(movie: randomMovie)
    }
    
    var isWatched: Bool {
        guard let randomMovie else { return false }
        return watchlistService.isWatched(movie: randomMovie)
    }
    
    init(randomMovie: Movie? = nil) {
        self.randomMovie = randomMovie
        
        watchlistService.$savedMovies
            .sink { [weak self] _ in
                // Trigger UI update
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func getRandomMovie() async {
        let randomNumber = Int.random(in: 1...1000)
        // one page has 20 results
        let randomPage = randomNumber/20
        let randomMovieIndex = randomNumber % 20
        
        do {
            let response = try await moviesDataService.loadMovies(page: randomPage, genreIds: selectedGenre.map { [$0.id] } ?? nil, watchProvider: selectedPlatform?.id ?? nil)
            let movie = response.results[randomMovieIndex]
            let genreNames = movie.mappedGenres
            
            // loading image so its immediately ready for DiscoverMovieCard, result not needed yet
            await MovieImageService(movie: movie).getMovieImage()
            
            await MainActor.run {
                self.randomMovie = movie.updateGenres(genres: genreNames)
                self.isLoading = false
            }
        } catch {
            print("Error fetching \(error)")
        }
        
    }
    
    func toggleGenre(_ genre: Genre) {
        if selectedGenre?.id == genre.id {
            selectedGenre = nil
        } else {
            selectedGenre = genre
        }
    }
    
    func togglePlatform(_ platform: Platform) {
        if selectedPlatform?.id == platform.id {
            selectedPlatform = nil
        } else {
            selectedPlatform = platform
        }
    }
    
    func onButtonTapped() {
        isLoading = true
        Task {
            await getRandomMovie()
        }
    }
    
    func updateWatchlist(state: MovieState, remove: Bool = false) {
        guard let randomMovie else { return }
        watchlistService.updateWatchlist(movie: randomMovie, state: state, removeFromSavedMovies: remove)
    }
}
