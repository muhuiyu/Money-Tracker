//
//  BudgetListViewModel.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class BudgetListViewModel: BaseViewModel {

    // MARK: - Reactive Properties
    private(set) var cells: BehaviorRelay<[[UITableViewCell]]> = BehaviorRelay(value: [])
    private var budgets: BehaviorRelay<BudgetList> = BehaviorRelay(value: [])
    
    override init(appCoordinator: AppCoordinator? = nil) {
        super.init(appCoordinator: appCoordinator)
        configureBindings()
    }
}

extension BudgetListViewModel {
    func reloadBudgets(completion: ((_ result: VoidResult) -> Void)? = nil) {
        guard let dataProvider = appCoordinator?.dataProvider else {
            completion?(.failure(Database.RealmError.missingDataProvider))
            return
        }
        budgets.accept(dataProvider.getAllBudgets())
        completion?(.success)
    }
    
    func getBudgetItem(at indexPath: IndexPath) -> Budget? {
        return budgets.value[indexPath.row]
    }

    func getBudgetItemID(at indexPath: IndexPath) -> BudgetID? {
        return budgets.value[indexPath.row].id
    }
    
    private func configureBindings() {
        budgets
            .asObservable()
            .subscribe { _ in
                self.configureCells()
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - display titles
extension BudgetListViewModel {
    var displayTitle: String { Localized.Budget.title }
    var sectionTitles: [String] { [Localized.Budget.thisMonth, Localized.Budget.categoryBudgets] }
}

extension BudgetListViewModel {
    /// Configure cells for BudgetListViewModel
    private func configureCells() {
        var newCells = [[UITableViewCell]]()
        
        // TODO: - chnage
        var amountOfScheduledPayment: Double = 0
        
        // 1. Summary cells
        let summaryCell = BudgetSummaryCell()
        summaryCell.remainingAmountString = self.getRemainingAmount().toCurrencyString()
        summaryCell.totalAmountString = "/ " + self.budgets.value.totalBudgetAmount.toCurrencyString()
        summaryCell.statusString = Localized.Budget.safeToSpend
        let pendingExpenseCell = TitleValueCell()
        pendingExpenseCell.titleLabel.text = Localized.Budget.upcomingPayments
        pendingExpenseCell.valueLabel.text = amountOfScheduledPayment.toCurrencyString()
        newCells.append([summaryCell, pendingExpenseCell])
        
        // 2. Budget cells
        let budgetCells: [BudgetCell] = budgets.value.map {
            BudgetCell(appCoordinator: self.appCoordinator, budget: $0)
        }
        newCells.append(budgetCells)

        // 3. add to cells
        cells.accept(newCells)
    }
    
    private func getRemainingAmount() -> Double {
        guard let dataProvider = appCoordinator?.dataProvider else { return 0 }
        let monthlyExpenseAmount = dataProvider.getMonthlyExpenseAmount(year: Date.today.year,
                                                                        month: Date.today.month)
        return budgets.value.totalBudgetAmount - monthlyExpenseAmount
    }
    
//    private func getAmountOfScheduledPayment(completion: @escaping ((Double) -> Void)) {
//        Database.shared.getScheduledTransactions(shouldPull: true, calculateExpenseOnly: true) { result in
//            var totalAmount: Double = 0
//            switch result {
//            case .failure(let error):
//                ErrorHandler.shared.handle(error)
//            case .success(let transactions):
//                totalAmount = transactions.reduce(0, { $0 + $1.amount })
//            }
//            return completion(totalAmount)
//        }
//    }
//
}
