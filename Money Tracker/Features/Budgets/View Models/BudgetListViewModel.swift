//
//  BudgetListViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class BudgetListViewModel: BaseViewModel {

    // MARK: - Shared ViewModel
//    var budgetViewModel = BudgetViewModel()
    
    // MARK: - Reactive Properties
//    private(set) var cells: BehaviorRelay<[[UITableViewCell]]> = BehaviorRelay(value: [])
//    private var budgets: BehaviorRelay<BudgetList> = BehaviorRelay(value: [])
//    private var displayBudgets: BehaviorRelay<[BudgetSection]> = BehaviorRelay(value: [])
//
//    init() {
//        self.budgets
//            .asObservable()
//            .subscribe { _ in
//                self.configureCells()
//            }
//            .disposed(by: disposeBag)
//    }
}

//extension BudgetListViewModel {
//    func reloadBudgets(shouldPull: Bool = false,
//                       completion: (() -> Void)? = nil) {
//        Database.shared.getBudgetList(shouldPull: shouldPull) { result in
//            switch result {
//            case .failure(let error):
//                ErrorHandler.shared.handle(error)
//            case .success(let data):
//                self.budgets.accept(data
//                    .filter { $0.amount != 0 }
//                    .sorted(by: .remainingAmount))
//            }
//        }
//        if let completion = completion {
//            return completion()
//        }
//    }
//    func getBudgetItem(at indexPath: IndexPath) -> Budget? {
//        return budgets.value[indexPath.row]
//    }
//    func getBudgetItemID(at indexPath: IndexPath) -> BudgetID? {
//        return budgets.value[indexPath.row].id
//    }
//}
//
//// MARK: - display titles
//extension BudgetListViewModel {
//    var displayTitle: String { Localized.Budget.title }
//    var sectionTitles: [String] { [Localized.Budget.thisMonth, Localized.Budget.categoryBudgets] }
//}
//
//extension BudgetListViewModel {
//    private func configureCells() {
//
//        let group = DispatchGroup()
//        var amountOfScheduledPayment: Double = 0
//        var newCells = [[UITableViewCell]]()
//
//        group.enter()
//        getAmountOfScheduledPayment { value in
//            amountOfScheduledPayment = value
//            group.leave()
//        }
//        group.notify(queue: .main) {
//            // 1. Summary cells
//            let summaryCell = BudgetSummaryCell()
//            summaryCell.remainingAmountString = self.getRemainingAmount().toCurrencyString()
//            summaryCell.totalAmountString = "/ " + self.budgets.value.totalBudgetAmount.toCurrencyString()
//            summaryCell.statusString = Localized.Budget.safeToSpend
//            let pendingExpenseCell = TitleValueCell()
//            pendingExpenseCell.titleLabel.text = Localized.Budget.upcomingPayments
//            pendingExpenseCell.valueLabel.text = amountOfScheduledPayment.toCurrencyString()
//            newCells.append([summaryCell, pendingExpenseCell])
//
//            // 2. Budget cells
//            let budgetIDs = self.budgets.value.map { $0.id }
//            let budgetCells: [BudgetCell] = budgetIDs.map { id in
//                let cell = BudgetCell()
//                cell.viewModel.budgetID.accept(id)
//                return cell
//            }
//            newCells.append(budgetCells)
//
//            // 3. add to cells
//            self.cells.accept(newCells)
//        }
//    }
//    private func getRemainingAmount() -> Double {
//        let monthlyExpenseAmount = Database.shared.getMonthlyExpenseAmount(in: Date.today.month, of: Date.today.year)
//        return budgets.value.totalBudgetAmount - monthlyExpenseAmount
//    }
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
//}
