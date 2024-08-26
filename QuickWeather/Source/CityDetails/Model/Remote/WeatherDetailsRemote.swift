//
//  WeatherDetailsRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import Foundation

/// A model representing the main weather data.
struct WeatherDetailsRemote: Decodable {
    /// Temperature in Kelvin (default), Celsius (metric), or Fahrenheit (imperial).
    let temp: Double
    
    /// Temperature accounting for human perception.
    let feelsLike: Double
    
    /// Atmospheric pressure on the sea level, in hPa.
    let pressure: Int
    
    /// Humidity percentage.
    let humidity: Int
    
    /// Minimum observed temperature at the moment.
    let tempMin: Double
    
    /// Maximum observed temperature at the moment.
    let tempMax: Double
    
    /// Atmospheric pressure on the sea level, in hPa.
    let seaLevel: Int?
    
    /// Atmospheric pressure on the ground level, in hPa.
    let grndLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}
