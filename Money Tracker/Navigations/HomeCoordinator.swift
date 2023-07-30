//
//  HomeCoordinator.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    enum Destination {
        case viewNotifications
        case viewTransactionList
        case viewTransactionDetail(TransactionID)
        case selectFromOptionList(Transaction.EditableField, TransactionViewModel)
        case addTransaction(Transaction?)
        case viewMonthlyAnalysis
        case viewMonthlyAnalysisCategoryDetail(TransactionList)
        case viewPocket
        case viewRecurringTransactionDetail(RecurringTransactionID)
    }
}

// MARK: - ViewController List
extension HomeCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        switch destination {
        case .viewNotifications:
            // TODO: -
            return BaseViewController(appCoordinator: self.parentCoordinator)
        case .viewTransactionList:
            return TransactionListViewController(appCoordinator: self.parentCoordinator,
                                                 coordinator: self)
        case .viewMonthlyAnalysis:
            let viewController = AnalysisViewController(appCoordinator: self.parentCoordinator,
                                                        coordinator: self)
            viewController.viewModel.monthAndYear = MonthAndYear(date: Date.today)
            return viewController
        case .viewMonthlyAnalysisCategoryDetail(let transactions):
            let viewController = AnalysisCategoryDetailViewController(appCoordinator: self.parentCoordinator,
                                                                      coordinator: self)
            viewController.transacitons = transactions
            return viewController
        case .viewTransactionDetail(let transactionID):
            let viewController = EditTransactionViewController(appCoordinator: self.parentCoordinator,
                                                               coordinator: self,
                                                               mode: .edit)
//            viewController.viewModel.transactionID.accept(transactionID)
            return viewController
        case .selectFromOptionList(let field, let transactionViewModel):
            let viewController = TransactionFieldOptionListViewController(appCoordinator: self.parentCoordinator,
                                                                          coordinator: self,
                                                                          viewModel: transactionViewModel, field: field)
            return viewController
        case .addTransaction(let transaction):
            let viewController = EditTransactionViewController(appCoordinator: self.parentCoordinator,
                                                               coordinator: self,
                                                               mode: .add)
//            if var transaction = transaction {
//                transaction.id = UUID()
//                viewController.viewModel.transaction.accept(transaction)
//            } else {
//                viewController.viewModel.transaction.accept(Transaction())
//            }
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
extension HomeCoordinator {
    func showNotifications() {
        guard let viewController = makeViewController(for: .viewNotifications) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: false)
        self.navigate(to: viewController, presentModally: true, options: options)
    }
    // MARK: - Transaction List
    func showTransactionList() {
        guard let viewController = makeViewController(for: .viewTransactionList) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showTransactionDetail(_ id: TransactionID) {
        guard let viewController = makeViewController(for: .viewTransactionDetail(id)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    // MARK: - Analysis
    func showMonthlyAnalysis() {
        guard let viewController = makeViewController(for: .viewMonthlyAnalysis) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showMonthlyAnalysisCategoryDetail(_ transactions: TransactionList) {
        guard let viewController = makeViewController(for: .viewMonthlyAnalysisCategoryDetail(transactions)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    // MARK: - Edit Transaction List
    func showOptionList(at field: Transaction.EditableField, transactionViewModel: TransactionViewModel) {
        guard let viewController = makeViewController(for: .selectFromOptionList(field, transactionViewModel)) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: true)
        self.navigate(to: viewController, presentModally: true, options: options)
    }
    // MARK: - Add Transactions
    func showAddTransaction(copyFrom transaction: Transaction? = nil) {
        guard let viewController = makeViewController(for: .addTransaction(transaction)) else { return }
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