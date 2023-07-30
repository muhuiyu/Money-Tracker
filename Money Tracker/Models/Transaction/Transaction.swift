//
//  Transaction.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import UIKit

struct Transaction: TransactionSettings, Identifiable {
    var id: TransactionID
    var userID: UserID
    var currencyCode: CurrencyCode
    var year: Int
    var month: Int
    var day: Int
    var merchantID: MerchantID
    var amount: Double
    let type: TransactionType
    var note: String = ""
    var categoryID: CategoryID
    var tag: TransactionTag
    var recurringID: RecurringTransactionID = UUID()
    
    // current account
    var sourceAccountID: AccountID
    // for transfer and saving only
    var targetAccountID: AccountID
    
    enum EditableField: String {
        case userID
        case currencyCode
        case year
        case month
        case day
        case merchantID
        case amount
        case paymentBy
        case categoryID
        case note
        case tag
        
        static var stringFields: [EditableField] {
            return [.userID, .currencyCode, .merchantID, .amount, .paymentBy, .categoryID, .note, .tag]
        }
    }
}
extension Transaction {
    init() {
        id = UUID()
        // TODO: - Connect to real userID (Firebase), set default merchantID & groceriesID
        userID = CacheManager.shared.userID
        currencyCode = CacheManager.shared.preferredCurrencyCode
        amount = 0
        year = YearMonthDay.today.year
        month = YearMonthDay.today.month
        day = YearMonthDay.today.day
        merchantID = Merchant.fairPriceID
        type = .expense
        note = ""
        categoryID = Category.groceries.id     // default
        tag = .dailyLiving
        recurringID = UUID()
        sourceAccountID = CacheManager.shared.mainAccountID
        targetAccountID = UUID()
    }
    init(from recurringTransaction: RecurringTransaction) {
        id = UUID()
        userID = recurringTransaction.userID
        currencyCode = recurringTransaction.transactionSettings.currencyCode
        amount = recurringTransaction.transactionSettings.amount
        year = recurringTransaction.nextTransactionDate.year
        month = recurringTransaction.nextTransactionDate.month
        day = recurringTransaction.nextTransactionDate.dayOfMonth
        merchantID = recurringTransaction.transactionSettings.merchantID
        type = recurringTransaction.transactionSettings.type
        note = recurringTransaction.transactionSettings.note
        categoryID = recurringTransaction.transactionSettings.categoryID
        tag = recurringTransaction.transactionSettings.tag
        recurringID = recurringTransaction.id
        sourceAccountID = CacheManager.shared.mainAccountID
        targetAccountID = UUID()
    }
    static var defaultTransportTransaction: Transaction {
        return Transaction(id: UUID(),
                           userID: CacheManager.shared.userID,
                           currencyCode: CacheManager.shared.preferredCurrencyCode,
                           year: YearMonthDay.today.year,
                           month: YearMonthDay.today.month,
                           day: YearMonthDay.today.day,
                           merchantID: Merchant.smrtID,
                           amount: 0,
                           type: .expense,
                           note: "",
                           categoryID: Category.mrtBus.id,
                           tag: .dailyLiving,
                           recurringID: UUID(),
                           sourceAccountID: CacheManager.shared.mainAccountID,
                           targetAccountID: UUID())
    }
    static var defaultGroceryTransaction: Transaction {
        return Transaction(id: UUID(),
                           userID: UUID(),
                           currencyCode: CacheManager.shared.preferredCurrencyCode,
                           year: YearMonthDay.today.year,
                           month: YearMonthDay.today.month,
                           day: YearMonthDay.today.day,
                           merchantID: Merchant.fairPriceID,
                           amount: 0,
                           type: .expense,
                           note: "",
                           categoryID: Category.groceries.id,
                           tag: .dailyLiving,
                           recurringID: UUID(),
                           sourceAccountID: CacheManager.shared.mainAccountID,
                           targetAccountID: UUID())
    }
}

// MARK: -
extension Transaction {
    var date: YearMonthDay {
        return YearMonthDay(year: year, month: month, day: day)
    }
    var monthYearString: String {
        return date.toString(in: DateFormat.MMM_yyyy)
    }
    var dateStringInLocalDateFormat: String {
        return date.toString(in: DateFormat.MMM_dd_yyyy)
    }
    var isPending: Bool {
        return date > YearMonthDay.today
    }
    var isRecurring: Bool {
//        return !recurringID.isEmpty
        return false
    }
}

// MARK: - Interface
extension Transaction {
    static func sum(of transactions: [Transaction]) -> Double {
        return transactions.reduce(0) { $0 + $1.signedAmount }
    }
}

// MARK: - Codable
extension Transaction: Codable {
    private struct TransactionData: Codable {
        var userID: UserID
        var currencyCode: CurrencyCode
        var year: Int
        var month: Int
        var day: Int
        var merchantID: MerchantID
        let amount: Double
        let type: TransactionType
        var categoryID: CategoryID
        var recurringID: RecurringTransactionID
        var note: String
        var tag: TransactionTag
        let sourceAccountID: AccountID
        let targetAccountID: AccountID
    }
}

// MARK: - Enums
enum TransactionAccount {

}
