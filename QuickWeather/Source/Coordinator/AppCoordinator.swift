//
//  AppCoordinator.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import UIKit

class AppCoordinator {
    var navigationController: UINavigationController?
    
    func start() {
        pushCitySearch()
    }
    
    func pushCitySearch() {
        let viewController = CitySearchViewController()
        let viewModel = CitySearchViewModel()
        
        viewController.viewModel = viewModel
        
        viewController.getCity = { [weak viewModel] cityName in
            viewModel?.getCities(cityName: cityName)
        }
        
        viewController.onCitySelected = { [weak self] city in
            self?.pushCityDetails(for: city)
        }
        
        viewModel.showAlert = { [weak viewController] title, message in
            DispatchQueue.main.async {
                guard let viewController else { return }
                DialogManager.shared.showAlert(on: viewController, title: title, message: message)
            }
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushCityDetails(for city: CityRemote) {
        let viewController = CityDetailsViewController()
        let viewModel = CityDetailsViewModel(city: city)
        
        viewController.viewModel = viewModel
        viewController.city = city
        
        viewController.presentDetails = { [weak self] title, forecastData in
            DispatchQueue.main.async {
                self?.presentWeatherDetail(dataType: title, forecast: forecastData)
            }
        }
        
        viewModel.showAlert = { [weak viewController] title, message in
            DispatchQueue.main.async {
                guard let viewController else { return }
                DialogManager.shared.showAlert(on: viewController, title: title, message: message)
            }
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentWeatherDetail(dataType: WeatherDataType, forecast: [ForecastDomain]) {
        let viewController = WeatherDetailViewController()
        viewController.viewModel = WeatherDetailViewModel(dataType: dataType, forecast: forecast)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        viewController.closeModal = { [weak viewController] in
            viewController?.dismiss(animated: true, completion: nil)
        }
        
        self.navigationController?.present(navigationController, animated: true, completion: nil)
    }
}
