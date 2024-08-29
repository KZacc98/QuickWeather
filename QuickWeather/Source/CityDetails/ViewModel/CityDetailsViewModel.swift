//
//  CityDetailsViewModel.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import UIKit

class CityDetailsViewModel {
    
    // MARK: - Binding Closures
    
    var showAlert: ((String, String) -> Void)?
    var cellDataChanged: (([WeatherCellData]) -> Void)?
    var updateGradient: (((topColor: UIColor, bottomColor: UIColor)) -> Void)?
    var presentDetails: ((WeatherDataType, [ForecastDomain]) -> Void)?
    var onError: (() -> Void)?
    
    // MARK: - Properties
    
    let worker = WeatherWorker()
    var city: CityRemote
    var forecastDetails: WeatherForecastDomain?
    
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
    
    // MARK: - Public methods
    
    func getWeatherDetails(for type: WeatherDataType) {
        if let forecastDetails {
            presentDetails?(type, forecastDetails.forecasts)
        } else {
            worker.getForecast(for: city) { [weak self] result in
                switch result {
                case .success(let success):
                    self?.forecastDetails = success
                    self?.presentDetails?(type, success.forecasts)
                case .failure(let failure):
                    self?.handleError(error: failure)
                }
            }
        }
    }
    
    func createCellData(
        for category: WeatherCategory,
        bottomText: String,
        gaugePercentage: CGFloat? = nil
    ) -> WeatherCellData {
        let weatherDataType = WeatherDataType(category: category)
        
        if let gaugePercentage = gaugePercentage {
            return createGaugeWeatherCellData(
                weatherDataType: weatherDataType,
                description: weatherDataType.title,
                gaugeText: bottomText,
                gaugePercentage: gaugePercentage
            )
        } else {
            return createSimpleWeatherCellData(
                weatherDataType: weatherDataType,
                bottomText: bottomText
            )
        }
    }
    
    func makeWeatherCellData(weatherData: WeatherDomain) -> [WeatherCellData] {
        let feelsLike = createCellData(
            for: .tempFeelsLike,
            bottomText: weatherData.weatherDetails.feelsLike.localizedTemperature)
        let humidity = createCellData(
            for: .humidity,
            bottomText: weatherData.weatherDetails.humidity.percentage,
            gaugePercentage: weatherData.weatherDetails.humidity.gaugePercentage)
        let cloudiness = createCellData(
            for: .cloudiness,
            bottomText: String(format: "cloudinessFormat".localized, weatherData.clouds.cloudiness),
            gaugePercentage: CGFloat(weatherData.clouds.cloudiness) / 100.0)
        let windSpeed = createCellData(
            for: .windSpeed,
            bottomText: String(format: "windSpeedFormat".localized, weatherData.wind.speed))
        let pressure = createCellData(
            for: .pressure,
            bottomText: weatherData.weatherDetails.pressure.inHPA)
        
        var cellDataArray: [WeatherCellData] = [
            feelsLike,
            humidity,
            cloudiness,
            windSpeed,
            pressure
        ]
        
        if let visibility = weatherData.visibility {
            let visibility = createCellData(
                for: .visibility,
                bottomText: String(format: "visibilityFormat".localized, visibility))
            cellDataArray.append(visibility)
        }

        if let rain = weatherData.rain, let oneHourRain = rain.oneHour {
            let rainData = createCellData(
                for: .rain,
                bottomText: String(format: "rainSnowFormat".localized, oneHourRain))
            cellDataArray.insert(rainData, at: 0)
        }

        if let snow = weatherData.snow, let oneHourSnow = snow.oneHour {
            let snowData = createCellData(
                for: .snow,
                bottomText: String(format: "rainSnowFormat".localized, oneHourSnow))
            cellDataArray.insert(snowData, at: 0)
        }

        return cellDataArray
    }
    
    // MARK: - Private Methods
    
    private func createSimpleWeatherCellData(
        weatherDataType: WeatherDataType,
        bottomText: String
    ) -> WeatherCellData {
        return WeatherCellData(
            dataType: weatherDataType,
            image: weatherDataType.image,
            topText: weatherDataType.title,
            bottomText: bottomText
        )
    }

    private func createGaugeWeatherCellData(
        weatherDataType: WeatherDataType,
        description: String,
        gaugeText: String,
        gaugePercentage: CGFloat
    ) -> WeatherCellData {
        let gaugeData = GaugeData(gaugePercentage: gaugePercentage)
        return WeatherCellData(
            cellType: .gauge,
            dataType: weatherDataType,
            image: weatherDataType.image,
            topText: gaugeText,
            bottomText: description,
            gaugeData: gaugeData
        )
    }
    
    private func handleError(error: Error) {
        print("Error occurred: \(error.localizedDescription)")
        let errorMessage = error.localizedDescription.appending("apiKeyMessage".localized)
        showAlert?("error".localized, errorMessage)
        onError?()
    }
}
