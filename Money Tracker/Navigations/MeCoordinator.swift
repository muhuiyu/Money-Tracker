//
//  MeCoordinator.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class MeCoordinator: BaseCoordinator {
    enum Destination {
        case viewAccountSettings
        case recurringTransactions
        case recurringTransactionDetails(RecurringTransactionID)
        case mainCurrency
        case wallets
    }
}

// MARK: - ViewController List
extension MeCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        switch destination {
        case .viewAccountSettings:
            return BaseViewController()
        case .recurringTransactions:
            return RecurringTransactionsViewController(appCoordinator: self.parentCoordinator, coordinator: self, viewModel: RecurringTransactionsViewModel(appCoordinator: self.parentCoordinator))
        case .recurringTransactionDetails(let id):
            return BaseViewController()
        case .mainCurrency:
            return BaseViewController()
        case .wallets:
            return WalletsViewController(appCoordinator: self.parentCoordinator, coordinator: self, viewModel: WalletsViewModel(appCoordinator: self.parentCoordinator))
        }
    }
}

// MARK: - Navigation
extension MeCoordinator {
    func showRecurringTransactions() {
        guard let viewController = makeViewController(for: .recurringTransactions) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showRecurringTransactionDetails(_ id: RecurringTransactionID) {
        guard let viewController = makeViewController(for: .recurringTransactionDetails(id)) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showMainCurrency() {
        guard let viewController = makeViewController(for: .mainCurrency) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
    func showWallets() {
        guard let viewController = makeViewController(for: .wallets) else { return }
        self.navigate(to: viewController, presentModally: false)
    }
}
