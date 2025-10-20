import Foundation
import CoreData

class WatchlistService {
    private let container: NSPersistentContainer
    private let containerName: String = "WatchlistContainer"
    private let entityName: String = "SavedMovie"
    
    static let shared = WatchlistService()
    
    @Published var savedMovies: [SavedMovie] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error {
                print("Error loading core data \(error)")
            }
            
            self.getWatchlist()
        }
    }
    
    // one public function for all actions
    func updateWatchlist(movie: Movie, state: MovieState, removeFromSavedMovies: Bool) {
        // check if the movie is saved
        if let entity = savedMovies.first(where: {$0.id == movie.id}) {
            if removeFromSavedMovies {
                delete(entity: entity)
            } else {
                update(entity: entity, state: state)
            }
        } else {
            add(movie: movie, state: state)
        }
        
    }
    
    // - MARK: private
    private func getWatchlist() {
        let request = NSFetchRequest<SavedMovie>(entityName: entityName)
        do {
            savedMovies = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio entities \(error)")
        }
    }
    
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("error saving to core data \(error)")
        }
    }
    
    private func add(movie: Movie, state: MovieState) {
        let savedMovie = SavedMovie(context: container.viewContext)
        savedMovie.id = Int64(movie.id)
        savedMovie.state = state
        savedMovie.genreIds = movie.genreIds ?? []
        savedMovie.pathPoster = movie.posterPath
        savedMovie.title = movie.title
      
        print(savedMovie.genres)
        applyChanges()
    }
    
    private func update(entity: SavedMovie, state: MovieState) {
        entity.state = state
        applyChanges()
    }
    
    private func delete(entity: SavedMovie) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getWatchlist()
    }
}

extension WatchlistService {
    func isInWatchlist(movie: Movie) -> Bool {
        savedMovies.contains { $0.id == movie.id && $0.state == MovieState.watchlist }
    }
    
    func isWatched(movie: Movie) -> Bool {
        savedMovies.contains { $0.id == movie.id && $0.state == MovieState.watched }
    }
}
