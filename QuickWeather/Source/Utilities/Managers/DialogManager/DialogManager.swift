//
//  DialogManager.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 24/08/2024.
//

import UIKit

class DialogManager {
    
    static let shared = DialogManager()
    
    private init() {}
    
    func showAlert(
        on viewController: UIViewController,
        title: String,
        message: String,
        actions: [UIAlertAction] = [UIAlertAction(title: "alertActionOk".localized, style: .default)])
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        
        viewController.present(alertController, animated: true)
    }
}
