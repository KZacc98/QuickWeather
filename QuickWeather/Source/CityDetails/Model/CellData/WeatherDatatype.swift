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
            .pressure
        ]
        
        return detailedDataTypes.contains(category)
    }

    var title: String {
        switch category {
        case .temperature:
            return "temperature".localized
        case .tempFeelsLike:
            return "feelsLike".localized
        case .humidity:
            return "humidity".localized
        case .cloudiness:
            return "cloudiness".localized
        case .windSpeed:
            return "windSpeed".localized
        case .rain:
            return "rainfall".localized
        case .snow:
            return "snowfall".localized
        case .pressure:
            return "pressure".localized
        case .visibility:
            return "visibility".localized
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
