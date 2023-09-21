//
//  ShortcutTransaction.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/2/23.
//

import UIKit

typealias ShortcutTransactionID = UUID

struct ShortcutTransaction: TransactionSettings, Identifiable, Codable {
    var id: ShortcutTransactionID
    var currencyCode: CurrencyCode
    var merchantID: MerchantID
    var amount: Double
    var type: TransactionType
    var note: String
    var categoryID: CategoryID
    var tag: TransactionTag
}

// MARK: - Persistable
extension ShortcutTransaction: Persistable {
    public init(managedObject: ShortcutTransactionObject) {
        id = managedObject.id
        currencyCode = managedObject.currencyCode
        merchantID = managedObject.merchantID
        amount = managedObject.amount
        type = TransactionType(rawValue: managedObject.type) ?? .expense
        note = managedObject.note
        categoryID = managedObject.categoryID
        tag = TransactionTag(rawValue: managedObject.tag) ?? .dailyLiving
    }
    
    public func managedObject() -> ShortcutTransactionObject {
        return ShortcutTransactionObject(id: id,
                                         currencyCode: currencyCode,
                                         merchantID: merchantID,
                                         amount: amount,
                                         type: type.rawValue,
                                         note: note,
                                         categoryID: categoryID,
                                         tag: tag.rawValue)
    }
}
