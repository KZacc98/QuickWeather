//
//  WeatherDetailsDomain.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import Foundation

struct WeatherDetailsDomain {
    /// Temperature in Kelvin (default), Celsius (metric), or Fahrenheit (imperial).
    let temperature: Temperature
    
    /// Temperature accounting for human perception.
    let feelsLike: Temperature
    
    /// Atmospheric pressure on the sea level, in hPa.
    let pressure: Pressure
    
    /// Humidity percentage.
    let humidity: Humidity
    
    /// Minimum observed temperature at the moment.
    let tempMin: Temperature
    
    /// Maximum observed temperature at the moment.
    let tempMax: Temperature
    
    /// Atmospheric pressure on the sea level, in hPa.
    let seaLevel: Pressure?
    
    /// Atmospheric pressure on the ground level, in hPa.
    let grndLevel: Pressure?
    
    init(remote: WeatherDetailsRemote) {
        self.temperature = Temperature(temp: remote.temp)
        self.feelsLike = Temperature(temp: remote.feelsLike)
        self.pressure = Pressure(pressure: remote.pressure)
        self.humidity = Humidity(humidity: remote.humidity)
        self.tempMin = Temperature(temp: remote.tempMin)
        self.tempMax = Temperature(temp: remote.tempMax)
        self.seaLevel = Pressure(pressure: remote.seaLevel)
        self.grndLevel = Pressure(pressure: remote.grndLevel)
    }
}
