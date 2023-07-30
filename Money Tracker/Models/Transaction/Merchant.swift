//
//  Merchant.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/2/22.
//

import UIKit

typealias MerchantID = String

struct Merchant: Identifiable, Codable {
    let id: MerchantID
    let value: String
}
extension Merchant {
    private struct MerchantData: Codable {
        var value: String
        
        private enum CodingKeys: String, CodingKey {
            case value
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            value = try container.decode(String.self, forKey: .value)
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(value, forKey: .value)
        }
    }
}

extension Merchant {
    static func getAllMerchantIDs() -> [MerchantID] {
//        return Database.shared.getAllMerchants().map { $0.id }
        return []
    }
    static func getMerchantName(of id: MerchantID) -> String? {
//        return Database.shared.getMerchantValue(of: id)
        return nil
    }
}

extension Merchant {
    static var fairPriceID: String {
        return "ukGw5BPcc8skSsY2hh6U"
    }
    static var smrtID: String {
        return "htuFDjA7PvqjVe88ymz6"
    }
}
