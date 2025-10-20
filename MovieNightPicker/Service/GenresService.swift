import Foundation
import Combine

class GenresService {
    func getGenres() async throws -> GenreResponse {
        let request = RequestBuilder.getGenres()
        return try await NetworkManager.fetchData(for: request)
    }
}
