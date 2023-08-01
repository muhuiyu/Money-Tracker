//
//  RecurringTransactionObject.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation
import RealmSwift

final class RecurringTransactionObject: Object {
    override class func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var userID = UserID()
    @objc dynamic var rule: PersistedRecurringRule? = nil
    @objc dynamic var isActive: Bool = true
    @objc dynamic var merchantID: MerchantID = UUID()
    @objc dynamic var currencyCode: CurrencyCode = "sgd"
    @objc dynamic var amount: Double = 0
    @objc dynamic var type: TransactionTypeString = TransactionType.expense.rawValue
    @objc dynamic var note: String = ""
    @objc dynamic var categoryID: CategoryID = ""
    @objc dynamic var tag: TransactionTagString = TransactionTag.dailyLiving.rawValue
    
    convenience init(id: UUID, userID: UUID = UserID(), rule: PersistedRecurringRule?, isActive: Bool, merchantID: MerchantID, currencyCode: CurrencyCode, amount: Double, type: TransactionTypeString, note: String, categoryID: CategoryID, tag: TransactionTagString) {
        self.init()
        self.id = id
        self.userID = userID
        self.rule = rule
        self.isActive = isActive
        self.merchantID = merchantID
        self.currencyCode = currencyCode
        self.amount = amount
        self.type = type
        self.note = note
        self.categoryID = categoryID
        self.tag = tag
    }
}


final class PersistedRecurringRule: Object {
    @objc dynamic var ruleCase: String = ""
    let days: List<Int> = List<Int>()
    let yearMonthDay: List<YearMonthDayObject> = List<YearMonthDayObject>()
}



