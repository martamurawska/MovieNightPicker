import SwiftUI

struct BrowseMovieView: View {
    @ObservedObject private var vm: BrowseMoviesViewModel
    @State var showTags: Bool = false
    
    let columns = [
        GridItem(.flexible(), alignment: .top),
        GridItem(.flexible(), alignment: .top)
    ]
    
    public init(vm: BrowseMoviesViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            titleAndFilterBar
            Spacer(minLength: 16)
            if showTags {
                filterSection
            }
            movieCards
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationDestination(for: Movie.self) { movie in
            MovieDetailView(vm: MovieDetailViewModel(movie: movie))
        }
        .padding()
        .edgesIgnoringSafeArea(.bottom)
        //        .onChange(of: vm.searchText) {
        //            vm.onSearchQueryChange()
        //        }
    }
    
    var titleAndFilterBar: some View {
        HStack(spacing: 0) {
            Text("Explore movies")
                .font(.largeTitle)
                .bold()
            Spacer()
            Button {
                showTags.toggle()
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .frame(width: 36, height: 36)
            }
            .buttonStyle(.plain)
            .padding(4)
        }
    }
    
    var filterSection: some View {
        VStack(spacing: 4) {
            HStack {
                Text("Genres")
                    .font(.title3)
                    .foregroundStyle(.secondaryText)
                Spacer()
                if !vm.selectedGenres.isEmpty {
                    clearAllButton
                }
            }
            tagsSection
        }
    }
    
    var clearAllButton: some View {
        Button {
            vm.clearAllFilter()
        } label: {
            Text("Clear all")
        }
        .animation(.easeInOut, value: vm.selectedGenres)
        .foregroundStyle(.secondaryText)
        .padding(.horizontal)
    }
    
    var tagsSection: some View {
        FlowLayout {
            ForEach(GenreStore.shared.genres, id: \.self) { genre in
                GenreTag(genre: genre, style: vm.selectedGenres.contains(genre.id) ? .selected : .secondary, size: .medium) { _ in
                    vm.toggleGenre(genre.id)
                }
            }
        }
    }
    
    var movieCards: some View {
        LazyVGrid(columns: columns, alignment: .center) {
            ForEach(vm.allMovies, id: \.id) { movie in
                NavigationLink(value: movie) {
                    MovieCardView(movie: movie)
                }
                .buttonStyle(.plain)
                .padding(4)
                .onAppear {
                    vm.shouldLoadPagination(id: movie.id)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BrowseMovieView(vm: BrowseMoviesViewModel())
    }
}
