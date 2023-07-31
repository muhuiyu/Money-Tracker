//
//  TransactionTag.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation

typealias TransactionTagString = String

enum TransactionTag: String, Codable, CaseIterable {
    case smallBill
    case bigBill
    case dailyLiving
    case debt
    case income
    
    var name: String {
        switch self {
        case .smallBill:
            return "small bills"
        case .bigBill:
            return "big bills"
        case .dailyLiving:
            return "daily living"
        case .debt:
            return "debt"
        case .income:
            return "income"
        }
    }
}
