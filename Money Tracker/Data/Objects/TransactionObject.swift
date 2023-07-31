//
//  TransactionObject.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import Foundation
import RealmSwift

final class TransactionObject: Object {
    override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var userID = UserID()
    @objc dynamic var currencyCode: CurrencyCode = "sgd"
    @objc dynamic var date: YearMonthDayObject?
    @objc dynamic var merchantID: MerchantID = UUID()
    @objc dynamic var amount: Double = 0
    @objc dynamic var type: TransactionTypeString = TransactionType.expense.rawValue
    @objc dynamic var note: String = ""
    @objc dynamic var categoryID: CategoryID = ""
    @objc dynamic var tag: TransactionTagString = TransactionTag.dailyLiving.rawValue
    @objc dynamic var recurringID: RecurringTransactionID? = nil
    @objc dynamic var sourceAccountID: AccountID = UUID()
    @objc dynamic var targetAccountID: AccountID? = nil
    
    convenience init(id: UUID, userID: UUID, currencyCode: CurrencyCode, date: YearMonthDayObject?, merchantID: MerchantID, amount: Double, type: TransactionTypeString, note: String, categoryID: CategoryID, tag: TransactionTagString, recurringID: RecurringTransactionID?, sourceAccountID: AccountID, targetAccountID: AccountID? = nil) {
        self.init()
        self.id = id
        self.userID = userID
        self.currencyCode = currencyCode
        self.date = date
        self.merchantID = merchantID
        self.amount = amount
        self.type = type
        self.note = note
        self.categoryID = categoryID
        self.tag = tag
        self.recurringID = recurringID
        self.sourceAccountID = sourceAccountID
        self.targetAccountID = targetAccountID
    }
}
