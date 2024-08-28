//
//  WeatherDetailViewModel.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 28/08/2024.
//

import Foundation

class WeatherDetailViewModel {
    
    // MARK: - Properties
    
    let dataType: WeatherDataType
    let forecast: [ForecastDomain]
    
    // MARK: - Initializers
    
    init(dataType: WeatherDataType, forecast: [ForecastDomain]) {
        self.dataType = dataType
        self.forecast = forecast.sorted(by: { $0.dateTime < $1.dateTime })
    }
    
    // MARK: - Public Methods
    
    func createCellConfigurations() -> [DetailsCellData] {
        var configurations: [DetailsCellData] = []
        
        if let firstForecast = forecast.first {
            let valueText: String
            switch dataType.category {
            case .tempFeelsLike:
                valueText = firstForecast.weatherDetails.feelsLike.localizedTemperature
            case .temperature:
                valueText = firstForecast.weatherDetails.temperature.localizedTemperature
            case .humidity:
                valueText = firstForecast.weatherDetails.humidity.percentage
            case .pressure:
                valueText = firstForecast.weatherDetails.pressure.inHPA
            default:
                valueText = "N/A"
            }
            configurations.append(DetailsCellData(
                type: .simpleDetail,
                value: valueText,
                day: nil,
                time: dataType.title,
                fontColor: dataType.category == .temperature ? firstForecast.weatherDetails.temperature.color : .black
            ))
        } else {
            configurations.append(DetailsCellData(
                type: .simpleDetail,
                value: "N/A",
                day: nil,
                time: dataType.title
            ))
        }
        
        configurations.append(DetailsCellData(
            type: .dayHeader,
            value: "Value",
            day: "Time",
            time: nil
        ))
        
        for slice in forecast {
            let date = slice.dateTime
            var valueText: String?
            switch dataType.category {
            case .tempFeelsLike:
                valueText = slice.weatherDetails.feelsLike.localizedTemperature
            case .temperature:
                valueText = slice.weatherDetails.temperature.localizedTemperature
            case .humidity:
                valueText = slice.weatherDetails.humidity.percentage
            case .pressure:
                valueText = slice.weatherDetails.pressure.inHPA
            default:
                valueText = nil
            }
            configurations.append(DetailsCellData(
                type: .day,
                value: valueText,
                day: date.toTimeString(),
                time: date.localizedWeekdayName()
            ))
        }
        
        return configurations
    }
}
