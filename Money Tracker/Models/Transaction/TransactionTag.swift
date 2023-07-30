//
//  TransactionTag.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
//

import Foundation

typealias TransactionTagString = String

enum TransactionTag: String, Codable, CaseIterable {
    case smallBill
    case bigBill
    case dailyLiving
    case debt
    case income
}
