extension SavedMovie {
    var state: MovieState {
        get { MovieState(rawValue: stateRaw) ?? .watchlist }
        set { stateRaw = newValue.rawValue }
    }
    
    var genreIds: [Int] {
        get {
            guard let raw = genreIdsRaw else { return [] }
            return raw.split(separator: ",").compactMap { Int($0) }
        }
        set {
            genreIdsRaw = newValue.map { String($0) }.joined(separator: ",")
        }
    }
    
    // convert ids into full Genre objects for UI
    var genres: [Genre] {
        GenreStore.shared.genres(from: genreIds)
    }
    
    func toMovie() -> Movie {
        return Movie(adult: nil, backdropPath: nil, genreIds: genreIds, id: Int(self.id), originaLanguage: nil, originalTitle: nil, overview: "", popularity: nil, posterPath: self.pathPoster ?? "", releaseDate: nil, title: title ?? "", video: nil, voteAverage: nil, voteCount: nil, genres: genres, state: state)
    }
}
