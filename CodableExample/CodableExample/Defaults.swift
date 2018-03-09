//
//  Defaults.swift
//  CodableExample
//
//  Created by Danno on 3/8/18.
//  Copyright © 2018 Daniel Heredia. All rights reserved.
//

import Foundation

// MARK: - Extension to save codable objects
extension UserDefaults {
    
    func setCodableValue<T: Codable>(_ value: T, forKey key: String) {
        self.setValue(try? PropertyListEncoder().encode(value), forKey: key)
    }
    
    func codableValue<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = self.value(forKeyPath: key) as? Data else {
            return nil
        }
        return try? PropertyListDecoder().decode(T.self, from: data)
    }
}
