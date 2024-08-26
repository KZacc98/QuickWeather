//
//  ForecastRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import Foundation

/// A model representing a forecast entry in the list.
struct ForecastRemote: Decodable {
    /// Time of data forecasted, in Unix time (UTC).
    let dateTime: Int
    
    /// Main weather data including temperature, pressure, and humidity.
    let weatherDetails: WeatherDetailsRemote
    
    /// The weather conditions for the forecasted time.
    let weatherBrief: [WeatherBriefRemote]
    
    /// Cloudiness percentage.
    let clouds: CloudsRemote
    
    /// Wind data including speed, direction, and gust.
    let wind: WindRemote
    
    /// Average visibility in meters.
    let visibility: Int
    
    /// Probability of precipitation (values range between 0 and 1, where 0 is 0% and 1 is 100%).
    let rainProbability: Double
    
    /// Rain volume for the last 3 hours, in mm (optional).
    let rain: RainRemote?
    
    /// Snow volume for the last 3 hours, in mm (optional).
    let snow: SnowRemote?
    
    /// Time of data forecasted, in ISO format (UTC).
    let dateTimeText: String
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case weatherDetails = "main"
        case weatherBrief = "weather"
        case clouds
        case wind
        case visibility
        case rainProbability = "pop"
        case rain
        case snow
        case dateTimeText = "dt_txt"
    }
}
