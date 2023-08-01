//
//  Database+Transaction.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

// MARK: - Interface
extension Database {
    /// Returns all transactions
    func getAllTransactions() -> [Transaction] {
        let transactions = realm.objects(TransactionObject.self)
            .map { Transaction(managedObject: $0) }
        return Array(transactions)
    }
    
    /// Returns transactions in given year and month
    func getTransactions(year: Int, month: Int) -> [Transaction] {
        let transactions = realm.objects(TransactionObject.self)
            .filter { $0.date?.year == year && $0.date?.month == month }
            .map { Transaction(managedObject: $0) }
        return Array(transactions)
    }
    
    func getTransaction(for id: TransactionID) -> Transaction? {
        return realm.objects(TransactionObject.self)
            .first(where: { $0.id == id })
            .map { Transaction(managedObject: $0) }
    }
    
    /// Returns sum of monthly average expense
    func getMonthlyAverageExpense(of mainCategoryID: MainCategoryID?) -> Double {
        var transactions = getAllTransactions()
        if let mainCategoryID = mainCategoryID {
            let categoryIDs = Category.getAllCategoryIDs(under: mainCategoryID)
            transactions = transactions.filter { categoryIDs.contains($0.categoryID) }
        }
        let monthlyExpenses = TransactionGroup(grouping: transactions) { $0.monthYearString }
            .map { (_, transactions) in
            transactions.filter({ $0.type == .expense }).reduce(into: 0, { $0 += $1.amount })
        }
        return Double(monthlyExpenses.reduce(0, +)) / Double(monthlyExpenses.count)
    }
    
    func getMonthlyExpenseAmount(year: Int,
                                 month: Int,
                                 of categoryIDs: [CategoryID] = [],
                                 shouldIncludePending: Bool = false) -> Double {

        var transactions = getTransactions(year: year, month: month)
            .filter { $0.type == .expense }
        
        if !categoryIDs.isEmpty {
            transactions = transactions.filter { categoryIDs.contains($0.categoryID) }
        }
        
        if !shouldIncludePending {
            transactions = transactions.filter { !$0.isPending }
        }
        return transactions.reduce(into: 0, { $0 += $1.amount })
    }
    
    /// Returns transactions in the given month
    func getMonthlyTransactions(year: Int,
                                month: Int,
                                of mainCategoryID: MainCategoryID?,
                                calculateExpenseOnly: Bool = false,
                                shouldIncludePending: Bool = false) -> [Transaction] {

        var transactions = self.getAllTransactions()
            .filter { $0.date.year == year && $0.date.month == month }
        
        if !shouldIncludePending {
            transactions = transactions.filter { !$0.isPending }
        }
        if calculateExpenseOnly {
            transactions = transactions.filter { $0.type == .expense }
        }
        
        if let mainCategoryID = mainCategoryID {
            let categoryIDs = Category.getAllCategoryIDs(under: mainCategoryID)
            transactions = transactions.filter { categoryIDs.contains($0.categoryID) }
        }
        
        return transactions
    }
    
    func getTransactions(for searchQuery: String) -> [Transaction] {
        return []
//        var transactions = realm.objects(TransactionObject.self)
//            .filter { object in
//                object.note.contains(searchQuery.low)
//            }
    }
}

