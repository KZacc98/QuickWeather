//
//  CitySearchTableViewCell.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 24/08/2024.
//

import UIKit
import FlagKit

class CitySearchTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 8
        label.textColor = .label
        
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    // MARK: - Layout Setup
    
    private func setupLayout() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    // MARK: - Configuration
    
    func configure(with city: CityRemote) {
        var mainString = NSAttributedString(string: "\(city.name),")
        if let state = city.state {
            mainString = mainString.appending(NSAttributedString(string: " \(state) "))
        }
        
        if let flag = Flag(countryCode: city.country) {
            mainString = mainString.appending(image: flag.image(style: .square))
        }
        
        titleLabel.attributedText = mainString
    }
    
    // MARK: - Prepare for Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
}
