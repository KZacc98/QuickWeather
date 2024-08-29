//
//  Humidity.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import Foundation

struct Humidity {
    let humidity: Int
    
    var percentage: String {
        return String(format: "humidityFormat".localized, humidity)
    }
    
    var gaugePercentage: CGFloat {
        return CGFloat(humidity) / 100.0
    }
    
    init(humidity: Int) {
        self.humidity = humidity
    }
}
