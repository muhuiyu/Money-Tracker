//
//  TransactionCellViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift
import RxRelay

class TransactionCellViewModel {
    private let disposeBag = DisposeBag()
    
    var subtitleAttribute: SubtitleAttrible = .category
    enum SubtitleAttrible {
        case date
        case category
    }
    
    // MARK: - Reactive properties
    var transaction: BehaviorRelay<Transaction?> = BehaviorRelay(value: nil)
    
    var displayIcon: UIImage? {
        return transaction.value?.icon
    }
    var displayMerchantString: String? {
        if let merchantID = transaction.value?.merchantID, let merchantName = merchantList[merchantID]?.value {
            return merchantName
        }
        return nil
    }
    var displayCategoryString: String? {
        if let categoryID = transaction.value?.categoryID, let categoryName = Category.getCategoryName(of: categoryID) {
            return categoryName
        }
        return nil
    }
    var displayDateString: String? {
        return transaction.value?.dateStringInLocalDateFormat
    }
    var displayAmountString: String? {
        return transaction.value?.signedAmount.toCurrencyString(for: transaction.value?.currencyCode ?? "SGD")
    }
    
    var merchantList: [MerchantID: Merchant] = [:]
}
