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
    var displayIcon: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    var displayMerchantString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayCategoryString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayDateString: BehaviorRelay<String> = BehaviorRelay(value: "")
    var displayAmountString: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    init() {
        transaction
            .asObservable()
            .subscribe(onNext: { value in
                if let value = value {
                    self.displayIcon.accept(value.icon)
                    self.displayDateString.accept(value.dateStringInLocalDateFormat)
                    if let merchantName = Merchant.getMerchantName(of: value.merchantID) {
                        self.displayMerchantString.accept(merchantName)
                    }
                    if let categoryName = Category.getCategoryName(of: value.categoryID) {
                        self.displayCategoryString.accept(categoryName)
                    }
                    self.displayAmountString.accept(value.signedAmount.toCurrencyString(for: value.currencyCode))
                }
            })
            .disposed(by: disposeBag)
    }
}
