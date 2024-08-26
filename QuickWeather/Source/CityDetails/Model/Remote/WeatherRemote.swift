//
//  WeatherRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import Foundation

/// A model representing the weather response from the [API](https://openweathermap.org/current#one).
struct WeatherRemote: Decodable {
    
    /// The geographic coordinates of the location.
    let coordinates: CoordinatesRemote
    
    /// The weather conditions for the location.
    let weatherBrief: [WeatherBriefRemote]
    
    /// Main weather data including temperature, pressure, and humidity.
    let weatherDetails: WeatherDetailsRemote
    
    /// The visibility in meters.
    let visibility: Int
    
    /// Wind data including speed, direction, and gust.
    let wind: WindRemote
    
    /// Cloudiness percentage.
    let clouds: CloudsRemote
    
    /// Rain data for the last 1 or 3 hours, if available.
    let rain: RainRemote?
    
    /// Snow data for the last 1 or 3 hours, if available.
    let snow: SnowRemote?
    
    /// Time of data calculation, in Unix time (UTC).
    let dateTime: Int
    
    /// System data including country, sunrise, and sunset times.
    let systemData: SystemRemote
    
    /// The shift in seconds from UTC.
    let timezone: Int
    
    /// City ID.
    let id: Int
    
    /// City name.
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weatherBrief = "weather"
        case weatherDetails = "main"
        case visibility
        case wind
        case clouds
        case rain
        case snow
        case dateTime = "dt"
        case systemData = "sys"
        case timezone
        case id
        case name
    }
}
