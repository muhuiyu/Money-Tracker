//
//  HomeViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 6/25/22.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class HomeViewModel: BaseViewModel {
//
//    lazy var transactionDataSource = TransactionDataSource.dataSource()
//
//    // MARK: - Reactive Properties
//    private var transactions: BehaviorRelay<TransactionList> = BehaviorRelay(value: [])
//    var displayTransactions: BehaviorRelay<[TransactionSection]> = BehaviorRelay(value: [])
//
//    private var accounts: BehaviorRelay<[Account]> = BehaviorRelay(value: [])
//    var displayMonthlyBalanceString: BehaviorRelay<String> = BehaviorRelay(value: "")
//    var displayNumberOfAccountsString: BehaviorRelay<String> = BehaviorRelay(value: "")
//
//    var numberOfDaysOfTransactionsToDisplay = 30

//    override init() {
//        super.init()
//        configureSignals()
//        getAccounts()
//    }
}

extension HomeViewModel {
    // TODO: - Add localized string
    var displayTitle: String { "Home" }
    var displayRefreshControlString: String { Localized.General.pullToRefresh }
}

extension HomeViewModel {
//    private func getAccounts() {
//        // TODO: - get accounts
//        let value = [
//            Account(id: CacheManager.shared.mainAccountID, name: "main", amount: 0),
//            Account(id: "mT7nK7iUhn1YCHNw8kum", name: "investment", amount: 0),
//            Account(id: "gDdNw4lDK2xNXbxr3aie", name: "LTL wallet", amount: 0),
//        ]
//        accounts.accept(value)
//    }
}

extension HomeViewModel {
//    enum ReloadTransactionsOption {
//        case inRecentThirtyDays
//        case inGivenMonth(Int, Int)
//        case pendingOnly
//    }
//
//    func reloadTransactions(_ option: HomeViewModel.ReloadTransactionsOption,
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
//
//        self.accounts
//            .asObservable()
//            .subscribe { _ in
//                self.displayNumberOfAccountsString.accept("\(self.accounts.value.count) accounts")
//            }
//            .disposed(by: disposeBag)
//    }
//    func getTransaction(at indexPath: IndexPath) -> Transaction? {
//        return displayTransactions.value[indexPath.section].items[indexPath.row]
//    }
//
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
}
