//
//  TransactionType.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

typealias TransactionTypeString = String

enum TransactionType: String, Codable, CaseIterable {
    case income
    case expense
    case transfer
    
    var name: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        case .transfer:
            return "Transfer"
        }
    }
    
    var index: Int {
        switch self {
        case .income:
            return 0
        case .expense:
            return 1
        case .transfer:
            return 2
        }
    }
    
    var color: UIColor {
        switch self {
        case .income:
            return .systemGreen
        case .expense:
            return .systemRed
        case .transfer:
            return .systemGray
        }
    }
}
