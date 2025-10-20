import SwiftUI

struct SavedMovieCardView: View {
    let movie: Movie
    var onDelete: (() -> Void)?
    @State private var presentAlert: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            MovieImageView(movie: movie)
                .frame(height: 80)
                .cornerRadius(10)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(movie.title)
                        .layoutPriority(1)
                        .font(.title3)
                        .bold()
                        .padding(.top, 4)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    deleteButton
                }
                FlowLayout {
                    ForEach(movie.mappedGenres, id: \.self) { genre in
                        GenreTag(genre: genre, style: .primary, size: .small)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.background)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.secondaryText.opacity(0.3), lineWidth: 1)
        )
        .alert("Delete?", isPresented: $presentAlert) {
            Button("Delete", role: .destructive) {
                onDelete?()
            }
            Button("Cancel", role: .cancel) {
                presentAlert = false
            }
        } message: {
            Text("Are you sure you want to delete this movie from your watchlist?")
        }
    }
    
    var deleteButton: some View {
        Image(systemName: "trash")
            .foregroundStyle(Color.appPrimary)
            .frame(width: 36, height: 36)
            .frame(alignment: .topTrailing)
            .onTapGesture {
                presentAlert = true
            }
            .animation(.easeInOut, value: presentAlert)
    }
}

#Preview {
    ZStack {
        Color.appSecondary.opacity(0.1).ignoresSafeArea()
        SavedMovieCardView(movie: MockedMovie.movie)
            .padding()
    }
}
