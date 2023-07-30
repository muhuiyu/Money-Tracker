//
//  Database+Currency.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/6/22.
//

//extension Database {
//    internal func updateCurrencyRate(completion: @escaping(VoidResult) -> Void) {
//        CurrencyConverter.shared.getApiEcbConvertRates { result in
//            switch result {
//            case .failure(let error):
//                ErrorHandler.shared.handle(error)
//            case .success(let ratesDetailModel):
//                guard let ratesDetailModel = ratesDetailModel else { return }
//                ratesDetailModel.rates.forEach { code, value in
//                    self.currencyDictionary[code.uppercased()] = Currency(code: code.uppercased(), valueToOneEUR: value)
//                }
//            }
//        }
//    }
//    func getCurrency(of code: CurrencyCode) -> Currency? {
//        return currencyDictionary[code.lowercased()]
//    }
//}
