//
//  QWTextField.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import UIKit

class QWTextField: UITextField {
    
    // MARK: - Properties
    
    var onTextFieldCleared: (() -> Void)?
    
    // MARK: - Private Properties
    
    private let validationBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.isHidden = true
        
        return view
    }()
    
    private let validationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .red
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 8
        label.isHidden = true
        
        return label
    }()
    
    private lazy var clearIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.image = UIImage(named: "XMark")
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearTextField)))
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private lazy var clearIconStackView: UIStackView = {
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.widthAnchor.constraint(equalToConstant: 8).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [clearIcon, spacerView])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let clearIconSize: CGFloat = 24
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupValidationLabel()
        setupClearIcon()
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
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
    
    // MARK: - Setup Validation Label
    
    private func setupValidationLabel() {
        addSubview(validationBackgroundView)
        validationBackgroundView.addSubview(validationLabel)
        
        NSLayoutConstraint.activate([
            validationBackgroundView.topAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            validationBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            validationBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            validationLabel.topAnchor.constraint(equalTo: validationBackgroundView.topAnchor),
            validationLabel.leadingAnchor.constraint(equalTo: validationBackgroundView.leadingAnchor),
            validationLabel.trailingAnchor.constraint(equalTo: validationBackgroundView.trailingAnchor),
            validationLabel.bottomAnchor.constraint(equalTo: validationBackgroundView.bottomAnchor)
        ])
    }
    
    private func setupClearIcon() {
        rightView = clearIconStackView
        rightViewMode = .always
        
        NSLayoutConstraint.activate([
            clearIcon.widthAnchor.constraint(equalToConstant: clearIconSize),
            clearIcon.heightAnchor.constraint(equalToConstant: clearIconSize)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func textDidChange() {
        clearIcon.isHidden = text?.isEmpty ?? true
    }
    
    @objc private func clearTextField() {
        resetTextField()
    }
    
    // MARK: - Update Validation Label
    
    func updateValidationLabel(withText text: String? = nil, isValid: Bool) {
        validationLabel.text = text
        validationLabel.textColor = isValid ? .clear : .red
        validationBackgroundView.isHidden = isValid
        validationLabel.isHidden = isValid
    }
    
    func resetTextField() {
        text = ""
        clearIcon.isHidden = true
        validationBackgroundView.isHidden = true
        onTextFieldCleared?()
        resignFirstResponder()
    }
}
