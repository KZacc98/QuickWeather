//
//  WeatherDatatype.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 27/08/2024.
//

import UIKit

struct WeatherDataType {
    let category: WeatherCategory
    
    var isDetailed: Bool {
        let detailedDataTypes: [WeatherCategory] = [
            .temperature,
            .tempFeelsLike,
            .humidity,
            .rain,
            .snow,
            .pressure
        ]
        
        return detailedDataTypes.contains(category)
    }

    var title: String {
        switch category {
        case .temperature:
            return "Temperature"
        case .tempFeelsLike:
            return "Feels Like"
        case .humidity:
            return "Humidity"
        case .cloudiness:
            return "Cloudiness"
        case .windSpeed:
            return "Wind speed"
        case .rain:
            return "Rainfall"
        case .snow:
            return "Snowfall"
        case .pressure:
            return "Pressure"
        case .visibility:
            return "Visibility"
        }
    }

    var image: UIImage? {
        switch category {
        case .temperature:
            return UIImage(named: "Temperature")
        case .tempFeelsLike:
            return UIImage(named: "FeelsLike")
        case .humidity:
            return UIImage(named: "Humidity")
        case .cloudiness:
            return UIImage(named: "Cloudiness")
        case .windSpeed:
            return UIImage(named: "WindSpeed")
        case .rain:
            return UIImage(named: "Rain")
        case .snow:
            return UIImage(named: "Snow")
        case .pressure:
            return UIImage(named: "Pressure")
        case .visibility:
            return UIImage(named: "Visibility")
        }
    }
}
