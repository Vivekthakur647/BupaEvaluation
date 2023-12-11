

import Foundation
import SwiftUI
@MainActor class ViewModel : ObservableObject {
    @Published var uscities = [Cities]()
    @Published var sortedResponse = [CityResponse]()
    func loadData() async {
        do {
            if let bundlePath = Bundle.main.path(forResource: "au_cities", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let fetchedCity = try JSONDecoder().decode([Cities].self, from: jsonData)
                uscities = fetchedCity
                groupData(unsortedCity: uscities)
            }
        } catch {
            print(error)
        }
    }
    func groupData (unsortedCity : [Cities]) {
        for uscity in unsortedCity {
            let found = sortedResponse.contains { model in
                model.adminNameSection == uscity.admin_name
            }
            if found {
                let indeD = sortedResponse.firstIndex { model in
                    model.adminNameSection ==  uscity.admin_name
                }
                sortedResponse[indeD!].articles?.append(Cities(city: uscity.city, country: uscity.country, capital: uscity.capital, admin_name: uscity.admin_name, lat: uscity.lat, lng: uscity.lng, population: uscity.population))
            } else {
                sortedResponse.append(CityResponse(adminNameSection: uscity.admin_name, articles: [Cities(city: uscity.city, country: uscity.country, capital: uscity.capital, admin_name: uscity.admin_name, lat: uscity.lat, lng: uscity.lng, population: uscity.population)]))
            }
        }
    }
}

