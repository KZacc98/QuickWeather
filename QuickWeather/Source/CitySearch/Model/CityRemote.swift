//
//  CityRemote.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 24/08/2024.
//

struct CityRemote: Codable {
    let name: String
    let localNames: [String: String]?
    let lattitude: Double
    let longitude: Double
    let country: String
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lattitude = "lat"
        case longitude = "lon"
        case country
        case state
    }
}

typealias Cities = [CityRemote]
