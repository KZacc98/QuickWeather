//
//  CitySearchViewController.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import UIKit

class CitySearchViewController: UIViewController {
    
    // MARK: - Binding Closures
    
    var getCity: ((String) -> Void)?
    var onCitySelected: ((CityRemote) -> Void)?
    
    // MARK: - Private Properties
    
    private var cities: [CityRemote] = []
    
    // MARK: - Properties
    
    var viewModel: CitySearchViewModel! {
        didSet {
            cities = viewModel.cities
        }
    }
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        layer.locations = [0.0, 1.0]
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        return layer
    }()
    
    lazy var searchBar: QWTextField = {
        let textField = QWTextField()
        textField.placeholder = "Enter city name"
        textField.returnKeyType = .search
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.onTextFieldCleared = { [weak self] in
            self?.viewModel.setSavedCities()
        }
        
        return textField
    }()
    
    lazy var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        title = "Search"
        setupBackgroundView()
        setupAutoLayout()
        setupSpinner()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateGradientForTimeOfDay()
        searchBar.resetTextField()
    }
    
    // MARK: - Bind ViewModel
    
    private func bindViewModel() {
        viewModel.citiesDidChange = { [weak self] locations in
            DispatchQueue.main.async {
                self?.cities = locations
                self?.resultsTableView.reloadData()
                self?.spinner.stopAnimating()
            }
        }
    }
    
    // MARK: - Setup Layout
    
    private func setupContainer() {
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupSpinner() {
        container.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupBackgroundView() {
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func updateGradientColors(topColor: UIColor, bottomColor: UIColor) {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    }
    
    private func updateGradientForTimeOfDay() {
        let hour = Calendar.current.component(.hour, from: Date())
        var topColor: UIColor
        var bottomColor: UIColor
        
        switch hour {
        case 6...8:
            topColor = UIColor(named: "DawnTop") ?? .white
            bottomColor = UIColor(named: "DawnBottom") ?? .white
        case 9...16:
            topColor = UIColor(named: "DayTop") ?? .white
            bottomColor = UIColor(named: "DayBottom") ?? .white
        case 17...19:
            topColor = UIColor(named: "DuskTop") ?? .white
            bottomColor = UIColor(named: "DuskBottom") ?? .white
        default:
            topColor = UIColor(named: "NightTop") ?? .white
            bottomColor = UIColor(named: "NightBottom") ?? .white
        }
        
        updateGradientColors(topColor: topColor, bottomColor: bottomColor)
    }
    
    private func setupSearchBar() {
        let searchBarTopPadding: CGFloat = 20
        let searchBarHorizontalPadding: CGFloat = 12
        let searchBarHeight: CGFloat = 50
        
        container.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: searchBarTopPadding),
            searchBar.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: searchBarHorizontalPadding),
            searchBar.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -searchBarHorizontalPadding),
            searchBar.heightAnchor.constraint(equalToConstant: searchBarHeight)
        ])
    }
    
    private func setupTableView() {
        let tableViewTopPadding: CGFloat = 30
        
        container.addSubview(resultsTableView)
        
        resultsTableView.register(PlaceholderCell.self, forCellReuseIdentifier: "PlaceholderCell")
        resultsTableView.register(CitySearchTableViewCell.self, forCellReuseIdentifier: "CitySearchCell")
        
        NSLayoutConstraint.activate([
            resultsTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: tableViewTopPadding),
            resultsTableView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    
    private func setupAutoLayout() {
        setupContainer()
        setupSearchBar()
        setupTableView()
    }
}

// MARK: - UITableViewDataSource

extension CitySearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.isEmpty ? 1 : cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cities.isEmpty {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "PlaceholderCell",
                for: indexPath) as? PlaceholderCell
            else {
                return UITableViewCell()
            }
            
            cell.configure(
                withImage: UIImage(named: "Search"),
                andText: "Perform your first search, previously searched cities will appear here for easier access")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: "CitySearchCell",
                for: indexPath) as? CitySearchTableViewCell
            else {
                return UITableViewCell()
            }
            
            let location = cities[indexPath.row]
            cell.configure(with: location)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !cities.isEmpty {
            tableView.deselectRow(at: indexPath, animated: true)
            let selectedCity = cities[indexPath.row]
            onCitySelected?(selectedCity)
            viewModel.addCityToSavedCities(selectedCity)
        } else {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate

extension CitySearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard
            let cityName = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !cityName.isEmpty
        else {
            searchBar.updateValidationLabel(withText: "Input cannot be empty", isValid: false)
            
            return false
        }
        
        let isValid = viewModel.validateCityName(cityName)
        
        if isValid {
            spinner.startAnimating()
            searchBar.updateValidationLabel(isValid: true)
            viewModel.getCities(cityName: cityName)
            textField.resignFirstResponder()
        } else {
            searchBar.updateValidationLabel(withText: "Invalid input. Only letters and spaces are allowed.", isValid: false)
        }
        
        return false
    }
}
