//
//  Int+Extension.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 28/08/2024.
//

import Foundation

extension Int {
    var toDate: Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
