//
//  CityDetailsViewModel.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import UIKit

class CityDetailsViewModel {
    var showAlert: ((String, String) -> Void)?
    var cellDataChanged: (([WeatherCellData]) -> Void)?
    
    let worker = WeatherWorker()
    var city: CityRemote
    var weatherData: WeatherDomain? {
        didSet {
            guard let weatherData else { return }
            weatherCellData = makeWeatherCellData(weatherData: weatherData)
        }
    }
    
    var weatherCellData: [WeatherCellData] = [] {
        didSet {
            cellDataChanged?(weatherCellData)
        }
    }
    
    init(city: CityRemote) {
        self.city = city
    }
    
    func getWeather(for city: CityRemote) {
        worker.getWeatherData(for: city) { [weak self] result in
            switch result {
            case .success(let success):
                self?.weatherData = success
            case .failure(let failure):
                self?.handleError(error: failure)
            }
        }
    }
    
    func makeWeatherCellData(weatherData: WeatherDomain) -> [WeatherCellData] {
        var cellDataArray: [WeatherCellData] = []

        cellDataArray.append(createSimpleWeatherCellData(
            imageName: "FeelsLike",
            topText: "Feels Like",
            bottomText: weatherData.weatherDetails.feelsLike.localizedTemperature))
        cellDataArray.append(createGaugeWeatherCellData(
            imageName: "Humidity",
            topText: weatherData.weatherDetails.humidity.percentage,
            bottomText: "Humidity",
            gaugePercentage: weatherData.weatherDetails.humidity.gaugePercentage))
        cellDataArray.append(createGaugeWeatherCellData(
            imageName: "Cloudiness",
            topText: "\(weatherData.clouds.cloudiness)%",
            bottomText: "Cloudiness",
            gaugePercentage: CGFloat(weatherData.clouds.cloudiness) / 100.0))
        cellDataArray.append(createSimpleWeatherCellData(
            imageName: "Visibility", topText: "Visibility", bottomText: "\(weatherData.visibility) meters"))
        cellDataArray.append(createSimpleWeatherCellData(
            imageName: "WindSpeed",
            topText: "Wind Speed",
            bottomText: "\(weatherData.wind.speed) m/s"))

        if let rain = weatherData.rain {
            if let oneHourRain = rain.oneHour {
                cellDataArray.append(createSimpleWeatherCellData(
                    imageName: "Rain",
                    topText: "Rain (Last 1 Hour)",
                    bottomText: "\(oneHourRain) mm"))
            }
            if let threeHourRain = rain.threeHour {
                cellDataArray.append(createSimpleWeatherCellData(
                    imageName: "Rain",
                    topText: "Rain (Last 3 Hours)",
                    bottomText: "\(threeHourRain) mm"))
            }
        }

        if let snow = weatherData.snow {
            if let oneHourSnow = snow.oneHour {
                cellDataArray.append(createSimpleWeatherCellData(
                    imageName: "Snow",
                    topText: "Snow (Last 1 Hour)",
                    bottomText: "\(oneHourSnow) mm"))
            }
            if let threeHourSnow = snow.threeHour {
                cellDataArray.append(createSimpleWeatherCellData(
                    imageName: "Snow",
                    topText: "Snow (Last 3 Hours)",
                    bottomText: "\(threeHourSnow) mm"))
            }
        }

        cellDataArray.append(createSimpleWeatherCellData(
            imageName: "Pressure",
            topText: "Pressure",
            bottomText: weatherData.weatherDetails.pressure.inHPA))

        return cellDataArray
    }

    private func createSimpleWeatherCellData(
        imageName: String,
        topText: String,
        bottomText: String
    ) -> WeatherCellData {
        return WeatherCellData(
            image: UIImage(named: imageName),
            topText: topText,
            bottomText: bottomText)
    }

    private func createGaugeWeatherCellData(
        imageName: String,
        topText: String,
        bottomText: String,
        gaugePercentage: CGFloat
    ) -> WeatherCellData {
        let gaugeData = GaugeData(gaugePercentage: gaugePercentage)
        return WeatherCellData(
            cellType: .gauge,
            image: UIImage(named: imageName),
            topText: topText,
            bottomText: bottomText,
            gaugeData: gaugeData)
    }
    
    private func handleError(error: Error) {
        print("Error occurred: \(error.localizedDescription)")
        let errorMessage = error.localizedDescription.appending("\n Did you add your API Key?")
        showAlert?("Error", errorMessage)
    }
}
