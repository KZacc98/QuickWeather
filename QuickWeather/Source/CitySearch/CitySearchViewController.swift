//
//  CitySearchViewController.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import UIKit

class CitySearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // MARK: - Binding Closures
    
    var getCity: ((String) -> Void)?
    var onCitySelected: ((CityRemote) -> Void)?
    
    // MARK: - Private Properties
    
    private var cities: Cities = []
    
    // MARK: - Properties
    
    var viewModel: CitySearchViewModel!
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var searchBar: QWTextField = {
        let textField = QWTextField()
        textField.placeholder = "Enter city name"
        textField.returnKeyType = .search
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CitySearchTableViewCell.self, forCellReuseIdentifier: "CitySearchCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setupAutoLayout()
        bindViewModel()
    }
    
    // MARK: - Bind ViewModel
    
    private func bindViewModel() {
        viewModel.citiesDidChange = { [weak self] locations in
            DispatchQueue.main.async {
                self?.cities = locations
                self?.resultsTableView.reloadData()
            }
        }
    }
    
    // MARK: - Setup AutoLayout
    
    private func setupContainer() {
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
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
        let tableViewTopPadding: CGFloat = 25
        
        container.addSubview(resultsTableView)
        
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

extension CitySearchViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCity = cities[indexPath.row]
        
        print("Selected Location: \(selectedCity)")
        onCitySelected?(selectedCity)
    }
}

// MARK: - UITextFieldDelegate

extension CitySearchViewController {
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
            searchBar.updateValidationLabel(isValid: true)
            viewModel.getCities(cityName: cityName)
            textField.resignFirstResponder()
        } else {
            searchBar.updateValidationLabel(withText: "Invalid input. Only letters and spaces are allowed.", isValid: false)
        }
        
        return false
    }
}
