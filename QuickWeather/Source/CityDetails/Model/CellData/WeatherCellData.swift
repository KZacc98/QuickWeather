//
//  WeatherCellData.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 26/08/2024.
//

import UIKit

struct WeatherCellData {
    let cellType: WeatherCellType
    let dataType: WeatherDataType
    let topText: String
    let bottomText: String
    let image: UIImage?
    let gaugeData: GaugeData?
    
    init(cellType: WeatherCellType = .simple,
         dataType: WeatherDataType,
         image: UIImage?,
         topText: String,
         bottomText: String,
         gaugeData: GaugeData? = nil) {
        self.cellType = cellType
        self.dataType = dataType
        self.image = image
        self.topText = topText
        self.bottomText = bottomText
        self.gaugeData = gaugeData
    }
}
