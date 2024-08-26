//
//  Temperature.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import Foundation

struct Temperature {
    let value: Double
    
    var localizedTemperature: String {
        let isMetric = Locale.current.usesMetricSystem
        let preferredUnit: Measurement<UnitTemperature>
        
        if isMetric {
            //Kelvin to Celsius (K - 273.15)
            preferredUnit = Measurement(value: value - 273.15, unit: .celsius)
        } else {
            //Kelvin to Fahrenheit (K * 9/5 - 459.67)
            let tempInFahrenheit = value * 9 / 5 - 459.67
            preferredUnit = Measurement(value: tempInFahrenheit, unit: .fahrenheit)
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.numberStyle = .decimal
        
        let formatter = MeasurementFormatter()
        formatter.locale = Locale.current
        formatter.unitOptions = .providedUnit
        formatter.numberFormatter = numberFormatter
        
        return formatter.string(from: preferredUnit)
    }
    
    init(temp: Double) {
        self.value = temp
    }
}
