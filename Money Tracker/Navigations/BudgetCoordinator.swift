//
//  BudgetCoordinator.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit

class BudgetCoordinator: BaseCoordinator {
    enum Destination {
        case editBudgets
        case viewBudgetDetail(BudgetID)
        case viewPocket
        case viewRecurringTransactionDetail(RecurringTransactionID)
    }
}

// MARK: - ViewController List
extension BudgetCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        switch destination {
        case .editBudgets:
            let viewController = EditBudgetViewController(appCoordinator: self.parentCoordinator,
                                                          coordinator: self)
            return viewController
        case .viewBudgetDetail(let id):
            let viewController = BudgetDetailViewController(appCoordinator: self.parentCoordinator,
                                                            coordinator: self)
            viewController.viewModel.budgetID.accept(id)
            return viewController
        case .viewPocket:
            let viewController = PocketViewController(appCoordinator: self.parentCoordinator,
                                                      coordinator: self)
            return viewController
        case .viewRecurringTransactionDetail:
            // TODO: - Add details
            return BaseViewController()
        }
    }
}

// MARK: - Navigation
extension BudgetCoordinator {
    // MARK: - Budget
    func showEditBudget() {
        guard let viewController = makeViewController(for: .editBudgets) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showBudgetDetail(_ id: BudgetID) {
        guard let viewController = makeViewController(for: .viewBudgetDetail(id)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    // MARK: - Pocket (scheduled transactions)
    func showPocket() {
        guard let viewController = makeViewController(for: .viewPocket) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showRecurringTransactionDetail(_ id: RecurringTransactionID) {
        guard let viewController = makeViewController(for: .viewRecurringTransactionDetail(id)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
}
