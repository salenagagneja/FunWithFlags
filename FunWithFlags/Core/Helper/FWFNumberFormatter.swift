//
//  FWFNumberFormatter.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation

final class FWFNumberFormatter {
    private init() {}
    static let shared = FWFNumberFormatter()
    private let formatter = NumberFormatter()
    
    func formatNumberForPopulation(number: Int?) -> String {
        guard let number = number else { return "0" }
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? "0"
    }
}
