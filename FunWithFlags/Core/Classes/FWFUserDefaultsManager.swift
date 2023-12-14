//
//  FWFUserDefaultsManager.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/9/21.
//

import Foundation

final class FWFUserDefaultsManager {
    private init() {}
    static let shared = FWFUserDefaultsManager()
    
    enum Keys: String {
        case countries
    }
    
    func storeCountriesData(data: [Country]) {
        do {
            let encoded = try JSONEncoder().encode(data)
            UserDefaults.standard.set(encoded, forKey: FWFUserDefaultsManager.Keys.countries.rawValue)
        } catch let error {
            print(error)
        }
    }
    
    func getLocalCountriesData() -> [Country] {
        if let data = UserDefaults.standard.data(forKey: FWFUserDefaultsManager.Keys.countries.rawValue) {
            do {
                let countries = try JSONDecoder().decode([Country].self, from: data)
                return countries
            } catch let error {
                print(error)
                return []
            }
        } else {
            return []
        }
    }
}
