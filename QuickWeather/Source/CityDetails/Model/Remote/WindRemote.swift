//
//  WindRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import Foundation

/// A model representing wind data.
struct WindRemote: Decodable {
    /// Wind speed in meter/sec (default) or other units.
    let speed: Double
    
    /// Wind direction in degrees.
    let degrees: Int
    
    /// Wind gust speed in meter/sec (optional).
    let gust: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degrees = "deg"
        case gust
    }
}
