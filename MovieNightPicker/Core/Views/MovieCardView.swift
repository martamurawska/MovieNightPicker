import SwiftUI

struct MovieCardView: View {
    let movie: Movie
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                MovieImageView(movie: movie)
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.headline)
                    FlowLayout {
                        ForEach(movie.mappedGenres, id: \.self) { genre in
                            GenreTag(genre: genre, style: .primary, size: .small)
                        }
                    }
                    Text(movie.releaseYear)
                        .foregroundStyle(.secondaryText)
                        .font(.subheadline)
                        .bold()
                }
                .padding(.top, 8)
                .padding([.bottom, .leading, .trailing], 12)
            }
        }
        .background(Color.surfaceBackground)
        .cornerRadius(20)
        .shadow(color: .appPrimary.opacity(0.15), radius: 10, x: 0, y: 0)
    }
}

#Preview {
    NavigationView {
        MovieCardView(movie: MockedMovie.movie)
            .frame(width: 200)
    }
}
