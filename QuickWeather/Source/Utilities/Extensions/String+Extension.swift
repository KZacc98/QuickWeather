//
//  String+Extension.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 29/08/2024.
//

import UIKit

extension String {
    var localized: String {
        let preferred = NSLocale.preferredLanguages.first?.split(separator: "-").first.flatMap {
            String($0) } ?? "en"
        let languageBundle = Bundle.main.path(forResource: preferred, ofType: "lproj").flatMap {
            Bundle(path: $0) } ?? Bundle.main
        
        return languageBundle.localizedString(forKey: self, value: self, table: nil)
    }
}
