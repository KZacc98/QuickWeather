//
//  WeatherBriefRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import Foundation

/// A model representing the weather condition.
struct WeatherBriefRemote: Decodable {
    /// Weather condition ID.
    let id: Int
    
    /// Group of weather parameters (e.g., Rain, Snow).
    let main: String
    
    /// Description of the weather condition.
    let description: String
    
    /// Weather icon ID.
    let icon: String
}
