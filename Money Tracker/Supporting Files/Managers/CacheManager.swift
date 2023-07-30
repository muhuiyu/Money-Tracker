//
//  CacheManager.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import Foundation

class CacheManager {
    
    // MARK: - Variables
    private let defaults = UserDefaults.standard
    static let shared = CacheManager()
    
    private let preferredLanguageKey = "preferredLanguage"
    
    init() {
        
    }
}

extension CacheManager {
    var preferredLanguage: Language {
        get {
            if let value = defaults.string(forKey: preferredLanguageKey) {
                return Language(rawValue: value) ?? .en
            }
            return .en
        }
        set {
            defaults.set(newValue.rawValue, forKey: preferredLanguageKey)
        }
    }
    var preferredCurrencyCode: CurrencyCode {
        return Currency.Code.sgd.rawValueUppercased
    }
    var preferredTimeZone: TimeZone {
//        return TimeZone(abbreviation: "SGT") ?? TimeZone.current
        return .current
    }
    var preferredCalendar: Calendar {
        return .current
    }
    var preferredLocale: Locale {
        return .current
//        return Locale(identifier: "ja_JP")
//        return Locale(identifier: "en_US")
    }
}

extension CacheManager {
    // TODO: - Reconnect to FirePrice
    var userID: UUID {
//        return "1dUSs99CSRXqsTEiSzJ9VWpBc7p2"
        return UUID(uuidString: "fcc57b74-1e96-4cae-82b0-ee237e261e9a") ?? UUID()
    }
    var mainAccountID: UUID {
//        return "wMHO0Dkyr0BJiVP8Mb6C"
        return UUID(uuidString: "fcc57b74-1e96-4cae-82b0-ee237e261e9a") ?? UUID()
    }
}
