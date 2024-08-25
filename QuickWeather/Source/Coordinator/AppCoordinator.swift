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
        
        viewModel.showAlert = { [weak viewController] title, message in
            DispatchQueue.main.async {
                guard let viewController else { return }
                DialogManager.shared.showAlert(on: viewController, title: title, message: message)
            }
        }
        
        viewController.viewModel = viewModel
        
        viewController.getCity = { [weak viewModel] cityName in
            viewModel?.callAPI(cityName: cityName)
        }
        
        viewController.onCitySelected = { [weak self] city in
            self?.pushCityDetails(for: city)
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushCityDetails(for city: CityRemote) {
        let viewController = CityDetailsViewController()
        
        viewController.city = city
        
        viewController.buttonAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
