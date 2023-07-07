

import Foundation
import SwiftyJSON

struct ItunesMusic {
    var artistName = ""
    var artworkUrl100 = ""
    var trackName = ""
    var previewUrl = ""
    
    init(){
        
    }
    
    init(json: JSON) {
        if let item = json["artistName"].string {
            artistName = item
        }
        if let item = json["artworkUrl100"].string {
            artworkUrl100 = item
        }
        if let item = json["trackName"].string {
            trackName = item
        }
        if let item = json["previewUrl"].string {
            previewUrl = item
        }
    }
}

//Пример декодирования JSON в экземпляр структуры ItunesMusic:
//
//struct ItunesMusic: Codable {
//    var artistName: String
//    var artworkUrl100: String
//    var trackName: String
//    var previewUrl: String
//}

//let json = """
//{
//    "artistName": "Artist Name",
//    "artworkUrl100": "https://example.com/artwork.jpg",
//    "trackName": "Track Name",
//    "previewUrl": "https://example.com/preview.mp3"
//}
//"""
//
//let jsonData = json.data(using: .utf8)!
//
//do {
//    let itunesMusic = try JSONDecoder().decode(ItunesMusic.self, from: jsonData)
//    print(itunesMusic)
//} catch {
//    print("Ошибка декодирования JSON: \(error)")
//}


//Пример кодирования экземпляра структуры ItunesMusic в JSON:

//let itunesMusic = ItunesMusic(artistName: "Artist Name", artworkUrl100: "https://example.com/artwork.jpg", trackName: "Track Name", previewUrl: "https://example.com/preview.mp3")
//
//do {
//    let jsonData = try JSONEncoder().encode(itunesMusic)
//    let jsonString = String(data: jsonData, encoding: .utf8)
//    print(jsonString ?? "")
//} catch {
//    print("Ошибка кодирования в JSON: \(error)")
//}
