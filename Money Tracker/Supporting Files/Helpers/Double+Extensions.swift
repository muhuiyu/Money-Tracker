//
//  Double+Extensions.swift
//  Fastiee
//
//  Created by Mu Yu on 6/27/22.
//

import Foundation

extension Double {
    func roundOff(to numberOfDecimalPlaces: Double) -> Double {
        let base = pow(10, numberOfDecimalPlaces)
        return (self * base).rounded() / base
    }
    mutating func roundedOff(to numberOfDecimalPlaces: Double) {
        self = self.roundOff(to: numberOfDecimalPlaces)
    }
    func roundedToTwoDigits() -> Double {
        return self.roundOff(to: 2)
    }
    func toCurrencyString(for code: CurrencyCode = CacheManager.shared.preferredCurrencyCode,
                          shouldRoundOffToInt: Bool = false) -> String {
        guard let symbol = code.getCurrencySymbol() else { return "" }
        var stringPrefix: String
        var amount: Double
        if self < 0 {
            stringPrefix = "-\(symbol)"
            amount = -self
        } else {
            stringPrefix = "\(symbol)"
            amount = self
        }
        return shouldRoundOffToInt ? stringPrefix + String(Int(amount)) : stringPrefix + String(amount.roundedToTwoDigits())
    }
    func toStringTwoDigits() -> String {
        return self.formatted(.number)
    }
}


