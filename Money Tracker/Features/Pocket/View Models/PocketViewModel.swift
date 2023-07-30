//
//  PocketViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class PocketViewModel {
    private let disposeBag = DisposeBag()

    // MARK: - Reactive Properties
    var recurringTransactions: BehaviorRelay<[RecurringTransaction]> = BehaviorRelay(value: [])
    private var pendingTranscationCells = [TransactionPreviewCell]()
    
    init() {
//        configureSignals()
    }
}
//extension PocketViewModel {
//    func reloadRecurringTransactions(shouldPull: Bool = false,
//                                     completion: (() -> Void)? = nil) {
//        getRecurringTransactions(shouldPull: shouldPull) { result in
//            switch result {
//            case .success:
//                break
//            case .failure(let error):
//                ErrorHandler.shared.handle(error)
//            }
//        }
//        if let completion = completion {
//            return completion()
//        }
//    }
//}
extension PocketViewModel {
    var displayTitle: String { Localized.Pocket.title }
}

// MARK: - Private functions
//extension PocketViewModel {
//    private func configureSignals() {
//
//    }
//    private func getRecurringTransactions(shouldPull: Bool, completion: @escaping(VoidResult) -> Void) {
//        Database.shared.getRecurringTransactions(shouldPull: shouldPull) { result in
//            switch result {
//            case .failure(let error):
//                self.recurringTransactions.accept([])
//                return completion(.failure(error))
//            case .success(let data):
//                self.recurringTransactions.accept(data.sorted { $0.nextTransactionDate < $1.nextTransactionDate })
//                return completion(.success)
//            }
//        }
//    }
//    func deleteRecurringTransaction(_ recurringTransaction: RecurringTransaction, completion: (() -> Void)? = nil) {
//        // TODO: - connect to database
//        print("will delete")
//        if let completion = completion {
//            return completion()
//        }
//    }
//}
//
