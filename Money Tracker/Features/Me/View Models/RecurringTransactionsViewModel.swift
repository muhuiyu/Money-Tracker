//
//  RecurringTransactionsViewModel.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit
import RxSwift
import RxRelay

class RecurringTransactionsViewModel: BaseViewModel {
    
    let recurringTransactions: BehaviorRelay<[RecurringTransaction]> = BehaviorRelay(value: [])
    
    var sections: [[RecurringTransaction]] {
        var entries = [[RecurringTransaction]](repeating: [RecurringTransaction](), count: 2)
        recurringTransactions.value.forEach { item in
            if item.isActive {
                entries[0].append(item)
            } else {
                entries[1].append(item)
            }
        }
        return entries
    }
    
    var estimatedSpendString: String {
        return "Estimated spend: \(estimatedSpend.toCurrencyString()) monthly"
    }
    
    var estimatedSpend: Double {
        return recurringTransactions.value.reduce(into: 0) { partialResult, transaction in
            if transaction.type == .expense {
                partialResult += transaction.amount
            }
        }
    }
    
    override init(appCoordinator: AppCoordinator? = nil) {
        super.init(appCoordinator: appCoordinator)
    }
}

extension RecurringTransactionsViewModel {
    func reloadData() {
        guard let dataProvider = appCoordinator?.dataProvider else { return }
        let data = dataProvider.getAllRecurringTransactions()
        recurringTransactions.accept(data.sorted { $0.nextTransactionDate < $1.nextTransactionDate })
    }
    
    func deleteData(_ recurringTransaction: RecurringTransaction) {
        appCoordinator?.dataProvider.deleteData(recurringTransaction.id)
    }
    
}
