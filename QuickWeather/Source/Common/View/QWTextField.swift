//
//  QWTextField.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import UIKit

class QWTextField: UITextField {

    let validationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .red
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupValidationLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        backgroundColor = .tertiarySystemGroupedBackground
        autocorrectionType = .no
        translatesAutoresizingMaskIntoConstraints = false
    }

    private func setupValidationLabel() {
        addSubview(validationLabel)
        
        NSLayoutConstraint.activate([
            validationLabel.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 5),
            validationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            validationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

    func updateValidationLabel(withText text: String? = nil, isValid: Bool) {
        validationLabel.text = text
        validationLabel.textColor = .red
        validationLabel.isHidden = isValid
    }
}
