//
//  CityDetailsRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import Foundation

/// A model representing the city information.
struct CityDetailsRemote: Decodable {
    /// City ID.
    let id: Int
    
    /// City name.
    let name: String
    
    /// The geographic coordinates of the city.
    let coordinates: CoordinatesRemote
    
    /// Country code (e.g., GB, JP).
    let country: String
    
    /// City population.
    let population: Int?
    
    /// The shift in seconds from UTC.
    let timezone: Int
    
    /// Sunrise time, in Unix time (UTC).
    let sunrise: Int
    
    /// Sunset time, in Unix time (UTC).
    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coordinates = "coord"
        case country
        case population
        case timezone
        case sunrise
        case sunset
    }
}
