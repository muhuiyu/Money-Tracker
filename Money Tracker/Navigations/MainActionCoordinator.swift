//
//  MainActionCoordinator.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/2/23.
//

import Foundation

class MainActionCoordinator: BaseCoordinator {
    enum Destination {
        case addTransaction(Transaction?)
    }
}

// MARK: - ViewController List
extension MainActionCoordinator {
    private func makeViewController(for destination: Destination) -> ViewController? {
        switch destination {
        case .addTransaction(let transaction):
            let viewController = EditTransactionViewController(appCoordinator: self.parentCoordinator,
                                                               coordinator: self,
                                                               viewModel: TransactionViewModel(appCoordinator: self.parentCoordinator),
                                                               mode: .add)
            if var transaction = transaction {
                viewController.viewModel.transaction.accept(transaction)
            } else {
                viewController.viewModel.transaction.accept(Transaction())
            }
            return viewController
        }
    }

}

// MARK: - Navigation
extension MainActionCoordinator {
    func showAddTransaction(copyFrom transaction: Transaction? = nil) {
        guard let viewController = makeViewController(for: .addTransaction(transaction)) else { return }
        let options = ModalOptions(isEmbedInNavigationController: true, isModalInPresentation: true)
        self.navigate(to: viewController, presentModally: true, options: options)
    }
}
