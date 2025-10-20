import Foundation
import Combine

class BrowseMoviesViewModel: ObservableObject {
    @Published var allMovies: [Movie] = []
    @Published var savedMovies: [Movie] = []
    @Published var selectedGenres: [Int] = []
    @Published var genres: [Genre] = GenreStore.shared.genres
    
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
    
    func loadMovies(reset: Bool = false, selectedGenres: [Int]? = nil) async {
        if reset {
            await MainActor.run {
                currentPage = 0
                totalPages = 1
                isLoading = false
                allMovies.removeAll()
            }
        }
        
        guard !isLoading, currentPage <= totalPages else { return }
        let nextPage = currentPage + 1
        do {
            let response = try await moviesDataService.loadMovies(page: nextPage, genreIds: selectedGenres)
            let returnedMovies = await mapGenresToMovies(movies: response.results)
            
            allMovies.append(contentsOf: returnedMovies)
            self.currentPage = response.page
            self.totalPages = response.totalPages
            self.isLoading = false
            
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func shouldLoadPagination(id: Int) {
        Task {
            print("before check")
            if allMovies.last?.id == id {
                print("after check")
                await loadMovies(selectedGenres: selectedGenres)
            }
        }
    }
    
    func mapGenresToMovies(movies: [Movie]) async  -> [Movie] {
        let mapped = movies.map { movie in
            let genreNames = movie.mappedGenres
            return movie.updateGenres(genres: genreNames)
        }
        return mapped
    }
    
    func toggleGenre(_ genreId: Int) {
        if selectedGenres.contains(genreId) {
            selectedGenres.removeAll { $0 == genreId }
        } else {
            selectedGenres.append(genreId)
        }
        
        Task {
            await loadMovies(reset: true, selectedGenres: selectedGenres)
        }
    }
    
    func clearAllFilter() {
        selectedGenres.removeAll()
        Task {
            await loadMovies(reset: true, selectedGenres: selectedGenres)
        }
    }
}
