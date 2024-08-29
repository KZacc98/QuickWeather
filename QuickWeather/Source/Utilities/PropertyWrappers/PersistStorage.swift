//
//  PersistStorage.swift
//  QuickWeather
//
//  Created by Kamil Zachara-personal on 29/08/2024.
//

import Foundation

@propertyWrapper
struct PersistStorage<T: Codable> {
    
    // MARK: - Public attributes
    
    let key: Key
    let defaultValue: T?
    let storage: UserDefaults
    
    // MARK: - Initialization 
    
    init(key: Key, defaultValue: T? = nil, storage: UserDefaults = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.storage = storage
    }
    
    var wrappedValue: T? {
        get {
            guard let data = storage.data(forKey: key.rawValue) else {
                return defaultValue
            }
            return try? JSONDecoder().decode(T.self, from: data)
        }
        set {
            if let object = newValue {
                let data = try? JSONEncoder().encode(object)
                storage.set(data, forKey: key.rawValue)
            } else {
                storage.removeObject(forKey: key.rawValue)
            }
            storage.synchronize()
        }
    }
}

extension PersistStorage {
    enum Key: String {
        case savedCities
    }
}
