import Foundation
import Combine

class BrowseMoviesViewModel: ObservableObject {
    @Published var allMovies: [Movie] = []
    @Published var savedMovies: [Movie] = []
    @Published var selectedGenres: [Int] = []
    @Published var genres: [Genre] = GenreStore.shared.genres
    
    @Published var searchText: String = ""
    private var searchTask: Task<Void, Never>?
    
    private let moviesDataService = MoviesDataService()
    
    // needed for pagination
    private var currentPage = 0
    private var totalPages = 1
    var isLoading = false
    
    init() {
        Task {
            await loadMovies()
        }
    }
    
    func toggleGenre(_ genreId: Int) {
        if selectedGenres.contains(genreId) {
            selectedGenres.removeAll { $0 == genreId }
        } else {
            selectedGenres.append(genreId)
        }
        
        Task { await refreshMovies() }
    }
    
    func clearAllFilters() {
        selectedGenres.removeAll()
        Task { await refreshMovies() }
    }
    
    func shouldLoadMore(id: Int) {
        guard allMovies.last?.id == id, !isLoading else { return }
        Task {
            if searchText.isEmpty {
                await loadMovies()
            } else {
                await searchMovies()
            }
        }
    }
    
    func onSearchQueryChange() {
        searchTask?.cancel()
        
        guard !searchText.isEmpty else {
            Task { await refreshMovies() }
            return
        }
        
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 400_000_000)
            guard !Task.isCancelled else { return }
            await searchMovies(reset: true)
        }
    }
    
    // MARK: - Private
    private func loadMovies(reset: Bool = false) async {
        await fetchMovies(reset: reset) { page in
            try await moviesDataService.loadMovies(page: page, genreIds: selectedGenres)
        }
    }
    
    private func searchMovies(reset: Bool = false) async {
        await fetchMovies(reset: reset) { page in
            try await moviesDataService.searchMovie(page: page, query: searchText)
        }
    }
    
    private func fetchMovies(reset: Bool, fetchPage: (Int) async throws -> MoviesResponse) async {
        if reset { await resetPagination() }
        guard !isLoading, currentPage < totalPages else { return }
        
        isLoading = true
        let nextPage = currentPage + 1
        
        do {
            let response = try await fetchPage(nextPage)
            let movies = mapGenres(for: response.results)
            
            await MainActor.run {
                allMovies.append(contentsOf: movies)
                currentPage = response.page
                totalPages = response.totalPages
            }
        } catch {
            print("Error fetching movies: \(error)")
        }
        isLoading = false
    }
    
    private func mapGenres(for movies: [Movie]) -> [Movie] {
        movies.map { movie in
            movie.updateGenres(genres: movie.mappedGenres)
        }
    }
    
    @MainActor private func resetPagination() {
        currentPage = 0
        totalPages = 1
        isLoading = false
        allMovies.removeAll()
    }
    
    private func refreshMovies() async {
        await loadMovies(reset: true)
    }
}
