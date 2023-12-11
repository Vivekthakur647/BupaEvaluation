//
//  ContentView.swift
//  Bupa_AUCities
//
//  Created by VIVEK THAKUR on 08/12/23.
//
import SwiftUI
import CoreData
struct ContentView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var isDarkModeOn = false
    @ObservedObject var viewModel: ViewModel
    @State private var isSorted = false
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.uscities) { article in
                    Section(header: Text("\(article.city ?? Constants.emptyCity)").font(.system(size: 22)).bold().foregroundColor(Color.ColorPrimary)) {
                        Text("\(Constants.Country) : \(article.country ?? Constants.emptyCapital)").foregroundColor(Color.TextColorPrimary)
                        Text("\(Constants.Capital) : \(article.capital ?? Constants.emptyCapital)").foregroundColor(Color.TextColorPrimary)
                        Text("\(Constants.Population) : \(article.population ?? Constants.emptyPopulation)").foregroundColor(Color.TextColorPrimary)
                        Text("\(Constants.Lat) : \(article.lat ?? Constants.emptyLat)").foregroundColor(Color.TextColorPrimary)
                        Text("\(Constants.Long) : \(article.lng ?? Constants.emptyLong)").foregroundColor(Color.TextColorPrimary)
                        Text("\(Constants.Admin) : \(article.admin_name ?? Constants.emptyAdmin)").foregroundColor(Color.TextColorPrimary)
                        
                    }.textCase(nil)
                }
            }.animation(.easeInOut, value: UUID())
                .listStyle(.sidebar).task { await viewModel.loadData() }
                .navigationTitle(Constants.CityList)
                .toolbar {
                    ToolbarItemGroup(placement: .primaryAction) {
                        Button(action: {
                            Task {  await viewModel.loadData() }
                        }) {
                            Label(Constants.Refresh, systemImage: "arrow.clockwise")
                        }.accessibilityIdentifier(Constants.Refresh)
                        
                        Button {
                            if isSorted {
                                viewModel.uscities = viewModel.uscities.sorted { $0.city?.lowercased() ?? "" < $1.city?.lowercased() ?? "" }
                            } else {
                                viewModel.uscities = viewModel.uscities.sorted { $0.city?.lowercased() ?? "" > $1.city?.lowercased() ?? "" }
                            }
                            isSorted = !isSorted
                        } label: {
                            Image(Constants.sort)
                        } .accessibilityIdentifier(Constants.sort)
                        Button(action: {
                            UserDefaultsUtils.shared.setDarkMode(enable: !isDarkModeOn)
                            setAppTheme()
                        }, label: {
                            Text(isDarkModeOn ? Constants.Light : Constants.Dark)
                        })
                    }
                }
        }
    }
    func setAppTheme(){
        //MARK: use saved device theme from toggle
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        changeDarkMode(state: isDarkModeOn)
    }
    func changeDarkMode(state: Bool){
        (UIApplication.shared.connectedScenes.first as?
         UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ?   .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel.init())
    }
}
