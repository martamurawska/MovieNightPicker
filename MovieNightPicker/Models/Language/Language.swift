struct Language: SelectableItem {
    let id: String //iso name as id
    let name: String
}

let allLanguages: [Language] = [Language(id: "en", name: "English"),
                                Language(id: "es", name: "Spanish"),
                                Language(id: "de", name: "German"),
                                Language(id: "pl", name: "Polish")]
                       


//  {
//    "iso_639_1": "es",
//    "english_name": "Spanish",
//    "name": "Español"
//  }
//  {
//    "iso_639_1": "en",
//    "english_name": "English",
//    "name": "English"
//  },
//  {
//    "iso_639_1": "pl",
//    "english_name": "Polish",
//    "name": "Polski"
//  },
//  {
//    "iso_639_1": "de",
//    "english_name": "German",
//    "name": "Deutsch"
//  }

