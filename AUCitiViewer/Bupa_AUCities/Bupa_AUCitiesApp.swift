//
//  Bupa_AUCitiesApp.swift
//  Bupa_AUCities
//
//  Created by VIVEK THAKUR on 08/12/23.
//

import SwiftUI

@main
struct Bupa_AUCitiesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel.init())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
