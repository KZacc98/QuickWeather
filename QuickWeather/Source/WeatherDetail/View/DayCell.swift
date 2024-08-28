//
//  DayCell.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 28/08/2024.
//

import UIKit

class DayCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private lazy var mainBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var label1: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var label2: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var label3: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconView, label1, label2, label3])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        contentView.addSubview(mainBackgroundView)
        mainBackgroundView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            mainBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: mainBackgroundView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: mainBackgroundView.bottomAnchor, constant: -12),
            stackView.leadingAnchor.constraint(equalTo: mainBackgroundView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: mainBackgroundView.trailingAnchor, constant: -8)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconView.image = nil
        iconView.isHidden = true
        
        label1.text = nil
        label1.isHidden = true
        
        label2.text = nil
        label2.isHidden = true
        
        label3.text = nil
        label3.isHidden = true
    }
    
    // MARK: - Configuration
    
    func configure(
        image: UIImage? = nil,
        text1: String? = nil,
        text2: String? = nil,
        text3: String? = nil,
        header: Bool = false
    ) {
        let font: UIFont
        
        if header {
            font = UIFont.systemFont(ofSize: 20, weight: .bold)
        } else {
            font = UIFont.systemFont(ofSize: 20, weight: .regular)
        }
        
        if let image {
            iconView.image = image
            iconView.isHidden = false
        } else {
            iconView.isHidden = true
        }
        
        if let text1 {
            label1.text = text1
            label1.font = font
            label1.isHidden = false
        } else {
            label1.isHidden = true
        }
        
        if let text2 {
            label2.text = text2
            label2.font = font
            label2.isHidden = false
        } else {
            label2.isHidden = true
        }
        
        if let text3 {
            label3.text = text3
            label3.font = font
            label3.isHidden = false
        } else {
            label3.isHidden = true
        }
    }
}
