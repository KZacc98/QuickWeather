//
//  PlaceholderCell.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 27/08/2024.
//

import UIKit

class PlaceholderCell: UITableViewCell {

    // MARK: - Private Properties

    private let imageViewPlaceholder: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup View

    private func setupView() {
        contentView.addSubview(imageViewPlaceholder)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageViewPlaceholder.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageViewPlaceholder.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: imageViewPlaceholder.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }

    // MARK: - Configuration

    func configure(withImage image: UIImage?, andText text: String) {
        imageViewPlaceholder.image = image
        titleLabel.text = text
    }
    
    // MARK: - Prepare for Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageViewPlaceholder.image = nil
        titleLabel.text = nil
    }
}
