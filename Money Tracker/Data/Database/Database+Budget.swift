//
//  Database+Budget.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import UIKit

// MARK: - Fetch budgets
extension Database {
    /// Returns all budgets
    func getAllBudgets() -> [Budget] {
        let budgets = realm.objects(BudgetObject.self)
            .map { Budget(managedObject: $0) }
        return Array(budgets)
    }
    
    /// Returns budget of given id
    func getBudget(_ id: BudgetID) -> Budget? {
        return realm.objects(BudgetObject.self)
            .first(where: { $0.id == id })
            .map { Budget(managedObject: $0) }
    }
    
    func updateData(of budgets: [Budget], completion: @escaping (VoidResult) -> Void) {
        do {
            try realm.write({
                budgets.forEach { budget in
                    realm.add(budget.managedObject(), update: .modified)
                }
            })
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
}
