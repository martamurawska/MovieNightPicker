import Foundation
import Combine

class MoviesDataService {
    func loadMovies(page: Int = 1, genreIds: [Int]? = nil, watchProvider: Int? = nil, language: String? = nil) async throws -> MoviesResponse {
        let request = RequestBuilder.discoverMovies(page: page, genreIds: genreIds, watchProvider: watchProvider, language: language)
        return try await NetworkManager.fetchData(for: request)
    }
    
    func searchMovie(page: Int, query: String) async throws -> MoviesResponse {
        let request = RequestBuilder.searchMovie(page: page, query: query)
        return try await NetworkManager.fetchData(for: request)
    }

}

