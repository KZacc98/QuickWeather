//
//  WeatherWorker.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import Foundation

class WeatherWorker {
    #warning("Provide your own API Key, and comment/remove this message")
    let APIKey: String = "" //changed, pushed accidentaly
    
    private func fetchData<T: Decodable>(
        urlString: String,
        completion: @escaping (Result<T, Error>) -> Void)
    {
        guard let url = URL(string: urlString) else { return }
        
        NetworkManager.shared.fetchData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCities(
        cityName: String,
        completion: @escaping (Result<[CityRemote], Error>) -> Void)
    {
        guard let cityName = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        let urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&limit=5&appid=\(APIKey)"
        
        fetchData(urlString: urlString) { (result: Result<Cities, Error>) in
            switch result {
            case .success(let cities):
                completion(.success(cities))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getWeatherData(
        for city: CityRemote,
        completion: @escaping (Result<WeatherDomain, Error>) -> Void)
    {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(city.latitude)&lon=\(city.longitude)&appid=\(APIKey)"
        
        fetchData(urlString: urlString) { (result: Result<WeatherRemote, Error>) in
            switch result {
            case .success(let remote):
                completion(.success(WeatherDomain(remote: remote)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getForecast(
        for city: CityRemote,
        completion: @escaping (Result<WeatherForecastRemote, Error>) -> Void)
    {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(city.latitude)&lon=\(city.longitude)&appid=\(APIKey)"
        
        fetchData(urlString: urlString) { (result: Result<WeatherForecastRemote, Error>) in
            switch result {
            case .success(let forecastData):
                completion(.success(forecastData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
