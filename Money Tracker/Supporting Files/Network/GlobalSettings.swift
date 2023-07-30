//
//  GlobalSettings.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/6/22.
//

class GlobalSettings {
    static let shared = GlobalSettings()
    
    // Rates Exchange API key from https://ratesexchange.eu
    let ratesExchangeApiKey = "dfdeab31-e1c8-41d5-9fb8-cf9e952be94c"
}

struct RateConverterRoutes {
    private static let s = GlobalSettings.shared
    static let apiBaseUrl = "https://api.ratesexchange.eu/client"
    static let apiCheckOnLine = "\(apiBaseUrl)/checkapi"
    static let apiKeyParam = "?apiKey=\(s.ratesExchangeApiKey)"
    static let latestDetailedRatesUri = "\(apiBaseUrl)/latestdetails\(apiKeyParam)"
    static let currenciesUri = "\(apiBaseUrl)/currencies\(apiKeyParam)"
    static let convertRatesUri = "\(apiBaseUrl)/convertdetails\(apiKeyParam)"
    static let currencyHistoryRatesUri = "\(apiBaseUrl)/historydates\(apiKeyParam)"
    static let historyRatesForCurrency = "\(apiBaseUrl)/historydetails\(apiKeyParam)"
}
