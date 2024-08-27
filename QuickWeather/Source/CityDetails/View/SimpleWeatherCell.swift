//
//  SimpleWeatherCell.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import UIKit

class SimpleWeatherCell: UICollectionViewCell {
    
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
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [iconImageView])
        view.axis = .horizontal
        view.distribution = .fill
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
    
    lazy var labelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .left
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
        mainBackgroundView.addSubview(moreIcon)
        mainBackgroundView.addSubview(stackView)
        
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(labelContainer)
        
        labelContainer.addSubview(topLabel)
        labelContainer.addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            mainBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            mainBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            mainBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            mainBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            moreIcon.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 8),
            moreIcon.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -8),
            moreIcon.widthAnchor.constraint(equalToConstant: 24),
            moreIcon.heightAnchor.constraint(equalToConstant: 24),
            
            stackView.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: mainBackgroundView.bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -12),
            
            iconImageView.widthAnchor.constraint(equalToConstant: 50),
            
            topLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor),
            topLabel.topAnchor.constraint(equalTo: labelContainer.topAnchor),
            
            bottomLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor),
            bottomLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor),
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 8),
            bottomLabel.bottomAnchor.constraint(equalTo: labelContainer.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with data: WeatherCellData) {
        topLabel.text = data.topText
        bottomLabel.text = data.bottomText
        if let image = data.image {
            iconImageView.image = image
            iconImageView.isHidden = false
        } else {
            iconImageView.isHidden = true
        }
        
        if data.dataType.isDetailed {
            moreIcon.isHidden = false
        } else {
            moreIcon.isHidden = true
        }
    }
}
