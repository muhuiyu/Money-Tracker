//
//  Currency.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/6/22.
//

import Foundation

typealias CurrencyCode = String
extension CurrencyCode {
    func getCurrencySymbol() -> String? {
        // Special case for SGD
        if self.lowercased() == "sgd" {
            return "S$"
        }
        let locale = NSLocale(localeIdentifier: self)
        return locale.displayName(forKey: .currencySymbol, value: self)
    }
}


struct Currency: Codable {
    let code: CurrencyCode
    let valueToOneEUR: Double
}

extension Currency {
    var symbol: String? { self.code.getCurrencySymbol() }
    func getValue(toOne targetCurrency: Currency) -> Double {
        return targetCurrency.valueToOneEUR / self.valueToOneEUR
    }
    func getValue(of amount: Double, to targetCurrency: Currency) -> Double {
        return amount * self.getValue(toOne: targetCurrency)
    }
    func getFxRateString(to currency: Currency) -> String {
        let value = getValue(toOne: currency)
        return "1 \(self.code) = \(value) \(currency.code)"
    }
//    static func convertValue(from baseCurrencyCode: CurrencyCode,
//                             _ baseCurrencyAmount: Double,
//                             to targetCurrencyCode: CurrencyCode) -> Double? {
//        guard
//            let baseCurrency = Currency.getCurrency(of: baseCurrencyCode),
//            let targetCurrency = Currency.getCurrency(of: targetCurrencyCode) else {
//            return nil
//        }
//        return baseCurrency.getValue(of: baseCurrencyAmount, to: targetCurrency)
//    }
//    static func getFxRateString(from baseCurrencyCode: CurrencyCode,
//                                to targetCurrencyCode: CurrencyCode) -> String? {
//        guard
//            let baseCurrency = Currency.getCurrency(of: baseCurrencyCode),
//            let targetCurrency = Currency.getCurrency(of: targetCurrencyCode) else {
//            return nil
//        }
//        return baseCurrency.getFxRateString(to: targetCurrency)
//    }
}

extension Currency {
    enum Code: CurrencyCode {
        case eur
        case usd
        case sgd
        case myr
        case ntd
        case jpy
        case bgn
        case czk
        case dkk
        case gbp
        case huf
        case pln
        case ron
        case sek
        case chf
        case isk
        case nok
        case hrk
        case aud
        case brl
        case cad
        case cny
        case hkd
        case idr
        case ils
        case inr
        case krw
        case mxn
        case nzd
        case php
        case thb
        case zar
        
        var rawValueUppercased: String { self.rawValue.uppercased() }
    }
//    static func getCurrency(of code: CurrencyCode) -> Currency? {
//        return Database.shared.getCurrency(of: code)
//    }
}
