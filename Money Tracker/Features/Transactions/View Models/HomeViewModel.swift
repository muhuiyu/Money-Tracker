//
//  HomeViewModel.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class HomeViewModel: BaseViewModel {

    // MARK: - Reactive Properties
    private var transactions: BehaviorRelay<TransactionList> = BehaviorRelay(value: [])
    var displayTransactions: BehaviorRelay<[TransactionSection]> = BehaviorRelay(value: [])
    let income = BehaviorRelay(value: Double())
    let expense = BehaviorRelay(value: Double())
    let currentYearMonth: BehaviorRelay<YearMonth> = BehaviorRelay(value: YearMonth.now)

//    private var accounts: BehaviorRelay<[Account]> = BehaviorRelay(value: [])
//    var displayMonthlyBalanceString: BehaviorRelay<String> = BehaviorRelay(value: "")
//    var displayNumberOfAccountsString: BehaviorRelay<String> = BehaviorRelay(value: "")

    override init(appCoordinator: AppCoordinator? = nil) {
        super.init(appCoordinator: appCoordinator)
        configureBindings()
        getAccounts()
    }
}

extension HomeViewModel {
    // TODO: - Add localized string
    var displayTitle: String { "Home" }
    var displayRefreshControlString: String { Localized.General.pullToRefresh }
}

extension HomeViewModel {
    private func getAccounts() {
        // TODO: - get accounts
//        let value = [
//            Account(id: CacheManager.shared.mainAccountID, name: "main", amount: 0),
//            Account(id: "91c98c38-0f35-4221-b06e-0c6b11e487a3", name: "investment", amount: 0),
//            Account(id: "b0f1f586-52b2-4be4-865a-795dad47d3e7", name: "LTL wallet", amount: 0),
//        ]
//        accounts.accept(value)
    }
}

extension HomeViewModel {
    func reloadTransactions(completion: ((_ result: VoidResult) -> Void)? = nil) {
        guard let dataProvider = appCoordinator?.dataProvider else {
            completion?(.failure(Database.RealmError.missingDataProvider))
            return
        }
        transactions.accept(dataProvider.getTransactions(year: currentYearMonth.value.year,
                                                         month: currentYearMonth.value.month))
        completion?(.success)
    }
    
    private func configureBindings() {
        self.transactions
            .asObservable()
            .subscribe { _ in
                // Reconfigure tableView section datas
                let sections: [TransactionSection] = self.transactions.value.groupedByDay()
                    .map { TransactionSection(header: $0, items: $1) }
                    .sortedByDate()
                self.displayTransactions.accept(sections)
                
                // Reconfigure summaryView (income, expense)
                let income = self.transactions.value
                    .filter { $0.type == .income }
                    .reduce(into: Double()) { $0 += $1.amount }
                self.income.accept(income)
                
                let expense = self.transactions.value
                    .filter { $0.type == .expense }
                    .reduce(into: Double()) { $0 += $1.amount }
                self.expense.accept(expense)
            }
            .disposed(by: disposeBag)
        
        self.currentYearMonth
            .asObservable()
            .subscribe { _ in
                self.reloadTransactions()
            }
            .disposed(by: disposeBag)

//        self.accounts
//            .asObservable()
//            .subscribe { _ in
//                self.displayNumberOfAccountsString.accept("\(self.accounts.value.count) accounts")
//            }
//            .disposed(by: disposeBag)
    }
    func getTransaction(at indexPath: IndexPath) -> Transaction? {
        return displayTransactions.value[indexPath.section].items[indexPath.row]
    }

    func deleteTransaction(at indexPath: IndexPath, completion: (() -> Void)? = nil) {
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
    }
    private func getTransactionsInThePast(shouldPull: Bool, completion: @escaping(VoidResult) -> Void) {
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
    }
    private func getMonthlyTransactions(year: Int,
                                        month: Int,
                                        shouldPull: Bool,
                                        completion: @escaping(VoidResult) -> Void) {
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
    }
    private func getScheduledTransactions(shouldPull: Bool, completion: @escaping(VoidResult) -> Void) {
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
    }
}
