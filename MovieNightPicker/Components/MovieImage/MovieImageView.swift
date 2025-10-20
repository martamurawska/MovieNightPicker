import SwiftUI

struct MovieImageView: View {
    @StateObject var vm: MovieImageViewModel
    
    init(movie: Movie) {
        _vm = StateObject(wrappedValue: MovieImageViewModel(movie: movie))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                Rectangle()
                    .fill(Color.accent)
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .overlay(
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    )
            } else {
                Rectangle()
                    .fill(Color.accent)
                    .scaledToFit()
                    .overlay(
                        Image(systemName: "mountain.2.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundStyle(.orangeAccent))
            }
        }
    }
}

#Preview {
    MovieImageView(movie: MockedMovie.movie)
}
