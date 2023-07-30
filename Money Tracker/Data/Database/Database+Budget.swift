//
//  Database+Budget.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/2/22.
//

import UIKit

// MARK: - Fetch budgets
//extension Database {
//    func getBudget(_ id: BudgetID) -> Budget? {
//        return cachedBudgets[id]
//    }
//    /// Returns budgets
//    func getBudgetList(shouldPull: Bool = false,
//                       completion: @escaping(Result<BudgetList, Error>) -> Void) {
//        if shouldPull {
//            fetchBudgets { result in
//                switch result {
//                case .success:
//                    return completion(.success(Array(self.cachedBudgets.values)))
//                case .failure(let error):
//                    return completion(.failure(error))
//                }
//            }
//        } else {
//            return completion(.success(Array(cachedBudgets.values)))
//        }
//    }
//}
//// MARK: - Private functions
//extension Database {
//    /// Fetch recurring transactions
//    private func fetchBudgets(completion: @escaping(VoidResult) -> Void) {
//
//        budgetRef.getDocuments { snapshot, error in
//            if let error = error {
//                return completion(.failure(error))
//            }
//            guard let snapshot = snapshot else {
//                return completion(.failure(FirebaseError.snapshotMissing))
//            }
//            let entries: [Budget] = snapshot
//                .documentChanges
//                .filter { $0.type == .added }
//                .compactMap { try? Budget(snapshot: $0.document) }
//
//            self.updateCachedBudgets(entries)
//            return completion(.success)
//        }
//    }
//    private func updateCachedBudgets(_ newData: [Budget]) {
//        cachedBudgets.removeAll()
//        for entry in newData {
//            cachedBudgets[entry.id] = entry
//        }
//    }
//}
