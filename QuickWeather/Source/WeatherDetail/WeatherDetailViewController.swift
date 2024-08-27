//
//  WeatherDetailViewController.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 27/08/2024.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var closeModal: (() -> Void)?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFrostedGlassBackground()
        setupNavigationBar()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        let closeButton = UIBarButtonItem(
            image: UIImage(named: "XMark"),
            style: .plain,
            target: self,
            action: #selector(didPressCloseButton(_:)))
        closeButton.tintColor = .black
        
        navigationItem.rightBarButtonItem = closeButton
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupFrostedGlassBackground() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(blurEffectView)
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Selectors
    
    @objc private func didPressCloseButton(_ sender: UIBarButtonItem) {
        closeModal?()
    }
}
