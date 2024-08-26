//
//  CoordinatesRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import Foundation
/// A model representing the geographic coordinates.
struct CoordinatesRemote: Decodable {
    /// Longitude of the location.
    let lon: Double
    
    /// Latitude of the location.
    let lat: Double
}
