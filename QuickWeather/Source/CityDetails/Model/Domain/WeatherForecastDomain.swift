//
//  WeatherForecastDomain.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 28/08/2024.
//

import Foundation

struct WeatherForecastDomain {
    /// A number of timestamps returned in the API response.
    let count: Int
    
    /// An array of forecast data returned by the API.
    let forecasts: [ForecastDomain]
    
    /// Information about the city related to the forecast data.
    let city: CityDetailsRemote
    
    init(remote: WeatherForecastRemote) {
        self.count = remote.count
        self.forecasts = remote.forecasts.compactMap { ForecastDomain(remote: $0) }
        self.city = remote.city
    }
}
