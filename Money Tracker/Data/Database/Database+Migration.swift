//
//  Database+Migration.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation
import Realm
import RealmSwift

extension Database {
    internal func deleteAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    internal func addAllBudgets() {
        if let data = readBudgetsFromJSONFile() {
            print("budget generated", data.count)
            data.forEach { item in
                try? realm.write {
                    let _ = realm.create(BudgetObject.self, value: item.managedObject())
                }
            }
        }
    }
    
    internal func addAllTransactions() {
        if let data = readTransactionsFromJSONFile() {
            print("data generated", data.count)
            data.map { item in
                return Transaction(id: item.id, userID: item.userID, currencyCode: item.currencyCode, date: YearMonthDay(year: item.year, month: item.month, day: item.day) , merchantID: item.merchantID, amount: item.amount, type: item.type, categoryID: item.categoryID, tag: item.tag, recurringID: item.recurringID, sourceAccountID: item.sourceAccountID, targetAccountID: item.targetAccountID)
            }
            .forEach { item in
                try? realm.write {
                    let transactionObject = item.managedObject()
                    let _ = realm.create(TransactionObject.self, value: transactionObject)
                }
            }
        }
    }
    
    internal func addAllMerchants() {
        if let data = readMerchantsFromJSONFile() {
            data.forEach { item in
                try? realm.write({
                    let _ = realm.create(MerchantObject.self, value: item.managedObject())
                })
            }
        }
    }
}

// MARK: - Convert from JSON
extension Database {
    private func readTransactionsFromJSONFile() -> [TransactionRawData]? {
        if let fileURL = Bundle.main.url(forResource: "transactions_output", withExtension: "json") {
            do {
                let jsondata = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                print(jsondata)
                let transactions = try decoder.decode([TransactionRawData].self, from: jsondata)
                return transactions
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
        return nil
    }

    private func readMerchantsFromJSONFile() -> [Merchant]? {
        if let fileURL = Bundle.main.url(forResource: "merchants_output", withExtension: "json") {
            do {
                let jsondata = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let transactions = try decoder.decode([Merchant].self, from: jsondata)
                return transactions
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
        return nil
    }
    
    private func readBudgetsFromJSONFile() -> [Budget]? {
        if let fileURL = Bundle.main.url(forResource: "budgets_output", withExtension: "json") {
            do {
                let jsondata = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let transactions = try decoder.decode([Budget].self, from: jsondata)
                return transactions
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
        return nil
    }
}


struct TransactionRawData: Identifiable, Codable {
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
    
    // Recurring payment
    var recurringID: RecurringTransactionID?
    
    // current account
    var sourceAccountID: AccountID
    // for transfer and saving only
    var targetAccountID: AccountID?
    
    enum CodingKeys: CodingKey {
        case id
        case userID
        case currencyCode
        case year
        case month
        case day
        case merchantID
        case amount
        case type
        case note
        case categoryID
        case tag
        case recurringID
        case sourceAccountID
        case targetAccountID
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(TransactionID.self, forKey: .id)
        self.userID = try container.decode(UserID.self, forKey: .userID)
        self.currencyCode = try container.decode(CurrencyCode.self, forKey: .currencyCode)
        self.year = try container.decode(Int.self, forKey: .year)
        self.month = try container.decode(Int.self, forKey: .month)
        self.day = try container.decode(Int.self, forKey: .day)
        if let merchantIDString = try? container.decode(String.self, forKey: .merchantID) {
            print(merchantIDString)
            self.merchantID = try container.decode(MerchantID.self, forKey: .merchantID)
        } else {
            self.merchantID = UUID()
        }
        
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.type = try container.decode(TransactionType.self, forKey: .type)
        self.note = try container.decode(String.self, forKey: .note)
        self.categoryID = try container.decode(CategoryID.self, forKey: .categoryID)
        self.tag = try container.decode(TransactionTag.self, forKey: .tag)
        if let recurringIDString = try? container.decodeIfPresent(String.self, forKey: .recurringID), !recurringIDString.isEmpty {
            self.recurringID = UUID(uuidString: recurringIDString)
        }
        if let sourceAccountIDString = try? container.decodeIfPresent(String.self, forKey: .sourceAccountID), !sourceAccountIDString.isEmpty {
            self.sourceAccountID = UUID(uuidString: sourceAccountIDString) ?? CacheManager.shared.mainAccountID
        } else {
            self.sourceAccountID = CacheManager.shared.mainAccountID
        }
        if let targetAccountIDString = try? container.decodeIfPresent(String.self, forKey: .recurringID), !targetAccountIDString.isEmpty {
            self.targetAccountID = UUID(uuidString: targetAccountIDString)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.userID, forKey: .userID)
        try container.encode(self.currencyCode, forKey: .currencyCode)
        try container.encode(self.year, forKey: .year)
        try container.encode(self.month, forKey: .month)
        try container.encode(self.day, forKey: .day)
        try container.encode(self.merchantID, forKey: .merchantID)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.note, forKey: .note)
        try container.encode(self.categoryID, forKey: .categoryID)
        try container.encode(self.tag, forKey: .tag)
        try container.encodeIfPresent(self.recurringID, forKey: .recurringID)
        try container.encode(self.sourceAccountID, forKey: .sourceAccountID)
        try container.encodeIfPresent(self.targetAccountID, forKey: .targetAccountID)
    }
}
