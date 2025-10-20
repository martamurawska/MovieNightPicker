import Foundation

// https://developer.themoviedb.org/reference/watch-providers-movie-list
//"provider_name": "Netflix",
//  "provider_id": 8
//"provider_name": "Amazon Prime Video",
//    "provider_id": 9
//"provider_name": "Disney Plus",
//  "provider_id": 337
//"provider_name": "RTL+",
//    "provider_id": 298
//"provider_name": "Joyn",
//"provider_id": 304

struct Platform: Identifiable, Hashable, SelectableItem {
    let id: Int
    let name: String
}

var allPlatforms: [Platform] = [Platform(id: 8, name: "Netflix"),
                                Platform(id: 9, name: "Amazon Prime Video"),
                                Platform(id: 337, name: "Disney Plus"),
                                Platform(id: 298, name: "RTL+"),
                                Platform(id: 304, name: "Joyn")]

