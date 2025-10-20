import SwiftUI

struct DiscoverCardView: View {
    let movie: Movie
    @State var showDescription: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MovieImageView(movie: movie)
                .overlay {
                    overlayBackground
                }
                .cornerRadius(20)
                .animation(.easeInOut, value: showDescription)
                .onTapGesture {
                    showDescription.toggle()
                }
        }.id(movie.id) // fix the issue with not reloading the image
    }
    
    var overlayBackground: some View {
        ZStack(alignment: .bottomLeading) {
            gradientBackground
                .opacity(showDescription ? 0 : 1)
            descriptionBackground
                .opacity(showDescription ? 1 : 0)
        }
    }
    
    var gradientBackground: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .foregroundColor(.clear)
                .background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .bottom))
            titleAndGenres
        }
    }
    
    var descriptionBackground: some View {
        ZStack(alignment: .bottomLeading) {
            Rectangle()
                .fill(Color.black.opacity(0.8))
            Text(movie.overview)
                .foregroundStyle(Color.white)
                .font(.title3)
                .fontWeight(.medium)
                .padding(16)
        }
    }
    
    var titleAndGenres: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(movie.title)
                .foregroundStyle(Color.white)
                .font(.title)
                .bold()
            FlowLayout {
                ForEach(movie.mappedGenres, id: \.self) { genre in
                    GenreTag(genre: genre, style: .primary, size: .medium)
                }
            }
        }
        .padding([.leading, .bottom], 16)
    }
}

#Preview {
    DiscoverCardView(movie: MockedMovie.movie)
        .padding()
}
