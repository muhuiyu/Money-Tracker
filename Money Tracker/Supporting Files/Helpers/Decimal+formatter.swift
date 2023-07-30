//
//  Decimal+formatter.swift
//  Decimal+formatter
//
//  Created by Mu Yu on 10/9/21.
//

import UIKit

extension Decimal {
    func toCurrencyString(for code: String = CacheManager.shared.preferredCurrencyCode) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currencyAccounting
        formatter.currencyCode = code
        return formatter.string(from: self as NSDecimalNumber) ?? ""
    }
}
