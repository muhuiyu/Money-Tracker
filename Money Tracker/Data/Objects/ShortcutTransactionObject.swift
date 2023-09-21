//
//  ShortcutTransactionObject.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/2/23.
//

import Foundation
import RealmSwift

final class ShortcutTransactionObject: Object {
    override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var currencyCode: CurrencyCode = "sgd"
    @objc dynamic var merchantID: MerchantID = UUID()
    @objc dynamic var amount: Double = 0
    @objc dynamic var type: TransactionTypeString = TransactionType.expense.rawValue
    @objc dynamic var note: String = ""
    @objc dynamic var categoryID: CategoryID = ""
    @objc dynamic var tag: TransactionTagString = TransactionTag.dailyLiving.rawValue
    
    convenience init(id: UUID, currencyCode: CurrencyCode, merchantID: MerchantID, amount: Double, type: TransactionTypeString, note: String, categoryID: CategoryID, tag: TransactionTagString) {
        self.init()
        self.id = id
        self.currencyCode = currencyCode
        self.merchantID = merchantID
        self.amount = amount
        self.type = type
        self.note = note
        self.categoryID = categoryID
        self.tag = tag
    }
}

