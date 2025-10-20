import Foundation
import SwiftUI
import Combine

class MovieImageService {
    private let movie: Movie
    private let fileManager = LocalFileManager.instance // single ton instance
    private let folderName = "movie_images"
    private let imageName: String
    
    init(movie: Movie) {
        self.movie = movie
        self.imageName = movie.posterPath ?? ""
    }
    
    func downloadMovieImage() async throws -> UIImage {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500"), let postePath = movie.posterPath else { throw URLError(.badURL) }
        let posterURL = url.appendingPathComponent(postePath)
        let (data, _) = try await URLSession.shared.data(from: posterURL)
        guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeContentData) }
        self.fileManager.saveImage(image: image, imageName: imageName, folderName: folderName)
        return image
    }
    
    func getMovieImage() async -> UIImage? {
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
            print("retrieved image from file manager")
            return savedImage
        } else {
            let image = try? await downloadMovieImage()
            print("download image")
            return image
        }
    }
    
}


