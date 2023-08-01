//
//  RecurringTransactionCellViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/4/22.
//

import UIKit
import RxSwift
import RxRelay

class RecurringTransactionCellViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactive properties
    var recurringTransaction: BehaviorRelay<RecurringTransaction?> = BehaviorRelay(value: nil)
    
    var displayIcon: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    var displayMerchantString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayCategoryString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayRecurringRuleString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    var merchantList: [MerchantID: Merchant] = [:]
    
    init() {
        recurringTransaction
            .asObservable()
            .subscribe(onNext: { value in
                if let value = value {
                    self.displayIcon.accept(value.icon)
                    self.displayRecurringRuleString.accept(value.displayRecuringRuleString)
                    self.displayAmountString.accept(value.signedAmount.toCurrencyString())
                    
                    if let merchantName = self.merchantList[value.merchantID]?.value {
                        self.displayMerchantString.accept(merchantName)
                    }
                    if let categoryName = Category.getCategoryName(of: value.categoryID) {
                        self.displayCategoryString.accept(categoryName)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
