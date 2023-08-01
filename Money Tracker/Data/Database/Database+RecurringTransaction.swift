//
//  Database+RecurringTransaction.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

// MARK: - Interface
extension Database {
    /// Returns all recurring transactions
    func getAllRecurringTransactions() -> [RecurringTransaction] {
        let items = realm.objects(RecurringTransactionObject.self)
            .map { RecurringTransaction(managedObject: $0) }
        return Array(items)
    }
    func getRecurringTransaction(_ id: RecurringTransactionID) -> RecurringTransaction? {
        return realm.objects(RecurringTransactionObject.self)
            .first(where: { $0.id == id })
            .map { RecurringTransaction(managedObject: $0) }
    }
    func deleteData(_ id: RecurringTransactionID) {
        
    }
}
