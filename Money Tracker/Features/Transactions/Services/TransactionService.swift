//
//  TransactionService.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
//

import Foundation
import RxSwift
import RxRelay
import UIKit

//class TransactionService: Base.FirebaseService<Transaction> {
//
//    #if DEBUG
//        static let isMocking = true
//    #else
//        static let isMocking = false
//    #endif
//
//
//    var numberOfDaysOfTransactionsToDisplay: Int { return 30 }
//    var maxiumNumberOfTransactionsToDisplay: Int { return 10 }
//
//    static func getTransactionsInThePast() -> Observable<[Transaction]> {
//        guard !isMocking else {
//            return Observable.just(mockData)
//        }
//        return Observable<[Transaction]>.create { observer -> Disposable in
//            Database.shared.getTransactionsInThePast(30, shouldPull: true) { result in
//                switch result {
//                case .success(let data):
//                    observer.onNext(data)
//                case .failure(let error):
//                    observer.onError(error)
//                }
//            }
//            return Disposables.create {
//                // TODO: -
//            }
//        }
//    }
//
//    static var mockData: [Transaction] {
//        return [
//            Transaction(),
//            Transaction()
//        ]
//    }
//}
