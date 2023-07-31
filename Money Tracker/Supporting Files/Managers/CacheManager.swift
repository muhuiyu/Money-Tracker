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
        return UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID()
    }
    var mainAccountID: UUID {
        return UUID(uuidString: "f7ace0b7-e908-47a8-856c-6f88d2d89e44") ?? UUID()
    }
}
