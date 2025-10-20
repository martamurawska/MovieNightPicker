import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Tab("Discover", systemImage: "safari.fill") {
                NavigationStack {
                    DiscoverView(vm: DiscoverViewModel())
                }
            }
            
            Tab("Browse", systemImage: "magnifyingglass") {
                NavigationStack {
                    BrowseMovieView(vm: BrowseMoviesViewModel())
                }
            }
            
            Tab("Saved", systemImage: "heart") {
                NavigationStack {
                    WatchlistView(vm: WatchlistViewModel())
                }
            }
        }
        .tint(Color.appPrimary)
    }
}

#Preview {
    HomeView()
}
