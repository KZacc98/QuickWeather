//
//  SystemRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import Foundation

/// A model representing system data.
struct SystemRemote: Decodable {
    /// Country code (e.g., GB, JP).
    let country: String
    
    /// Sunrise time, in Unix time (UTC).
    let sunrise: Int
    
    /// Sunset time, in Unix time (UTC).
    let sunset: Int
}
