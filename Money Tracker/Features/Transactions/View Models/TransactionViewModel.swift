//
//  TransactionViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift
import RxRelay

class TransactionViewModel {
    private let disposeBag = DisposeBag()
    
    // MARK: - Reactive properties
//    var transactionID: BehaviorRelay<TransactionID> = BehaviorRelay(value: UUID())
//    var transaction: BehaviorRelay<Transaction?> = BehaviorRelay(value: nil)
//
//    var displayIcon: BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
//    var displayDateValue: BehaviorRelay<YearMonthDay> = BehaviorRelay(value: YearMonthDay.today)
//    var displayMerchantString: BehaviorRelay<String> = BehaviorRelay(value: "")
//    var displayCurrencyCodeString: BehaviorRelay<String> = BehaviorRelay(value: "")
//    var displayAmountValue: BehaviorRelay<Double> = BehaviorRelay(value: 0)
//    var displayFxRateString: BehaviorRelay<String> = BehaviorRelay(value: "")
//    var displayPaymentMethodString: BehaviorRelay<String> = BehaviorRelay(value: "")
//    var displayCategoryString: BehaviorRelay<String> = BehaviorRelay(value: "")
//    var displayTagString: BehaviorRelay<String> = BehaviorRelay(value: "")
//    var displayRecurringRuleValue: BehaviorRelay<String> = BehaviorRelay(value: "")
//    var displayNoteString: BehaviorRelay<String> = BehaviorRelay(value: "")
    
    // MARK: - ViewController mode
//    var viewControllerMode: ViewControllerMode = .add {
//        didSet {
//            guard let value = transaction.value else { return }
//            configureDisplayStrings(with: value)
//        }
//    }
    enum ViewControllerMode {
        case add
        case edit
    }
    
