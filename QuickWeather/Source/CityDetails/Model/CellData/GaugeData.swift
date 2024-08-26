//
//  GaugeData.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import UIKit

struct GaugeData {
    let gaugePercentage: CGFloat
    let gaugeStrokeColor: UIColor
    let gaugeStrokeBackgroundColor: UIColor
    let gaugeWidth: CGFloat
    
    init(gaugePercentage: CGFloat,
         gaugeStrokeColor: UIColor = .systemBlue,
         gaugeStrokeBackgroundColor: UIColor = .lightGray,
         gaugeWidth: CGFloat = 10) {
        self.gaugePercentage = gaugePercentage
        self.gaugeStrokeColor = gaugeStrokeColor
        self.gaugeStrokeBackgroundColor = gaugeStrokeBackgroundColor
        self.gaugeWidth = gaugeWidth
    }
}
