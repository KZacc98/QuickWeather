//
//  CityInfoHeaderView.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import UIKit

class CityInfoHeaderView: UICollectionReusableView {
    
    var didTapHeader: (() -> Void)?
    
    // MARK: - Private Properties
    
    private lazy var mainBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setShadow(cornerRadius: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 12
        blurEffectView.clipsToBounds = true
        
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        
        return view
    }()
    
    private lazy var moreIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        imageView.image = UIImage(named: "Info")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
        addTapGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    
    func setupAutoLayout() {
        addSubview(mainBackgroundView)
        mainBackgroundView.addSubview(moreIcon)
        mainBackgroundView.addSubview(temperatureLabel)
        mainBackgroundView.addSubview(cityLabel)
        
        NSLayoutConstraint.activate([
            mainBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            mainBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            mainBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            mainBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            
            moreIcon.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 8),
            moreIcon.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -8),
            moreIcon.widthAnchor.constraint(equalToConstant: 24),
            moreIcon.heightAnchor.constraint(equalToConstant: 24),
            
            cityLabel.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 12),
            cityLabel.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 12),
            cityLabel.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -12),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 12),
            temperatureLabel.bottomAnchor.constraint(equalTo: mainBackgroundView.bottomAnchor, constant: -12),
            temperatureLabel.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 12),
            temperatureLabel.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -12),
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with city: String, temperature: Temperature) {
        cityLabel.text = city
        temperatureLabel.text = temperature.localizedTemperature
        temperatureLabel.textColor = temperature.color
    }
    
    // MARK: - Gesture Handling
    
    private func addTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        mainBackgroundView.isUserInteractionEnabled = true
        mainBackgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap() {
        didTapHeader?()
    }
}
