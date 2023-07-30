//
//  Database+Transaction.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/2/22.
//

import UIKit

// MARK: - Interface
//extension Database {
//    func getTransaction(_ id: TransactionID) -> Transaction? {
//        return cachedTransactions[id]
//    }
//    func getMonthlyAverageExpense(of categoryIDs: [CategoryID] = []) -> Double {
//        guard !cachedTransactions.isEmpty else { return 0 }
//        var transactions = cachedTransactions.map { $0.value }
//        if !categoryIDs.isEmpty {
//            transactions = transactions.filter { categoryIDs.contains($0.categoryID) }
//        }
//        let monthlyExpenses = TransactionGroup(grouping: transactions) { $0.monthYearString }
//            .map { (_, transactions) in
//            transactions.filter({ $0.type == .expense }).reduce(into: 0, { $0 += $1.amount })
//        }
//        return Double(monthlyExpenses.reduce(0, +)) / Double(monthlyExpenses.count)
//    }
//    func getMonthlyExpenseAmount(in month: Int,
//                                 of year: Int,
//                                 of categoryIDs: [CategoryID] = [],
//                                 shouldIncludePending: Bool = false) -> Double {
//
//        var transactions = self.cachedTransactions
//            .filter { $0.value.year == year && $0.value.month == month && $0.value.type == .expense }
//            .map { $0.value }
//        if !categoryIDs.isEmpty {
//            transactions = transactions.filter { categoryIDs.contains($0.categoryID) }
//        }
//        if !shouldIncludePending {
//            transactions = transactions.filter { !$0.isPending }
//        }
//        return transactions.reduce(into: 0, { $0 += $1.amount })
//    }
//    /// Returns transactions in the given month
//    func getMonthlyTransactions(year: Int,
//                                month: Int,
//                                of categoryIDs: [CategoryID] = [],
//                                calculateExpenseOnly: Bool = false,
//                                shouldIncludePending: Bool = false,
//                                shouldPull: Bool,
//                                completion: @escaping(Result<[Transaction], Error>) -> Void) {
//
//        func filterTransactions() -> TransactionList {
//            var transactions = self.cachedTransactions
//                .filter { $0.value.year == year && $0.value.month == month }
//                .map { $0.value }
//
//            if !shouldIncludePending {
//                transactions = transactions.filter { !$0.isPending }
//            }
//            if calculateExpenseOnly {
//                transactions = transactions.filter { $0.type == .expense }
//            }
//            if !categoryIDs.isEmpty {
//                transactions = transactions.filter { categoryIDs.contains($0.categoryID) }
//            }
//            return transactions
//        }
//
//        if shouldPull {
//            fetchMonthlyTransactions(year: year, month: month, of: categoryIDs) { result in
//                switch result {
//                case .success:
//                    let transactions = filterTransactions()
//                    return completion(.success(transactions))
//                case .failure(let error):
//                    return completion(.failure(error))
//                }
//            }
//        } else {
//            let transactions = filterTransactions()
//            return completion(.success(transactions))
//        }
//    }
//    /// Returns transactions in the given day
//    func getDailyTransactions(on date: Date,
//                              of categoryIDs: [CategoryID] = [],
//                              shouldPull: Bool,
//                              completion: @escaping(Result<[Transaction], Error>) -> Void) {
//
//        func filterTransactions() -> TransactionList {
//            var transactions = self.cachedTransactions
//                .filter { $0.value.year == date.year && $0.value.month == date.month && $0.value.day == date.dayOfMonth }
//                .map { $0.value }
//            if !categoryIDs.isEmpty {
//                transactions = transactions.filter { categoryIDs.contains($0.categoryID) }
//            }
//            return transactions
//        }
//
//        if shouldPull {
//            fetchDailyTransactions(on: date, of: categoryIDs) { result in
//                switch result {
//                case .success:
//                    let transactions = filterTransactions()
//                    return completion(.success(transactions))
//                case .failure(let error):
//                    return completion(.failure(error))
//                }
//            }
//        } else {
//            let transactions = filterTransactions()
//            return completion(.success(transactions))
//        }
//    }
//    /// Returns transactions in the past given number of days
//    func getTransactionsInThePast(_ numberOfDays: Int,
//                                  shouldIncludePending: Bool = false,
//                                  calculateExpenseOnly: Bool = false,
//                                  shouldPull: Bool,
//                                  completion: @escaping(Result<[Transaction], Error>) -> Void) {
//
//        func filterTransactions() -> TransactionList {
//            let endEate = Date.today
//            let startDate = endEate.day(before: numberOfDays)
//            var transactions = self.cachedTransactions
//                .map { $0.value }
//                .filter { transaction in
//                    guard let date = YearMonthDay(year: transaction.year,
//                                                month: transaction.month,
//                                                day: transaction.day).toDate else { return false }
//                    return date >= startDate && date <= endEate
//                }
//            if !shouldIncludePending {
//                transactions = transactions.filter { !$0.isPending }
//            }
//            if calculateExpenseOnly {
//                transactions = transactions.filter { $0.type == .expense }
//            }
//            return transactions
//        }
//
//        if shouldPull {
//            fetchTransactionsInThePast(numberOfDays) { result in
//                switch result {
//                case .success:
//                    let transactions = filterTransactions()
//                    return completion(.success(transactions))
//                case .failure(let error):
//                    return completion(.failure(error))
//                }
//            }
//        } else {
//            let transactions = filterTransactions()
//            return completion(.success(transactions))
//        }
//    }
//    /// Returns recent transactions up to given number of transactions
//    func getRecentTransactionsUpTo(_ numberOfTransactions: Int,
//                                   shouldIncludePending: Bool = false,
//                                   calculateExpenseOnly: Bool = false,
//                                   shouldPull: Bool,
//                                   completion: @escaping(Result<[Transaction], Error>) -> Void) {
//
//        func filterTransactions() -> TransactionList {
//            var transactions = self.cachedTransactions
//                .map { $0.value }
//                .sorted(by: {
//                    YearMonthDay(year: $0.year, month: $0.month, day: $0.day) > YearMonthDay(year: $1.year, month: $1.month, day: $1.day)
//                })
//            if !shouldIncludePending {
//                transactions = transactions.filter { !$0.isPending }
//            }
//            if calculateExpenseOnly {
//                transactions = transactions.filter { $0.type == .expense }
//            }
//            return transactions.count < numberOfTransactions ? transactions : Array(transactions[0..<numberOfTransactions])
//        }
//
//        if shouldPull {
//            fetchAllTransactions { result in
//                switch result {
//                case .success:
//                    let transactions = filterTransactions()
//                    return completion(.success(transactions))
//                case .failure(let error):
//                    return completion(.failure(error))
//                }
//            }
//        } else {
//            let transactions = filterTransactions()
//            return completion(.success(transactions))
//        }
//    }
//    /// Returns scheduled transactions (pending)
//    func getScheduledTransactions(shouldPull: Bool,
//                                  calculateExpenseOnly: Bool = false,
//                                  completion: @escaping(Result<TransactionList, Error>) -> Void) {
//
//        func filterTransactions() -> TransactionList {
//            var transactions = self.cachedTransactions
//                .filter { $0.value.isPending }
//                .map { $0.value }
//            if calculateExpenseOnly {
//                transactions = transactions.filter { $0.type == .expense }
//            }
//            return transactions
//        }
//
//        if shouldPull {
//            fetchAllTransactions { result in
//                switch result {
//                case .success:
//                    let transactions = filterTransactions()
//                    return completion(.success(transactions))
//                case .failure(let error):
//                    return completion(.failure(error))
//                }
//            }
//        } else {
//            let transactions = filterTransactions()
//            return completion(.success(transactions))
//        }
//    }
//    /// Returns scheduled transactions (pending)
////    func getScheduledTransactions(calculateExpenseOnly: Bool = false) -> TransactionList {
////        var transactions = self.cachedTransactions
////            .filter { $0.value.isPending }
////            .map { $0.value }
////        if calculateExpenseOnly {
////            transactions = transactions.filter { $0.type == .expense }
////        }
////        return transactions
////    }
//    /// Returns recurring transaction from local
//    func getRecurringTransaction(_ id: TransactionID) -> RecurringTransaction? {
//        return cachedRecurringTransactions[id]
//    }
//    /// Returns recurring transactions
//    func getRecurringTransactions(shouldPull: Bool,
//                                  completion: @escaping(Result<[RecurringTransaction], Error>) -> Void) {
//
//        func filterRecurringTransactions() -> [RecurringTransaction] {
//            return self.cachedRecurringTransactions.map { $0.value }
//        }
//
//        if shouldPull {
//            fetchRecurringTransactions { result in
//                switch result {
//                case .success:
//                    let entries = filterRecurringTransactions()
//                    return completion(.success(entries))
//                case .failure(let error):
//                    return completion(.failure(error))
//                }
//            }
//        } else {
//            let entries = filterRecurringTransactions()
//            return completion(.success(entries))
//        }
//    }
//    /// Returns monthly income and expense summary in the given month
//    func calculateMonthlyBalance(year: Int, month: Int) -> Double {
//        guard !cachedTransactions.isEmpty else { return 0 }
//        return calculateMonthlyExpense(year: year, month: month) + calculateMonthlyIncome(year: year, month: month)
//    }
//    /// Returns monthly expense summary in the given month
//    func calculateMonthlyExpense(year: Int, month: Int) -> Double {
//        guard !cachedTransactions.isEmpty else { return 0 }
//        let sum = cachedTransactions
//            .filter { $0.value.year == year && $0.value.month == month && !$0.value.isPending && $0.value.type == .expense }
//            .reduce(into: 0) { $0 += $1.value.signedAmount }
//        return sum
//    }
//    /// Returns monthly income summary in the given month
//    func calculateMonthlyIncome(year: Int, month: Int) -> Double {
//        guard !cachedTransactions.isEmpty else { return 0 }
//        let sum = cachedTransactions
//            .filter { $0.value.year == year && $0.value.month == month && !$0.value.isPending && $0.value.type == .income }
//            .reduce(into: 0) { $0 += $1.value.signedAmount }
//        return sum
//    }
//}
//
//// MARK: - Update data
//extension Database {
//    /// Add new transaction
//    func addData(of transaction: Transaction, completion: @escaping (VoidResult) -> Void) {
//        do {
//            let documentRef = try transactionRef.addDocument(from: transaction, completion: { error in
//                if let error = error {
//                    return completion(.failure(error))
//                }
//            })
//            documentRef.setData(["id": documentRef.documentID], merge: true) { error in
//                if let error = error {
//                    return completion(.failure(error))
//                }
//                return completion(.success)
//            }
//        } catch {
//            return completion(.failure(FirebaseError.setDataFailure))
//        }
//    }
//    func updateData(of transaction: Transaction, merge: Bool = true, completion: @escaping (VoidResult) -> Void) {
//        self.cachedTransactions[transaction.id] = transaction
//        do {
//            _ = try transactionRef.document(transaction.id).setData(from: transaction, merge: merge) { error in
//                if let error = error {
//                    return completion(.failure(error))
//                }
//                return completion(.success)
//            }
//        } catch {
//            return completion(.failure(FirebaseError.setDataFailure))
//        }
//    }
//    func updateData(of transaction: Transaction, _ data: [String: Any], merge: Bool = true, completion: @escaping (VoidResult) -> Void) {
//        self.cachedTransactions[transaction.id] = transaction
//        do {
//            _ = try transactionRef.document(transaction.id).setData(data, merge: merge) { error in
//                if let error = error {
//                    return completion(.failure(error))
//                }
//                return completion(.success)
//            }
//        } catch {
//            return completion(.failure(FirebaseError.setDataFailure))
//        }
//    }
//    func deleteData(of id: TransactionID, completion: @escaping (VoidResult) -> Void) {
//        transactionRef.document(id).delete { error in
//            if let error = error {
//                return completion(.failure(error))
//            }
//            return completion(.success)
//        }
//    }
//}
//
//// MARK: - Fetch transactions
//extension Database {
//    /// Fetch transactions in the given month and update to cachedTransactions
//    private func fetchMonthlyTransactions(year: Int,
//                                          month: Int,
//                                          of categoryIDs: [CategoryID] = [],
//                                          completion: @escaping(VoidResult) -> Void) {
//
//        guard Date.isValid(month: month) else { return completion(.failure(FirebaseError.invalidQuery)) }
//        var ref = transactionRef.whereField(FieldNames.month, isEqualTo: month)
//        if !categoryIDs.isEmpty {
//            ref = ref.whereField(FieldNames.categoryID, in: categoryIDs)
//        }
//        ref.getDocuments { snapshot, error in
//            if let error = error {
//                return completion(.failure(error))
//            }
//            guard let snapshot = snapshot else {
//                return completion(.failure(FirebaseError.snapshotMissing))
//            }
//            let entries: [Transaction] = snapshot
//                .documentChanges
//                .filter { $0.type == .added }
//                .compactMap { try? Transaction(snapshot: $0.document) }
//
//            self.updateCachedTransactions(entries)
//            return completion(.success)
//        }
//    }
//    /// Fetch transactions in the given day and update to cachedTransactions
//    private func fetchDailyTransactions(on date: Date,
//                                        of categoryIDs: [CategoryID] = [],
//                                        completion: @escaping(VoidResult) -> Void) {
//        guard Date.isValid(year: date.year, month: date.month, day: date.dayOfMonth) else {
//            return completion(.failure(FirebaseError.invalidQuery))
//        }
//        var ref = transactionRef
//            .whereField(FieldNames.year, isEqualTo: date.year)
//            .whereField(FieldNames.month, isEqualTo: date.month)
//            .whereField(FieldNames.day, isEqualTo: date.dayOfMonth)
//        if !categoryIDs.isEmpty {
//            ref = ref.whereField(FieldNames.categoryID, in: categoryIDs)
//        }
//        ref.getDocuments { snapshot, error in
//            if let error = error {
//                return completion(.failure(error))
//            }
//            guard let snapshot = snapshot else {
//                return completion(.failure(FirebaseError.snapshotMissing))
//            }
//            let entries: [Transaction] = snapshot
//                .documentChanges
//                .filter { $0.type == .added }
//                .compactMap { try? Transaction(snapshot: $0.document) }
//
//            self.updateCachedTransactions(entries)
//            return completion(.success)
//        }
//    }
//    /// Fetch transactions in the past given number of days and update to cachedTransactions
//    private func fetchTransactionsInThePast(_ numberOfDays: Int,
//                                            completion: @escaping(VoidResult) -> Void) {
//        let endDate = Date.today
//        let startDate = Date.today.day(before: numberOfDays)
//
//        let ref = transactionRef
//            .whereField(FieldNames.year, isGreaterThanOrEqualTo: startDate.year)
//            .whereField(FieldNames.year, isLessThanOrEqualTo: endDate.year)
//
//        ref.getDocuments { snapshot, error in
//            if let error = error {
//                return completion(.failure(error))
//            }
//            guard let snapshot = snapshot else {
//                return completion(.failure(FirebaseError.snapshotMissing))
//            }
//            let entries: [Transaction] = snapshot
//                .documentChanges
//                .filter { $0.type == .added }
//                .compactMap { try? Transaction(snapshot: $0.document) }
//                .filter { transaction in
//                    guard let date = YearMonthDay(year: transaction.year, month: transaction.month, day: transaction.day).toDate else { return false }
//                    return date >= startDate && date <= endDate
//                }
//
//            self.updateCachedTransactions(entries)
//            return completion(.success)
//        }
//    }
//    /// Fetch all transactions and update to cachedTransactions
//    private func fetchAllTransactions(completion: @escaping(VoidResult) -> Void) {
//
//        transactionRef.getDocuments { snapshot, error in
//            if let error = error {
//                return completion(.failure(error))
//            }
//            guard let snapshot = snapshot else {
//                return completion(.failure(FirebaseError.snapshotMissing))
//            }
//            let entries: [Transaction] = snapshot
//                .documentChanges
//                .filter { $0.type == .added }
//                .compactMap { try? Transaction(snapshot: $0.document) }
//
//            self.updateCachedTransactions(entries)
//            return completion(.success)
//        }
//    }
//    /// Fetch recurring transactions
//    private func fetchRecurringTransactions(completion: @escaping(VoidResult) -> Void) {
//
//        recurringTransactionRef.getDocuments { snapshot, error in
//            if let error = error {
//                return completion(.failure(error))
//            }
//            guard let snapshot = snapshot else {
//                return completion(.failure(FirebaseError.snapshotMissing))
//            }
//            let entries: [RecurringTransaction] = snapshot
//                .documentChanges
//                .filter { $0.type == .added }
//                .compactMap { try? RecurringTransaction(snapshot: $0.document) }
//
//            self.updateCachedRecurringTransactions(entries)
//            return completion(.success)
//        }
//    }
//}
//// MARK: - Private functions
//extension Database {
//    private func updateCachedTransactions(_ newData: [Transaction]) {
//        cachedTransactions.removeAll()
//        newData.forEach { cachedTransactions[$0.id] = $0 }
//    }
//    private func updateCachedRecurringTransactions(_ newData: [RecurringTransaction]) {
//        cachedRecurringTransactions.removeAll()
//        newData.forEach { cachedRecurringTransactions[$0.id] = $0 }
//    }
//}
