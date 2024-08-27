//
//  GaugeCell.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import UIKit

class GaugeCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var mainBackgroundView: UIView = {
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
    
    lazy var supplementaryIcon: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.isHidden = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var moreIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        imageView.image = UIImage(named: "Info")
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    lazy var gaugeView: CustomGaugeView = {
        let gauge = CustomGaugeView()
        gauge.translatesAutoresizingMaskIntoConstraints = false
        
        return gauge
    }()
    
    lazy var gaugeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    
    func setupAutoLayout() {
        contentView.addSubview(mainBackgroundView)
        mainBackgroundView.addSubview(gaugeView)
        gaugeView.addSubview(gaugeLabel)
        gaugeView.addSubview(descriptionLabel)
        mainBackgroundView.addSubview(supplementaryIcon)
        mainBackgroundView.addSubview(moreIcon)
        
        NSLayoutConstraint.activate([
            mainBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            mainBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            mainBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            moreIcon.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 8),
            moreIcon.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -8),
            moreIcon.widthAnchor.constraint(equalToConstant: 24),
            moreIcon.heightAnchor.constraint(equalToConstant: 24),
            
            gaugeView.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 12),
            gaugeView.bottomAnchor.constraint(equalTo: mainBackgroundView.bottomAnchor, constant: -12),
            gaugeView.centerXAnchor.constraint(equalTo: mainBackgroundView.centerXAnchor),
            gaugeView.widthAnchor.constraint(equalToConstant: 100),
            
            gaugeLabel.centerXAnchor.constraint(equalTo: gaugeView.centerXAnchor),
            gaugeLabel.centerYAnchor.constraint(equalTo: gaugeView.centerYAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: gaugeLabel.bottomAnchor, constant: 8),
            descriptionLabel.centerXAnchor.constraint(equalTo: gaugeView.centerXAnchor),
            
            supplementaryIcon.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 8),
            supplementaryIcon.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 8),
            supplementaryIcon.widthAnchor.constraint(equalToConstant: 25),
            supplementaryIcon.heightAnchor.constraint(equalTo: supplementaryIcon.widthAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with data: WeatherCellData) {
        guard let gaugeData = data.gaugeData else { return }
        
        gaugeView.configureGauge(
            progressValue: gaugeData.gaugePercentage,
            strokeColor: gaugeData.gaugeStrokeColor,
            gaugeBackgroundColor: gaugeData.gaugeStrokeBackgroundColor,
            gaugeWidth: gaugeData.gaugeWidth)
        
        gaugeLabel.text = data.topText
        descriptionLabel.text = data.bottomText
        
        if let image = data.image {
            supplementaryIcon.image = image
            supplementaryIcon.isHidden = false
        } else {
            supplementaryIcon.isHidden = true
        }
        
        if data.dataType.isDetailed {
            moreIcon.isHidden = false
        } else {
            moreIcon.isHidden = true
        }
    }
}
