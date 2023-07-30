//
//  TransactionListViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import Foundation
import Collections
import RxSwift
import RxRelay
import UIKit

/// Shared ViewModel to retrieve and calculate transactions
class TransactionListViewModel: BaseViewModel {
//    lazy var transactionDataSource = TransactionDataSource.dataSource()
//
//    // MARK: - Reactive Properties
//    private var transactions: BehaviorRelay<TransactionList> = BehaviorRelay(value: [])
//    var displayTransactions: BehaviorRelay<[TransactionSection]> = BehaviorRelay(value: [])
//    var displayMonthlyBalanceString: BehaviorRelay<String> = BehaviorRelay(value: "")
//
//    // MARK: - For HomeViewController
//    var numberOfDaysOfTransactionsToDisplay = 30
//    var maxiumNumberOfTransactionsToDisplay = 10
//
//    override init() {
//        super.init()
//        configureSignals()
//    }
}
// MARK: - Setup
//extension TransactionListViewModel {
//    enum ReloadTransactionsOption {
//        case inRecentThirtyDays
//        case inGivenMonth(Int, Int)
//        case pendingOnly
//    }
//    func reloadTransactions(_ option: ReloadTransactionsOption,
//                            shouldPull: Bool = false,
//                            completion: ((_ result: VoidResult) -> Void)? = nil) {
//
//        let dispatchGroup = DispatchGroup()
//        var result: VoidResult? = nil
//
//        switch option {
//        case .inRecentThirtyDays:
//            dispatchGroup.enter()
//            getTransactionsInThePast(shouldPull: shouldPull) { data in
//                result = data
//                dispatchGroup.leave()
//            }
//        case .inGivenMonth(let year, let month):
//            dispatchGroup.enter()
//            getMonthlyTransactions(year: year, month: month, shouldPull: shouldPull) { data in
//                result = data
//                dispatchGroup.leave()
//            }
//        case .pendingOnly:
//            dispatchGroup.enter()
//            getScheduledTransactions(shouldPull: shouldPull) { data in
//                result = data
//                dispatchGroup.leave()
//            }
//        }
//        dispatchGroup.notify(queue: .main) {
//            guard let result = result else { return }
//            switch result {
//            case .success:
//                let balanace = Database.shared.calculateMonthlyBalance(year: Date.today.year, month: Date.today.month)
//                self.displayMonthlyBalanceString.accept(balanace.toCurrencyString())
//            case .failure( _):
//                break
//            }
//            if let completion = completion {
//                return completion(result)
//            }
//        }
//    }
//    private func configureSignals() {
//        self.transactions
//            .asObservable()
//            .subscribe { _ in
//                let sections: [TransactionSection] = self.transactions.value.groupedByDay()
//                    .map { TransactionSection(header: $0, items: $1) }
//                    .sortedByDate()
//                self.displayTransactions.accept(sections)
//            }
//            .disposed(by: disposeBag)
//    }
//}
//// MARK: - Get single transaction
//extension TransactionListViewModel {
//    func getTransaction(at indexPath: IndexPath) -> Transaction? {
//        return displayTransactions.value[indexPath.section].items[indexPath.row]
//    }
//}
//// MARK: - Link to Database
//extension TransactionListViewModel {
//    func deleteTransaction(at indexPath: IndexPath, completion: (() -> Void)? = nil) {
//        guard let transaction = getTransaction(at: indexPath) else { return }
//        var updatedData: TransactionList = transactions.value
//        updatedData.remove(id: transaction.id)
//        transactions.accept(updatedData)
//        Database.shared.deleteData(of: transaction.id) { result in
//            switch result {
//            case .success:
//                break
//            case .failure(let error):
//                ErrorHandler.shared.handle(error)
//            }
//            if let completion = completion {
//                return completion()
//            }
//        }
//    }
//    private func getTransactionsInThePast(shouldPull: Bool, completion: @escaping(VoidResult) -> Void) {
//        Database.shared.getTransactionsInThePast(numberOfDaysOfTransactionsToDisplay, shouldPull: shouldPull) { result in
//            switch result {
//            case .failure(let error):
//                self.transactions.accept([])
//                return completion(.failure(error))
//            case .success(let data):
//                self.transactions.accept(data)
//                return completion(.success)
//            }
//        }
//    }
//    private func getMonthlyTransactions(year: Int,
//                                        month: Int,
//                                        shouldPull: Bool,
//                                        completion: @escaping(VoidResult) -> Void) {
//        Database.shared.getMonthlyTransactions(year: year, month: month, shouldPull: shouldPull) { result in
//            switch result {
//            case .failure(let error):
//                self.transactions.accept([])
//                return completion(.failure(error))
//            case .success(let data):
//                self.transactions.accept(data)
//                return completion(.success)
//            }
//        }
//    }
//    private func getScheduledTransactions(shouldPull: Bool, completion: @escaping(VoidResult) -> Void) {
//        Database.shared.getScheduledTransactions(shouldPull: shouldPull) { result in
//            switch result {
//            case .failure(let error):
//                self.transactions.accept([])
//                return completion(.failure(error))
//            case .success(let data):
//                self.transactions.accept(data)
//                return completion(.success)
//            }
//        }
//    }
//}
