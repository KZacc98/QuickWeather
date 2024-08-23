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
        viewController.buttonAction = { [weak self] in
            self?.pushCityDetails()
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushCityDetails() {
        let viewController = CityDetailsViewController()
        
        viewController.buttonAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
