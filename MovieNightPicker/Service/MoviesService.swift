import Foundation
import Combine

class MoviesDataService {
    func loadMovies(page: Int, genreIds: [Int]? = nil, watchProvider: Int? = nil) async throws -> MoviesResponse {
        let request = RequestBuilder.discoverMovies(page: page, genreIds: genreIds, watchProvider: watchProvider)
        return try await NetworkManager.fetchData(for: request)
    }
    
    func searchMovie(page: Int, query: String) async throws -> MoviesResponse {
        let request = RequestBuilder.searchMovie(page: page, query: query)
        return try await NetworkManager.fetchData(for: request)
    }

}

