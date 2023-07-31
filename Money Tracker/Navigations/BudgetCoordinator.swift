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
        case viewTransactionDetail(TransactionID)
        case selectFromOptionList(Transaction.EditableField, TransactionViewModel)
    }
}

// MARK: - ViewController List
extension BudgetCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        switch destination {
        case .editBudgets:
            let viewController = EditBudgetListViewController(appCoordinator: self.parentCoordinator,
                                                              coordinator: self,
                                                              viewModel: EditBudgetListViewModel(appCoordinator: self.parentCoordinator))
            return viewController
        case .viewBudgetDetail(let id):
            let viewModel = BudgetViewModel(appCoordinator: self.parentCoordinator)
            let budget = parentCoordinator?.dataProvider.getBudget(id)
            viewModel.budget.accept(budget)
            let viewController = BudgetDetailViewController(appCoordinator: self.parentCoordinator,
                                                            coordinator: self,
                                                            viewModel: viewModel)
            return viewController
        case .viewTransactionDetail(let transactionID):
            let viewModel = TransactionViewModel(appCoordinator: self.parentCoordinator)
            let transaction = parentCoordinator?.dataProvider.getTransaction(for: transactionID)
            viewModel.transaction.accept(transaction)
            let viewController = EditTransactionViewController(appCoordinator: self.parentCoordinator,
                                                               coordinator: self,
                                                               viewModel: viewModel,
                                                               mode: .edit)
            return viewController
        case .selectFromOptionList(let field, let transactionViewModel):
            let viewController = TransactionFieldOptionListViewController(appCoordinator: self.parentCoordinator,
                                                                          coordinator: self,
                                                                          viewModel: transactionViewModel, field: field)
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
extension BudgetCoordinator: TransactionCoordinator {
    func showEditBudgets() {
        guard let viewController = makeViewController(for: .editBudgets) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: true)
        self.navigate(to: viewController, presentModally: true, options: options)
    }
    func showBudgetDetail(_ id: BudgetID) {
        guard let viewController = makeViewController(for: .viewBudgetDetail(id)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showTransactionDetail(_ id: TransactionID) {
        guard let viewController = makeViewController(for: .viewTransactionDetail(id)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showOptionList(at field: Transaction.EditableField, transactionViewModel: TransactionViewModel) {
        guard let viewController = makeViewController(for: .selectFromOptionList(field, transactionViewModel)) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: true)
        self.navigate(to: viewController, presentModally: true, options: options)
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