    // MARK: - EditTransactionViewController
    
//    init() {
//        configureSignals()
//    }
}
// MARK: - Display icons
//extension TransactionViewModel {
//    var displayMerchantCellIcon: UIImage? { return UIImage(systemName: Icons.giftcard) }
//    var displayCategoryCellIcon: UIImage? { return UIImage(systemName: Icons.plus) }
//    var displayTagCellIcon: UIImage? { return UIImage(systemName: Icons.tag) }
//    var displayPaymentMethodIcon: UIImage? { return UIImage(systemName: Icons.creditcard) }
//}
//// MARK: - Configure values of displayStrings
//extension TransactionViewModel {
//    private func configureDisplayStrings(with value: Transaction) {
//        self.displayIcon.accept(value.icon)
//        self.displayDateValue.accept(value.date)
//        self.displayAmountValue.accept(value.amount)
//        self.displayPaymentMethodString.accept(value.paymentBy.rawValue)
//        self.displayNoteString.accept(value.note)
//        self.displayTagString.accept(value.tag.rawValue)
//        self.displayRecurringRuleValue.accept(RecurringTransaction.getRecurringRuleString(value.recurringID))
//        self.displayCurrencyCodeString.accept(value.currencyCode)
//
//        if value.currencyCode != CacheManager.shared.preferredCurrencyCode,
//           let fxRateString = Currency.getFxRateString(from: value.currencyCode,
//                                                       to: CacheManager.shared.preferredCurrencyCode),
//           let amountInTargetCurrency = Currency.convertValue(from: value.currencyCode,
//                                                              value.amount,
//                                                              to: CacheManager.shared.preferredCurrencyCode) {
//            self.displayFxRateString.accept(fxRateString
//                                            + "\n"
//                                            + "(\(amountInTargetCurrency.toCurrencyString(for: CacheManager.shared.preferredCurrencyCode)))")
//        }
//
//        if let merchantName = Merchant.getMerchantName(of: value.merchantID) {
//            self.displayMerchantString.accept(merchantName)
//        }
//        if let categoryName = Category.getCategoryName(of: value.categoryID) {
//            self.displayCategoryString.accept(categoryName)
//        }
//    }
//    private func configureSignals() {
//        self.transactionID
//            .asObservable()
//            .subscribe(onNext: { value in
//                if let data = Database.shared.getTransaction(value) {
//                    self.transaction.accept(data)
//                }
//            })
//            .disposed(by: disposeBag)
//        self.transaction
//            .asObservable()
//            .subscribe(onNext: { value in
//                if let value = value {
//                    self.configureDisplayStrings(with: value)
//                    print(value.id) // for debugging
//                }
//            })
//            .disposed(by: disposeBag)
//    }
//}
//// MARK: - Update database
//extension TransactionViewModel {
//    func addTransaction() {
//        guard let transaction = transaction.value, viewControllerMode == .add else { return }
//        Database.shared.addData(of: transaction) { result in
//            switch result {
//            case .success:
//                return
//            case .failure(let error):
//                ErrorHandler.shared.handle(error)
//            }
//        }
//    }
//    func updateTransactionDate(to date: YearMonthDay) {
//        guard var transactionData = transaction.value else { return }
//        transactionData.year = date.year
//        transactionData.month = date.month
//        transactionData.day = date.day
//        self.transaction.accept(transactionData)
//
//        if viewControllerMode == .edit {
//            let data: [String: Any] = [
//                Transaction.EditableField.year.rawValue: date.year,
//                Transaction.EditableField.month.rawValue: date.month,
//                Transaction.EditableField.day.rawValue: date.day,
//            ]
//            Database.shared.updateData(of: transactionData, data, merge: true) { result in
//                switch result {
//                case .success:
//                    return
//                case .failure(let error):
//                    ErrorHandler.shared.handle(error)
//                }
//            }
//        }
//    }
//    func updateTransaction(_ field: Transaction.EditableField, to value: Any) {
//        guard var transactionData = transaction.value else { return }
//
//        switch field {
//        case .amount:
//            guard
//                let value = value as? Double,
//                value != transactionData.amount
//            else { return }
//            transactionData.amount = value
//        case .merchantID:
//            guard let merchantID = value as? MerchantID else { return }
//            transactionData.merchantID = merchantID
//        case .categoryID:
//            guard let categoryID = value as? CategoryID else { return }
//            transactionData.categoryID = categoryID
//        case .paymentBy:
//            guard
//                let value = value as? String,
//                let paymentMethod = PaymentMethod(rawValue: value)
//            else { return }
//            transactionData.paymentBy = paymentMethod
//        case .tag:
//            guard
//                let value = value as? String,
//                let tag = TransactionTag(rawValue: value)
//            else { return }
//            transactionData.tag = tag
//        case .note:
//            guard let note = value as? String else { return }
//            transactionData.note = note
//        default:
//            return
//        }
//        self.transaction.accept(transactionData)
//
//        guard viewControllerMode == .edit else { return }
//        Database.shared.updateData(of: transactionData, [field.rawValue: value], merge: true) { result in
//            switch result {
//            case .success:
//                return
//            case .failure(let error):
//                ErrorHandler.shared.handle(error)
//            }
//        }
//    }
//}
//// MARK: - Editable Fields
//extension TransactionViewModel {
//    func getOptionListTitleString(at field: Transaction.EditableField) -> String {
//        switch field {
//        case .paymentBy:
//            return "Select Payment Method"
//        case .merchantID:
//            return "Select Merchant"
//        case .categoryID:
//            return "Select Category"
//        case .tag:
//            return "Select Tag"
//        default:
//            return ""
//        }
//    }
//    func getOptionsData(at field: Transaction.EditableField) -> [String] {
//        switch field {
//        case .paymentBy:
//            return PaymentMethod.allCases.map { $0.rawValue }
//        case .merchantID:
//            return Merchant.getAllMerchantIDs()
//        case .categoryID:
//            return Category.getAllCategoryIDs().sorted()
//        case .tag:
//            return TransactionTag.allCases.map { $0.rawValue }
//        default:
//            return []
//        }
//    }
//    func getSelectedIndex(at field: Transaction.EditableField) -> Int? {
//        guard let transaction = transaction.value else { return nil }
//        switch field {
//        case .paymentBy:
//            return getOptionsData(at: .paymentBy).firstIndex(of: transaction.paymentBy.rawValue)
//        case .merchantID:
//            return getOptionsData(at: .merchantID).firstIndex(of: transaction.merchantID)
//        case .categoryID:
//            return getOptionsData(at: .categoryID).firstIndex(of: transaction.categoryID)
//        case .tag:
//            return getOptionsData(at: .tag).firstIndex(of: transaction.tag.rawValue)
//        default:
//            return nil
//        }
//    }
//}
