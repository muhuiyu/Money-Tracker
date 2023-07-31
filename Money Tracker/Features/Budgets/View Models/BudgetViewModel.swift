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
    var budgetID: BehaviorRelay<BudgetID> = BehaviorRelay(value: "")
    private var budget: BehaviorRelay<Budget?> = BehaviorRelay(value: nil)
    
    // MARK: - For BudgetDetailViewController
    var displayTransactions: BehaviorRelay<[TransactionSection]> = BehaviorRelay(value: [])
    
    // MARK: - For BudgetCell
    var displayIcon: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    var displayCategoryString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayNumberOfTransactionsString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayDailyAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayMonthlyAverageString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayRemainingAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayUsedPercentageString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayTotalAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayTotalAmountDouble: BehaviorRelay<Double> = BehaviorRelay(value: 0)
    
    override init(appCoordinator: AppCoordinator? = nil) {
        super.init(appCoordinator: appCoordinator)
        configureSignals()
    }
}
extension BudgetViewModel {
    var isOverSpent: Bool {
        guard let budget = budget.value else { return false }
        return budget.remainingAmount < 0
    }
}
extension BudgetViewModel {
    private func configureSignals() {
        self.budgetID
            .asObservable()
            .subscribe(onNext: { value in
//                if let data = Database.shared.getBudget(value) {
//                    self.budget.accept(data)
//                }
            })
            .disposed(by: disposeBag)
        
        self.budget
            .asObservable()
            .subscribe(onNext: { value in
                if let value = value {
                    self.displayIcon.accept(value.icon)
                    self.displayMonthlyAverageString.accept("Monthly average: \(value.monthlyAverageExpense.toCurrencyString())")
                    self.displayTotalAmountString.accept("of \(value.amount.toCurrencyString())")
                    self.displayTotalAmountDouble.accept(value.amount)
                    
                    if value.remainingAmount < 0 {
                        self.displayDailyAmountString.accept("\((-value.remainingAmount).toCurrencyString()) \(Localized.Budget.overspent)")
                        let zeroLeft: Double = 0
                        self.displayRemainingAmountString.accept("\(zeroLeft.toCurrencyString()) left")
                    } else {
                        let remainingDailyAmount: Double = value.remainingAmount / Double(Date.today.numberOfDaysRemainingToEndOfMonth)
                        self.displayDailyAmountString.accept("\(remainingDailyAmount.toCurrencyString()) / day")
                        self.displayRemainingAmountString.accept("\(value.remainingAmount.toCurrencyString()) left")
                    }
                    
                    if let mainCategoryName = MainCategory.getName(of: value.mainCategoryID)?.capitalizingFirstLetter() {
                        self.displayCategoryString.accept(mainCategoryName)
                    }
                    self.displayUsedPercentageString.accept(value.usedPercentageString)
                    self.updateTransactionCells()
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    private func updateTransactionCells() {
        guard let budget = budget.value else { return }
        budget.getExpenses { transactions in
            let sections: [TransactionSection] = transactions.groupedByDay()
                .map { TransactionSection(header: $0, items: $1) }
                .sortedByDate()
            self.displayTransactions.accept(sections)
        }
    }
}