// MARK: - Update data
extension Database {
    /// Add new transaction
    func addData(of transaction: Transaction, completion: @escaping (VoidResult) -> Void) {
        do {
            try realm.write({
                let _ = realm.create(TransactionObject.self, value: transaction.managedObject())
            })
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
    func updateData(of transaction: Transaction, completion: @escaping (VoidResult) -> Void) {
        do {
            try realm.write({
                realm.add(transaction.managedObject(), update: .modified)
            })
            completion(.success)
        } catch {
            completion(.failure(error))
        }
    }
    func deleteData(of id: TransactionID, completion: @escaping (VoidResult) -> Void) {
//        transactionRef.document(id).delete { error in
//            if let error = error {
//                return completion(.failure(error))
//            }
//            return completion(.success)
//        }
    }
}

// MARK: - Fetch transactions
extension Database {
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
}


//class Database {
//    // TODO: - Remove this
//    static let shared = Database()
//
//    internal var cachedTransactions = [TransactionID: Transaction]()
//    internal var cachedRecurringTransactions = [RecurringTransactionID: RecurringTransaction]()
//    internal var cachedBudgets = [BudgetID: Budget]()
//    internal var currencyDictionary = [CurrencyCode: Currency]()
//
//    internal var merchantList = [MerchantID: Merchant]()
//    internal let transactionRef: CollectionReference = Firestore.firestore().collection(Collections.transactions)
//    internal let recurringTransactionRef: CollectionReference = Firestore.firestore().collection(Collections.recurringTransactions)
//    internal let budgetRef: CollectionReference = Firestore.firestore().collection(Collections.budgets)
//    internal let merchantRef: CollectionReference = Firestore.firestore().collection(Collections.merchants)
//    internal let notificationRef: CollectionReference = Firestore.firestore().collection(Collections.notifications)
//
//    struct Collections {
//        static let transactions = "transactions"
//        static let recurringTransactions = "recurringTransactions"
//        static let budgets = "budgets"
//        static let merchants = "merchants"
//        static let notifications = "notifications"
//    }
//
//    struct FieldNames {
//        static let year = "year"
//        static let month = "month"
//        static let day = "day"
//        static let userID = "userID"
//        static let categoryID = "categoryID"
//        static let amount = "amount"
//        static let value = "value"
//    }
//
//    enum FirebaseError: Error {
//        case snapshotMissing
//        case multipleDocumentUsingSameID
//        case dataKeyMissing
//        case entryInitFailure
//        case userMissing
//        case documentMissing
//        case invalidDocumentID
//        case invalidQuery
//        case setDataFailure
//    }
//
//}
//// MARK: - Setup
//extension Database {
//    func setup() async {
//        let result = await fetchMerchants()
//        switch result {
//        case .success:
//            return
//        case .failure(let error):
//            ErrorHandler.shared.handle(error)
//        }
//
//        updateCurrencyRate { result in
//            switch result {
//            case .success:
//                return
//            case .failure(let error):
//                ErrorHandler.shared.handle(error)
//            }
//        }
//
////        addDataToFirebase()
//    }
//    private func addDataToFirebase() {
//        print("going to add data")
//
////        for entry in transactionRawData {
////            addData(of: entry) { result in
////                switch result {
////                case .success:
////                    print("success")
////                case .failure(let error):
////                    ErrorHandler.shared.handle(error)
////                }
////            }
////        }
////        let recur = RecurringTransaction(id: "1bf12f94-8e95-4c98-a69b-68b809955b13",
////                                         userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
////                                         transactionSettings: RecurringTransaction.RecurringTransactionSettings(merchantID: "34b62b3b-83e5-4ba6-a495-9543609ce636",
////                                                                                                                currencyCode: "SGD",
////                                                                                                                amount: 2.6,
////                                                                                                                type: .expense,
////                                                                                                                paymentBy: .amazeCard,
////                                                                                                                note: "250 yen per month (550 yen for anime)",
////                                                                                                                categoryID: "12-02",
////                                                                                                                tag: .smallBill),
////                                         rule: RecurringRule(everyNMonths: 1, on: [1]),
////                                         isActive: true)
////        do {
////            _ = try recurringTransactionRef.document(recur.id).setData(from: recur, merge: true) { error in
////                if let error = error {
////                    print(error)
////                }
////            }
////        } catch {
////
////        }
//    }
//}
//
//// MARK: - Update
//extension Database {
//    func addData(of budget: Budget, completion: @escaping (VoidResult) -> Void) {
//        do {
//            let documentRef = try budgetRef.addDocument(from: budget, completion: { error in
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
//            return completion(.failure(FirebaseError.entryInitFailure))
//        }
//    }
//    func updateData(of budgets: [Budget]) {
//        // TODO: - update data
//    }
//}

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
