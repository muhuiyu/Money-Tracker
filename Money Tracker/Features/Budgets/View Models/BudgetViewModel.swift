//
//  BudgetViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift
import RxRelay

class BudgetViewModel: BaseViewModel {
    lazy var transactionDataSource = TransactionDataSource.dataSource(appCoordinator)
    
    // MARK: - Reactive properties
    let budget: BehaviorRelay<Budget?> = BehaviorRelay(value: nil)

    // MARK: - For BudgetDetailViewController
    private var transactions: [Transaction] = []
    private(set) var displayTransactions: BehaviorRelay<[TransactionSection]> = BehaviorRelay(value: [])
    
    override init(appCoordinator: AppCoordinator? = nil) {
        super.init(appCoordinator: appCoordinator)
        configureBindings()
    }
}
extension BudgetViewModel {
    func getStatus() -> BudgetState {
        if remainingAmount > 0 {
            return .under
        } else if remainingAmount == 0 {
            return .budget
        } else {
            return .over
        }
    }
    
    // MARK: - For BudgetCell
    var displayIcon: UIImage? { return budget.value?.icon }
    var displayCategoryString: String? {
        guard let mainCategoryID = budget.value?.mainCategoryID else {
            return nil
        }
        return MainCategory.getName(of: mainCategoryID)?.capitalizingFirstLetter()
    }
    var displayNumberOfTransactionsString: String? {
        return nil
    }
    var displayDailyAmountString: String? {
        if remainingAmount < 0 {
            return "\((-remainingAmount).toCurrencyString()) \(Localized.Budget.overspent)"
        } else {
            let remainingDailyAmount: Double = remainingAmount / Double(Date.today.numberOfDaysRemainingToEndOfMonth)
            return "\(remainingDailyAmount.toCurrencyString()) / day"
        }
    }
    var displayMonthlyAverageString: String? {
        return "Monthly average: " + getMonthlyAverageExpense().toCurrencyString()
    }
    var displayRemainingAmountString: String {
        if remainingAmount < 0 {
            let zeroLeft: Double = 0
            return "\(zeroLeft.toCurrencyString()) left"
        } else {
            return "\(remainingAmount.toCurrencyString()) left"
        }
    }
    var displayUsedPercentageString: String? {
        let usedPercentage = (1 - (remainingAmount / (budget.value?.amount ?? 1))) * 100
        return "\(String(usedPercentage.rounded()))%"
    }
    var displayTotalAmountString: String? {
        return "of " + (budget.value?.amount.toCurrencyString() ?? "")
    }
    var displayTotalAmountDouble: Double {
        return budget.value?.amount ?? 0
    }
    
    private var remainingAmount: Double {
        return (budget.value?.amount ?? 0) - totalExpenseAmount
    }
    
    private var totalExpenseAmount: Double {
        return transactions.reduce(into: 0, { $0 += $1.amount })
    }
    
    func updateAmount(to value: Double) {
        guard var budgetData = budget.value else { return }
        budgetData.amount = value
        print("new value", value)
        budget.accept(budgetData)
    }
}
extension BudgetViewModel {
    private func configureBindings() {
        budget
            .asObservable()
            .subscribe { [weak self] _ in
                self?.getMonthlyTransactions()
            }
            .disposed(by: disposeBag)
    }
    
    private func getMonthlyTransactions() {
        guard let dataProvider = appCoordinator?.dataProvider, let mainCategoryID = budget.value?.mainCategoryID else {
            return
        }
        transactions = dataProvider.getMonthlyTransactions(year: Date.today.year,
                                                           month: Date.today.month,
                                                           of: mainCategoryID,
                                                           calculateExpenseOnly: true,
                                                           shouldIncludePending: false)
        
        // Update transactionCells
        let sections: [TransactionSection] = transactions.groupedByDay()
            .map { TransactionSection(header: $0, items: $1) }
            .sortedByDate()
        displayTransactions.accept(sections)
    }
    
    
    private func getMonthlyAverageExpense() -> Double {
        guard let dataProvider = appCoordinator?.dataProvider else { return 0 }
        return dataProvider.getMonthlyAverageExpense(of: budget.value?.mainCategoryID)
    }
}
