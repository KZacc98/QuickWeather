//
//  CitySearchViewModel.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import Foundation

class CitySearchViewModel {
    //    #error("Provide your own API Key, and comment/remove this message")
    let APIKey: String = "5625eaada0f9977311cf60e2df9e34b3"
    
    var showAlert: ((String, String) -> Void)?
    var citiesDidChange: ((Cities) -> Void)?
    
    var cities: Cities = [] {
        didSet {
            citiesDidChange?(cities)
        }
    }
    
    func validateCityName(_ cityName: String) -> Bool {
        let regexPattern = "^[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\\s]+$"
        
        return cityName.range(of: regexPattern, options: .regularExpression) != nil
    }
    
    func callAPI(cityName: String?) {
        guard let cityName,
              let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=5&appid=\(APIKey)")
        else { return }
        
        NetworkManager.shared.fetchData(from: url) { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleSuccess(data: data)
            case .failure(let error):
                self?.handleError(error: error)
            }
        }
    }
    
    private func handleSuccess(data: Data) {
        do {
            let decoder = JSONDecoder()
            let cities = try decoder.decode(Cities.self, from: data)
            
            print(cities)
            self.cities = cities
        } catch {
            print("Failed to parse data: \(error.localizedDescription)")
        }
    }
    
    private func handleError(error: Error) {
        print("Error occurred: \(error.localizedDescription)")
        let errorMessage = error.localizedDescription.appending("\n Did you add your API Key?")
        showAlert?("Error", errorMessage)
    }
}
