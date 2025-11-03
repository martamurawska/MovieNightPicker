import Foundation

struct NetworkManager {
    static func fetchData<T: Decodable>(for request: URLRequest?) async throws -> T {
        guard let request = request else { throw NetworkError.badRequest }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        guard !data.isEmpty else { throw NetworkError.emptyData }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
}

enum NetworkError: Error {
    case badRequest
    case emptyData
    case decodingFailed
    
    var description: String {
        switch self {
        case .badRequest: return "There was network error"
        case .decodingFailed: return "Decoding Failed"
        case .emptyData: return "No movie found for given filters"
        }
    }
}
