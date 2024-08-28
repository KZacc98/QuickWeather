//
//  WeatherDetailViewController.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 27/08/2024.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    // MARK: - Binding Closures
    
    var closeModal: (() -> Void)?
    
    // MARK: - Public Properties
    
    var viewModel: WeatherDetailViewModel!
    
    // MARK: - Private Properties
    
    private var cellConfigurations: [DetailsCellData] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFrostedGlassBackground()
        setupNavigationBar()
        setupTableView()
        cellConfigurations = viewModel.createCellConfigurations()
        tableView.reloadData()
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
    
    private func setupTableView() {
        tableView.register(SimpleDetailCell.self, forCellReuseIdentifier: "SimpleDetailCell")
        tableView.register(DayCell.self, forCellReuseIdentifier: "DayCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Selectors
    
    @objc private func didPressCloseButton(_ sender: UIBarButtonItem) {
        closeModal?()
    }
}

// MARK: - UITableViewDataSource

extension WeatherDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellConfigurations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let config = cellConfigurations[indexPath.row]
        
        switch config.type {
        case .simpleDetail:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleDetailCell", for: indexPath) as! SimpleDetailCell
            cell.configure(topText: config.value ?? "N/A", bottomText: config.time ?? "", textColor: config.fontColor)
            cell.backgroundColor = .clear
            cell.isUserInteractionEnabled = false
            return cell
            
        case .dayHeader:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayCell
            cell.configure(text1: config.value ?? "", text2: config.time ?? "", text3: config.day ?? "", header: true)
            cell.backgroundColor = .clear
            cell.isUserInteractionEnabled = false
            return cell
            
        case .day:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DayCell", for: indexPath) as! DayCell
            cell.configure(text1: config.value ?? "", text2: config.time ?? "", text3: config.day ?? "")
            cell.backgroundColor = .clear
            cell.isUserInteractionEnabled = false
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension WeatherDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
