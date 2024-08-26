//
//  Pressure.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import Foundation

struct Pressure {
    let pressure: Int
    
    var inHPA: String {
        return "\(pressure)hPa"
    }
    
    init(pressure: Int) {
        self.pressure = pressure
    }
    
    init?(pressure: Int?) {
        guard let pressure else { return nil }
        self.pressure = pressure
    }
}
