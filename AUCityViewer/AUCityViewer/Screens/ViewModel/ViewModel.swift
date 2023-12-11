

import Foundation
@MainActor class ViewModel : ObservableObject {
    @Published var uscities = [Cities]()
    func loadData() async {
        do {
            if let bundlePath = Bundle.main.path(forResource: "au_cities", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let fetchedCity = try JSONDecoder().decode([Cities].self, from: jsonData)
                uscities = fetchedCity
            }
        } catch {
            print(error)
        }
    }
}

