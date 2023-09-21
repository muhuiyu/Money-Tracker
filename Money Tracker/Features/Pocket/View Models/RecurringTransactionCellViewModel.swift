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
    
    var displayIcon: UIImage? {
        return recurringTransaction.value?.icon
    }
    var displayMerchantString: String? {
        if let merchantID = recurringTransaction.value?.merchantID, let merchantName = self.merchantList[merchantID] {
            return merchantName.value
        }
        return nil
    }
    var displayCategoryString: String? {
        if let categoryID = recurringTransaction.value?.categoryID, let categoryName = Category.getCategoryName(of: categoryID) {
            return categoryName
        }
        return nil
    }
    var displayRecurringRuleString: String? {
        return recurringTransaction.value?.rule.getRuleString()
    }
    var displayNextDateString: String? {
        return "Next on " +  (recurringTransaction.value?.nextTransactionDate.toDate?.formatted() ?? "")
    }
    var displayAmountString: String? {
        return recurringTransaction.value?.signedAmount.toCurrencyString()
    }
    
    var merchantList: [MerchantID: Merchant] = [:]
    
}
