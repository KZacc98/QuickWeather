//
//  CitySearchViewController.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 23/08/2024.
//

import UIKit

class CitySearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Binding Closures
    
    var getCity: ((String) -> Void)?
    
    // MARK: - Properties
    
    var viewModel: CitySearchViewModel!
    
    lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Horizontal pager, just for funzies ATM
    // TODO: do we need this doe?
    lazy var colorPager: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "colorCell")
        return collectionView
    }()
    
    lazy var button: QWButton = {
        let button = QWButton(backgroundColor: .blue, title: "SEARCH")
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var cityTextField: QWTextField = {
        let textField = QWTextField()
        return textField
    }()
    
    let colors: [UIColor] = [.red, .green, .blue, .orange, .purple]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        setupAutoLayout()
        addKeyboardObservers()
    }
    
    deinit {
        removeKeyboardObservers()
    }
    
    // MARK: - Keyboard Handling
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let keyboardHeight = keyboardFrame.height
        let bottomInset = keyboardHeight - view.safeAreaInsets.bottom
        
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.view.frame.origin.y = -bottomInset
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        UIView.animate(withDuration: animationDuration) { [weak self] in
            self?.view.frame.origin.y = 0
        }
    }
    
    // MARK: - Button Action
    
    @objc private func buttonTapped() {
        guard
            let cityName = cityTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            cityName.isEmpty == false
        else { return }
        
        getCity?(cityName)
    }
    
    // MARK: - Setup AutoLayout
    
    private func setupContainer() {
        view.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupTextField() {
        container.addSubview(cityTextField)
        
        NSLayoutConstraint.activate([
            cityTextField.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -20),
            cityTextField.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            cityTextField.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            cityTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupButton() {
        container.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            button.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            button.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupPager() {
        container.addSubview(colorPager)
        
        NSLayoutConstraint.activate([
            colorPager.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor),
            colorPager.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            colorPager.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            colorPager.bottomAnchor.constraint(equalTo: cityTextField.topAnchor, constant: -20)
        ])
    }
    
    private func setupAutoLayout() {
        setupContainer()
        setupButton()
        setupTextField()
        setupPager()
    }
}

// MARK: - UICollectionView Data Source

extension CitySearchViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
}
