//
//  SnowRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import Foundation

/// A model representing snow data.
struct SnowRemote: Decodable {
    /// Snow volume for the last 1 hour, in mm (optional).
    let oneHour: Double?
    
    /// Snow volume for the last 3 hours, in mm (optional).
    let threeHour: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
        case threeHour = "3h"
    }
}
