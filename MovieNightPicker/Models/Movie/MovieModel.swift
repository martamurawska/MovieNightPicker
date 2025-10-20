import Foundation

/*
 https://api.themoviedb.org/3/discover/movie
 result:
 {
   "page": 1,
   "results": [
     {
       "adult": false,
       "backdrop_path": "/iZLqwEwUViJdSkGVjePGhxYzbDb.jpg",
       "genre_ids": [
         878,
         53
       ],
       "id": 755898,
       "original_language": "en",
       "original_title": "War of the Worlds",
       "overview": "Will Radford is a top analyst for Homeland Security who tracks potential threats through a mass surveillance program, until one day an attack by an unknown entity leads him to question whether the government is hiding something from him... and from the rest of the world.",
       "popularity": 615.0872,
       "poster_path": "/yvirUYrva23IudARHn3mMGVxWqM.jpg",
       "release_date": "2025-07-29",
       "title": "War of the Worlds",
       "video": false,
       "vote_average": 4.334,
       "vote_count": 496
     }
   ],
   "total_pages": 52364,
   "total_results": 1047272
 }
 */

// Movie Details response
/*
{
  "adult": false,
  "backdrop_path": "/iZLqwEwUViJdSkGVjePGhxYzbDb.jpg",
  "belongs_to_collection": null,
  "budget": 0,
  "genres": [
    {
      "id": 878,
      "name": "Science Fiction"
    },
    {
      "id": 53,
      "name": "Thriller"
    }
  ],
  "homepage": "https://www.amazon.com/gp/video/detail/B0DMF7MXKT",
  "id": 755898,
  "imdb_id": "tt13186306",
  "origin_country": [
    "US"
  ],
  "original_language": "en",
  "original_title": "War of the Worlds",
  "overview": "Will Radford is a top analyst for Homeland Security who tracks potential threats through a mass surveillance program, until one day an attack by an unknown entity leads him to question whether the government is hiding something from him... and from the rest of the world.",
  "popularity": 351.3123,
  "poster_path": "/yvirUYrva23IudARHn3mMGVxWqM.jpg",
  "production_companies": [
    {
      "id": 33,
      "logo_path": "/8lvHyhjr8oUKOOy2dKXoALWKdp0.png",
      "name": "Universal Pictures",
      "origin_country": "US"
    },
    {
      "id": 109501,
      "logo_path": "/4dtmZKPLHzIALpGbdeSNX6Rw1p3.png",
      "name": "Bazelevs",
      "origin_country": "US"
    },
    {
      "id": 59827,
      "logo_path": null,
      "name": "Patrick Aiello Productions",
      "origin_country": "US"
    }
  ],
  "production_countries": [
    {
      "iso_3166_1": "US",
      "name": "United States of America"
    }
  ],
  "release_date": "2025-07-29",
  "revenue": 0,
  "runtime": 91,
  "spoken_languages": [
    {
      "english_name": "English",
      "iso_639_1": "en",
      "name": "English"
    }
  ],
  "status": "Released",
  "tagline": "Your data is deadly.",
  "title": "War of the Worlds",
  "video": false,
  "vote_average": 4.396,
  "vote_count": 592
}
 
 */

struct Movie: Identifiable, Codable, Hashable {
    let adult: Bool?
    let backdropPath: String?
    let genreIds: [Int]?
    let id: Int
    let originaLanguage: String?
    let originalTitle: String?
    let overview: String
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let genres: [Genre]?
    let state: MovieState?
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originaLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genres
        case state
    }
        
    init(adult: Bool?, backdropPath: String?, genreIds: [Int]?, id: Int, originaLanguage: String?, originalTitle: String?, overview: String, popularity: Double?, posterPath: String?, releaseDate: String?, title: String, video: Bool?, voteAverage: Double?, voteCount: Int?, genres: [Genre]?, state: MovieState?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIds = genreIds
        self.id = id
        self.originaLanguage = originaLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.genres = genres
        self.state = state
    }
    
    var releaseYear: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        guard let releaseDate else { return "" }
        
        if let date = formatter.date(from: releaseDate) {
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            let yearString = yearFormatter.string(from: date)
            return yearString
        }
        return ""
    }
    
    func updateGenres(genres: [Genre]) -> Movie {
        return Movie(adult: adult, backdropPath: backdropPath, genreIds: genreIds, id: id, originaLanguage: originaLanguage, originalTitle: originalTitle, overview: overview, popularity: popularity, posterPath: posterPath, releaseDate: releaseDate, title: title, video: video, voteAverage: voteAverage, voteCount: voteCount, genres: genres, state: state)
    }
    
    func updateWatchListStatus(state: MovieState) -> Movie {
        return Movie(adult: adult, backdropPath: backdropPath, genreIds: genreIds, id: id, originaLanguage: originaLanguage, originalTitle: originalTitle, overview: overview, popularity: popularity, posterPath: posterPath, releaseDate: releaseDate, title: title, video: video, voteAverage: voteAverage, voteCount: voteCount, genres: genres, state: state)
    }
    
    var mappedGenres: [Genre] {
        GenreStore.shared.genres(from: genreIds ?? [])
    }
}
