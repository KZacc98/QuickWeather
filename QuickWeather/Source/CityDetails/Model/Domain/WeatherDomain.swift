//
//  WeatherDomain.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import Foundation

struct WeatherDomain {
    /// The geographic coordinates of the location.
    let coordinates: CoordinatesRemote
    
    /// The weather conditions for the location.
    let weatherBrief: [WeatherBriefRemote]
    
    /// Main weather data including temperature, pressure, and humidity.
    let weatherDetails: WeatherDetailsDomain
    
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
    
    init(remote: WeatherRemote) {
        self.coordinates = remote.coordinates
        self.weatherBrief = remote.weatherBrief
        self.weatherDetails = WeatherDetailsDomain(remote: remote.weatherDetails)
        self.visibility = remote.visibility
        self.wind = remote.wind
        self.clouds = remote.clouds
        self.rain = remote.rain
        self.snow = remote.snow
        self.dateTime = remote.dateTime
        self.systemData = remote.systemData
        self.timezone = remote.timezone
        self.id = remote.id
        self.name = remote.name
    }
}
