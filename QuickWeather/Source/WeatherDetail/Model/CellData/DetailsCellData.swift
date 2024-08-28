//
//  DetailsCellData.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 28/08/2024.
//

import UIKit

struct DetailsCellData {
    let type: DetailsCellType
    let value: String?
    let day: String?
    let time: String?
    let fontColor: UIColor?
    
    init(type: DetailsCellType,
         value: String?,
         day: String?,
         time: String?,
         fontColor: UIColor? = .black) {
        self.type = type
        self.value = value
        self.day = day
        self.time = time
        self.fontColor = fontColor
    }
}
