//
//  Country.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation

struct Country: Codable {
    let name: String?
    let flag: String?
    let alpha2Code: String?
    let alpha3Code: String?
    let callingCodes: [String]?
    let capital: String?
    let altSpellings: [String]?
    let region: String?
    let subregion: String?
    let population: Int?
    let demonym: String?
    let timezones: [String]?
    let nativeName: String?
    let currencies: [Currency]?
    let languages: [Language]?
}
