extension Movie {
    var isWatched: Bool {
        state == .watched
    }
    
    var isInWatchlist: Bool {
        state == .watchlist
    }
    
    var hasFullyDetail: Bool {
        !overview.isEmpty && releaseDate != nil
    }
}
