import Foundation

struct RequestBuilder {
    static let baseURL = "https://api.themoviedb.org/3"
    static let apiKey = Constants.API_KEY

    /// Centralized request builder
    private static func makeRequest(path: String, queryItems: [URLQueryItem] = []) -> URLRequest? {
        guard var components = URLComponents(string: baseURL + path) else { return nil }
        components.queryItems = queryItems
        components.queryItems?.append(URLQueryItem(name: "language", value: "en-US"))

        guard let url = components.url else { return nil }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        return request
    }

    /// Discover movies endpoint
    /// genreIds and watchProvider parameter in case user applies filters
    static func discoverMovies(page: Int = 1, genreIds: [Int]? = nil, watchProvider: Int? = nil) -> URLRequest? {
        var queryItems = [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
        ]
        
        // add genre filter
        if let genreIds, !genreIds.isEmpty {
            let genreIdsString = genreIds.map { String($0) }.joined(separator: ",")
            queryItems.append(URLQueryItem(name: "with_genres", value: genreIdsString))
        }
        
        // add platform filter
        if let watchProvider {
            queryItems.append(URLQueryItem(name: "with_watch_providers", value: "\(watchProvider)"))
            queryItems.append(URLQueryItem(name: "watch_region", value: Locale.current.region?.identifier))
        }
        
        return makeRequest(path: "/discover/movie", queryItems: queryItems)
    }
    
    /// search movie endpoint
    static func searchMovie(page: Int = 1, query: String) -> URLRequest? {
        let queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        return makeRequest(path: "/search/movie", queryItems: queryItems)
    }

    /// Get genres endpoint
    static func getGenres() -> URLRequest? {
        makeRequest(path: "/genre/movie/list")
    }
    
    /// Get movie details endpoint
    static func getMovieDetails(id: Int) -> URLRequest? {
        makeRequest(path: "/movie/\(id)")
    }
}
