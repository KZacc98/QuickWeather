//
//  CitySearchViewModel.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import Foundation

class CitySearchViewModel {
    
    // MARK: - Binding Closures
    
    var showAlert: ((String, String) -> Void)?
    var citiesDidChange: ((Cities) -> Void)?
    var weatherFetched: ((CityRemote, WeatherDomain) -> Void)?
    
    // MARK: - Properties
    
    let worker = WeatherWorker()
    
    var cities: Cities = [] {
        didSet {
            citiesDidChange?(cities)
        }
    }

    // MARK: - Public Methods
    
    func getCities(cityName: String?) {
        guard let cityName else { return }
        
        worker.getCities(cityName: cityName) { [weak self] result in
            switch result {
            case .success(let success):
                guard success.isEmpty == false else {
                    self?.showAlert?("", "No cities found")
                    return
                }
                self?.cities = success
            case .failure(let failure):
                self?.handleError(error: failure)
            }
        }
    }
    
    func getWeather(for city: CityRemote) {
        worker.getWeatherData(for: city) { [weak self] result in
            switch result {
            case .success(let success):
                self?.weatherFetched?(city, success)
            case .failure(let failure):
                self?.handleError(error: failure)
            }
        }
    }
    
    func validateCityName(_ cityName: String) -> Bool {
        let regexPattern = "^[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\\s]+$"
        return cityName.range(of: regexPattern, options: .regularExpression) != nil
    }
    
    // MARK: - Private Methods
    
    private func handleError(error: Error) {
        print("Error occurred: \(error.localizedDescription)")
        let errorMessage = error.localizedDescription.appending("\n Did you add your API Key?")
        showAlert?("Error", errorMessage)
    }
}
