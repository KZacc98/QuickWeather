//
//  CustomGaugeView.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 25/08/2024.
//

import UIKit

class CustomGaugeView: UIView {

    // MARK: - Private Properties
    
    private let animationDuration: CFTimeInterval = 0.5
    private let shapeLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    
    var progress: CGFloat = 0 {
        didSet {
            progress = min(max(progress, 0), 1)
            animateProgress()
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout Setup
    
    private func setupView() {
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor

        backgroundLayer.lineCap = .round
        backgroundLayer.fillColor = UIColor.clear.cgColor
        configureGauge()
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(shapeLayer)
    }
    
    // MARK: - Configuration
    
    func configureGauge(progressValue: CGFloat = 0.5,
                        strokeColor: UIColor = .systemBlue,
                        gaugeBackgroundColor: UIColor = .lightGray,
                        gaugeWidth: CGFloat = 20) {
        shapeLayer.strokeColor = strokeColor.cgColor
        backgroundLayer.strokeColor = gaugeBackgroundColor.cgColor
        progress = progressValue
        shapeLayer.lineWidth = gaugeWidth
        backgroundLayer.lineWidth = gaugeWidth
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius = bounds.width / 2.5
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let startAngle = CGFloat(Double.pi)
        let endAngle = CGFloat(0)
        
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true)
        
        backgroundLayer.path = path.cgPath
        shapeLayer.path = path.cgPath
    }
    
    private func animateProgress() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fromValue = 0
        basicAnimation.toValue = progress
        basicAnimation.duration = animationDuration
        
        shapeLayer.strokeEnd = progress
        shapeLayer.add(basicAnimation, forKey: "progressAnimation")
    }
}
