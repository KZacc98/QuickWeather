//
//  Temperature.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import Foundation
import UIKit

struct Temperature {
    // In Kelvin
    let value: Double
    
    var localizedTemperature: String {
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
    
    var localizedValue: Double {
        return preferredUnit.value
    }
    
    var preferredUnit: Measurement<UnitTemperature> {
        let isMetric = Locale.current.usesMetricSystem
        
        if isMetric {
            // Kelvin to Celsius (K - 273.15)
            return Measurement(value: value - 273.15, unit: .celsius)
        } else {
            // Kelvin to Fahrenheit (K * 9/5 - 459.67)
            let tempInFahrenheit = value * 9 / 5 - 459.67
            
            return Measurement(value: tempInFahrenheit, unit: .fahrenheit)
        }
    }
    
    var color: UIColor {
        let celsiusValue: Double
        
        if Locale.current.usesMetricSystem {
            celsiusValue = localizedValue
        } else {
            // Fahrenheit to Celsius
            celsiusValue = (localizedValue - 32) * 5 / 9
        }
        
        switch celsiusValue {
        case ..<10:
            return .blue
        case 10..<20:
            return .black
        default:
            return .red
        }
    }
    
    init(temp: Double) {
        self.value = temp
    }
}
