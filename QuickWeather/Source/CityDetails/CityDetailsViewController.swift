//
//  CityDetailsViewController.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import UIKit

class CityDetailsViewController: UIViewController {

    // MARK: - Properties

    var city: CityRemote?
    var viewModel: CityDetailsViewModel!
    var isLoading = true
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "City Details"
        setupCollectionView()
        setupSpinner()
        bindViewModel()
        viewModel.getWeather(for: viewModel.city)
    }
    
    // MARK: - Bind ViewModel
    
    private func bindViewModel() {
        viewModel.cellDataChanged = { [weak self] cellData in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.spinner.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Setup Spinner
    
    func setupSpinner() {
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.startAnimating()
    }
    
    // MARK: - Setup CollectionView
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        registerReusableViews()
        setupCollectionViewLayout()
    }
    
    func registerReusableViews() {
        collectionView.register(
            CityInfoHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "CityInfoHeaderView")
        
        collectionView.register(
            GaugeCell.self,
            forCellWithReuseIdentifier: "GaugeCell")
        
        collectionView.register(
            SimpleWeatherCell.self,
            forCellWithReuseIdentifier: "SimpleWeatherCell")
    }
    
    func setupCollectionViewLayout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension CityDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isLoading {
            return 0
        } else {
            guard let weatherData = viewModel.weatherData else { return 0 }
            
            let cellData = viewModel.makeWeatherCellData(weatherData: weatherData)
            
            return cellData.count
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let weatherCellData = viewModel.weatherCellData[indexPath.item]
        
        switch weatherCellData.cellType {
        case .gauge:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "GaugeCell",
                for: indexPath) as! GaugeCell
            cell.configure(with: weatherCellData)
            
            return cell
        case .simple:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "SimpleWeatherCell",
                for: indexPath) as! SimpleWeatherCell
            cell.configure(with: weatherCellData)
            
            return cell
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let weatherCellData = viewModel.weatherCellData[indexPath.item]
        
        switch weatherCellData.cellType {
        case .gauge:
            let width = (collectionView.frame.width - 30) / 2
            return CGSize(width: width, height: 150)
            
        case .simple:
            return CGSize(width: collectionView.frame.width - 20, height: 100)
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "CityInfoHeaderView",
                for: indexPath) as? CityInfoHeaderView
        else { return UICollectionReusableView() }
        
        if let city = city,
           let weatherData = viewModel.weatherData {
            header.configure(
                with: city.name,
                temperature: weatherData.weatherDetails.temperature.localizedTemperature)
        }
        
        return header
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let test = WeatherWorker()
        
        test.getForecast(for: viewModel.city) { result in
            switch result {
            case .success(let success):
                dump(success)
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}
