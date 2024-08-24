//
//  CitySearchViewModel.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import Foundation

class CitySearchViewModel {
    #error("Provide your own API Key, and comment/remove this message")
    let APIKey: String = ""
    
    func fetchData(from url: URL) {
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                print("Received data: \(jsonObject)")
            } catch {
                print("Failed to parse data: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func callAPI(cityName: String?) {
        guard let cityName,
              let url = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(cityName)&appid=\(APIKey)")
        else { return }
        fetchData(from: url)
    }
}
