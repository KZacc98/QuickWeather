//
//  ForecastDomain.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 28/08/2024.
//

import Foundation

struct ForecastDomain {
    /// Time of data forecasted
    let dateTime: Date
    
    /// Main weather data including temperature, pressure, and humidity.
    let weatherDetails: WeatherDetailsDomain
    
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
    
    init(remote: ForecastRemote) {
        self.dateTime = remote.dateTime.toDate
        self.weatherDetails = WeatherDetailsDomain(remote: remote.weatherDetails)
        self.weatherBrief = remote.weatherBrief
        self.clouds = remote.clouds
        self.wind = remote.wind
        self.visibility = remote.visibility
        self.rainProbability = remote.rainProbability
        self.rain = remote.rain
        self.snow = remote.snow
        self.dateTimeText = remote.dateTimeText
    }
}
