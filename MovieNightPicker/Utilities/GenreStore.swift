class GenreStore {
    static let shared = GenreStore()
    private let genresService = GenresService()
    private var genresById: [Int: String] = [:]
    var genres: [Genre] = []
    
    init() {
        Task {
            await getGenres()
        }
    }
    
    func getGenres() async {
            guard let response = try? await genresService.getGenres() else { return }
            genres = response.genres
            genresById = Dictionary(uniqueKeysWithValues: genres.map { ($0.id, $0.name) })
    }
    
    func name(for id: Int) -> String? {
        return genresById[id]
    }
    
    func genres(from ids: [Int]) -> [Genre] {
       return ids.compactMap {
                if let name = name(for: $0) {
                    return Genre(id: $0, name: name)
                }
                return nil
            }
      }
}
