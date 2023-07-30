//
//  Database.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit

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
////        let recur = RecurringTransaction(id: "wojMIrnn7La0l9oQvZIR",
////                                         userID: "1dUSs99CSRXqsTEiSzJ9VWpBc7p2",
////                                         transactionSettings: RecurringTransaction.RecurringTransactionSettings(merchantID: "2eyMYYQVwOqLkqhFYblm",
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
