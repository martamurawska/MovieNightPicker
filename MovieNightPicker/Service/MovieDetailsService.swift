import Foundation

class MovieDetailsService {
    func loadMovieDetails(id: Int) async throws -> Movie {
        let request = RequestBuilder.getMovieDetails(id: id)
        return try await NetworkManager.fetchData(for: request)
    }
    
}
