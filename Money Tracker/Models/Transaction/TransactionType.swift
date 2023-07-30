//
//  TransactionType.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
//

import Foundation

typealias TransactionTypeString = String

enum TransactionType: String, Codable, CaseIterable {
    case expense
    case income
    case saving
    case transfer
}
