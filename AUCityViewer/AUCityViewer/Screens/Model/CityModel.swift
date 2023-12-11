

import Foundation

struct CityResponse: Codable  {
    let articles : [Cities]?
}

struct Cities: Codable , Identifiable {
    var id = UUID()
    let city : String?
    let country : String?
    let capital : String?
    let admin_name : String?
    let lat : String?
    let lng : String?
    let population : String?
    enum CodingKeys: String, CodingKey {
        case city = "city"
        case country = "country"
        case capital = "capital"
        case admin_name = "admin_name"
        case lat = "lat"
        case lng = "lng"
        case population = "population"
    }
}
