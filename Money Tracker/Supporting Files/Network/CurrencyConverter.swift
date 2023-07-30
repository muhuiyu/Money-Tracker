//
//  CurrencyConverter.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/6/22.
//

import Foundation

struct CurrencyConverter {
    static let shared = CurrencyConverter()
}

extension CurrencyConverter {
    func getApiEcbConvertRates(from baseCurrency: CurrencyCode = "EUR",
                               completion: @escaping (Result<RatesDetailModel?, Error>) -> Void) {
        
        let callUri = "https://api.ratesexchange.eu/client/latest\(RateConverterRoutes.apiKeyParam)"
        ApiService.shared.fetchApiData(urlString: callUri) { (rates: RatesDetailModel?, error) in
            if let error = error {
                return completion(.failure(error))
            }
            guard let rates = rates, !rates.rates.isEmpty else {
                return completion(.failure(CurrencyConverterError.emptyRates))
            }
            return completion(.success(rates))
        }
    }
}

// MARK: - Models
struct RatesDetailModel: Decodable {
    let base: String
    let date: String
    let rates: [String:Double]
}

struct RateDetail: Decodable {
    let symbol: String
    let currency: String
    let value: Double
}

struct ConversionData {
    var fromCurrency: String?
    var toCurrency: String?
    var convertDate: String?
    var fromAmount: Double?
}

struct ConversionDetails {
    var source: String?
    var amount: String?
}

struct ConversionCurrencyData {
    var currency: Currency?
    var details: ConversionDetails?
}

enum CurrencyConverterError: Error {
    case emptyRates
}
