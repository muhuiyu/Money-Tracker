//
//  TransactionType.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation

typealias TransactionTypeString = String

enum TransactionType: String, Codable, CaseIterable {
    case expense
    case income
    case saving
    case transfer
}
