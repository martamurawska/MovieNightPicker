import Foundation
import SwiftUI
import Combine

class MovieImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let movie: Movie
    private let dataService: MovieImageService
    
    init(movie: Movie) {
        self.movie = movie
        dataService = MovieImageService(movie: movie)
        isLoading = true
        loadImage()
    }
    
    func loadImage() {
        Task {
            if let uiImage = await dataService.getMovieImage() {
                await MainActor.run {
                    self.image = uiImage
                    self.isLoading = false
                }
            } else {
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }
}
