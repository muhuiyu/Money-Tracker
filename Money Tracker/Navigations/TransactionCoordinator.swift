//
//  TransactionCoordinator.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation

protocol TransactionCoordinator: BaseCoordinator {
    func showTransactionDetail(_ id: TransactionID)
    func showOptionList(at field: Transaction.EditableField, transactionViewModel: TransactionViewModel)
}
