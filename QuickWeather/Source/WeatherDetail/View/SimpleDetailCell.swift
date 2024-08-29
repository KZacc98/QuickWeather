//
//  SimpleDetailCell.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 28/08/2024.
//

import UIKit

class SimpleDetailCell: UITableViewCell {

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
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    
    private func setupLayout() {
        contentView.addSubview(mainBackgroundView)
        mainBackgroundView.addSubview(topLabel)
        mainBackgroundView.addSubview(bottomLabel)
        
        NSLayoutConstraint.activate([
            mainBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            mainBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            topLabel.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 10),
            topLabel.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 10),
            topLabel.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -10),
            
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 10),
            bottomLabel.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 10),
            bottomLabel.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -10),
            bottomLabel.heightAnchor.constraint(equalToConstant: 50),
            bottomLabel.bottomAnchor.constraint(equalTo: mainBackgroundView.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configuration
    
    func configure(
        topText: String,
        bottomText: String,
        textColor: UIColor? = .black
    ) {
        topLabel.text = topText
        topLabel.textColor = textColor
        bottomLabel.text = bottomText
        bottomLabel.textColor = textColor
    }
    
    // MARK: - Prepare for Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        topLabel.text = nil
        topLabel.textColor = .black
        bottomLabel.text = nil
        bottomLabel.textColor = .black
    }
}
