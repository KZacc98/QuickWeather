//
//  CityDetailsViewController.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import UIKit

class CityDetailsViewController: UIViewController {
    
    // MARK: - Binding Closures

    var presentDetails: ((WeatherDataType, [ForecastDomain]) -> Void)?
    
    // MARK: - Properties
    
    var city: CityRemote?
    var viewModel: CityDetailsViewModel!
    var isLoading = true
    
    // MARK: - Private Properties
    
    private var gradientIndex = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
        layer.locations = [0.0, 1.0]
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        return layer
    }()
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "weather".localized
        setupBackgroundView()
        setupCollectionView()
        setupSpinner()
        bindViewModel()
        viewModel.getWeather(for: viewModel.city)
        updateGradientForTimeOfDay()
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
        
        viewModel.updateGradient = { [weak self] colors in
            self?.updateGradientColors(
                topColor: colors.topColor,
                bottomColor: colors.bottomColor)
        }
        
        viewModel.presentDetails = { [weak self] title, data in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
                self?.presentDetails?(title, data)
            }
        }
        
        viewModel.onError = { [weak self] in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
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
    
    // MARK: - Setup background gradient
    
    func setupBackgroundView() {
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func updateGradientColors(topColor: UIColor, bottomColor: UIColor) {
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    }
    
    func updateGradientForTimeOfDay() {
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
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func cycleThroughGradients() {
        let gradients: [(UIColor, UIColor)] = [
            (UIColor(named: "DawnTop") ?? .white,
             UIColor(named: "DawnBottom") ?? .white),
            
            (UIColor(named: "DayTop") ?? .white,
             UIColor(named: "DayBottom") ?? .white),
            
            (UIColor(named: "DuskTop") ?? .white,
             UIColor(named: "DuskBottom") ?? .white),
            
            (UIColor(named: "NightTop") ?? .white,
             UIColor(named: "NightBottom") ?? .white)
        ]
        
        let gradient = gradients[gradientIndex % gradients.count]
        updateGradientColors(topColor: gradient.0, bottomColor: gradient.1)
        
        gradientIndex += 1
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
            let width = (collectionView.frame.width - 36) / 2
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
        return CGSize(width: collectionView.frame.width, height: 200)
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
                temperature: weatherData.weatherDetails.temperature)
            
            header.didTapHeader = { [weak self] in
                self?.spinner.startAnimating()
                self?.viewModel.getWeatherDetails(for: .init(category: .temperature))
            }
        }
        
        return header
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let weatherCellData = viewModel.weatherCellData[indexPath.item]
        
        if weatherCellData.dataType.isDetailed {
            spinner.startAnimating()
            viewModel.getWeatherDetails(for: weatherCellData.dataType)
        } else {
            cycleThroughGradients()
        }
    }
}
