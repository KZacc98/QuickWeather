//
//  WeatherForecastRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import Foundation
/// A model representing the entire weather response from the [API](https://openweathermap.org/forecast5).
struct WeatherForecastRemote: Decodable {
    /// A number of timestamps returned in the API response.
    let count: Int
    
    /// An array of forecast data returned by the API.
    let forecasts: [ForecastRemote]
    
    /// Information about the city related to the forecast data.
    let city: CityDetailsRemote
    
    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case forecasts = "list"
        case city
    }
}
