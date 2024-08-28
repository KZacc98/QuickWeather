//
//  CityRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 24/08/2024.
//

import Foundation

/// A model representing a city or location retrieved from the [API](https://openweathermap.org/api/geocoding-api).
struct CityRemote: Codable {
    
    /// The name of the found location.
    let name: String
    
    /// The names of the found location in different languages.
    ///
    /// - Key: The language code (e.g., "en" for English).
    /// - Value: The name of the location in the corresponding language.
    ///
    /// This also includes internal fields:
    /// - `ascii`: The ASCII representation of the location name.
    /// - `feature_name`: An internal field representing the feature name.
    let localNames: [String: String]?
    
    /// The geographical latitude of the found location.
    let latitude: Double
    
    /// The geographical longitude of the found location.
    let longitude: Double
    
    /// The country of the found location.
    let country: String
    
    /// The state of the found location (if available).
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case latitude = "lat"
        case longitude = "lon"
        case country
        case state
    }
}
