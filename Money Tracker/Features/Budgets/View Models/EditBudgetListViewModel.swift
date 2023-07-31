//
//  EditBudgetListViewModel.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

class EditBudgetListViewModel: BaseViewModel {
    
    // MARK: - Reactive Properties
    let editingBudgets: BehaviorRelay<BudgetList> = BehaviorRelay(value: [])
    
    override init(appCoordinator: AppCoordinator? = nil) {
        super.init(appCoordinator: appCoordinator)
        
    }
}

extension EditBudgetListViewModel {
    func reloadBudgets(completion: ((_ result: VoidResult) -> Void)? = nil) {
        guard let dataProvider = appCoordinator?.dataProvider else {
            completion?(.failure(Database.RealmError.missingDataProvider))
            return
        }
        editingBudgets.accept(dataProvider.getAllBudgets())
        completion?(.success)
    }
    
    func getBudgetItem(at indexPath: IndexPath) -> Budget? {
        return editingBudgets.value[indexPath.row]
    }
    
    func getBudgetItemID(at indexPath: IndexPath) -> BudgetID? {
        return editingBudgets.value[indexPath.row].id
    }
    
    func updateEditingBudget(to amount: Double, at indexPath: IndexPath) {
        var editingBudgetsData = editingBudgets.value
        editingBudgetsData[indexPath.row].amount = amount
        editingBudgets.accept(editingBudgetsData)
    }
    
    func updateBudgets() {
        guard let dataProvider = appCoordinator?.dataProvider else { return }
        dataProvider.updateData(of: editingBudgets.value) { result in
            switch result {
            case .success:
                return
            case .failure(let error):
                ErrorHandler.shared.handle(error)
            }
        }
    }
}

// MARK: - display titles
extension EditBudgetListViewModel {
    var displayTitle: String { Localized.Budget.title }
    var sectionTitles: [String] { [Localized.Budget.thisMonth, Localized.Budget.categoryBudgets] }
    
    private func getRemainingAmount() -> Double {
        guard let dataProvider = appCoordinator?.dataProvider else { return 0 }
        let monthlyExpenseAmount = dataProvider.getMonthlyExpenseAmount(year: Date.today.year,
                                                                        month: Date.today.month)
        return editingBudgets.value.totalBudgetAmount - monthlyExpenseAmount
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
