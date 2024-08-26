//
//  CloudsRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import Foundation

/// A model representing cloudiness data.
struct CloudsRemote: Decodable {
    /// Cloudiness percentage.
    let cloudiness: Int
    
    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}
