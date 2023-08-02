//
//  TransactionViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift
import RxRelay

class TransactionViewModel: BaseViewModel {
    
    // MARK: - Reactive properties
    let transaction: BehaviorRelay<Transaction?> = BehaviorRelay(value: nil)
    
    // MARK: - ViewController mode
    var viewControllerMode: ViewControllerMode = .add {
        didSet {
            
        }
    }
    enum ViewControllerMode {
        case add
        case edit
    }
    
    // MARK: - EditTransactionViewController
    
//    init() {
//        configureBindings()
//    }
}
// MARK: - Display icons
extension TransactionViewModel {
    var displayMerchantCellIcon: UIImage? { return UIImage(systemName: Icons.giftcard) }
    var displayCategoryCellIcon: UIImage? { return UIImage(systemName: Icons.plus) }
    var displayTagCellIcon: UIImage? { return UIImage(systemName: Icons.tag) }
    var displayPaymentMethodIcon: UIImage? { return UIImage(systemName: Icons.creditcard) }
    
    var displayIcon: UIImage? {
        return transaction.value?.icon
    }
    var displayIconColor: UIColor? {
        if let id = transaction.value?.mainCategoryID {
            return MainCategory.getColor(of: id)
        }
        return nil
    }
    var displayDateValue: YearMonthDay {
        return transaction.value?.date ?? YearMonthDay.today
    }
    var displayMerchantString: String? {
        guard let id = transaction.value?.merchantID, let merchant = appCoordinator?.dataProvider.getMerchant(for: id) else { return nil }
        return merchant.value
    }
    var displayCurrencyCodeString: String? {
        return transaction.value?.currencyCode
    }
    var displayAmountValue: Double {
        return transaction.value?.amount ?? 0
    }
    var displayFxRateString: String? {
//        if transaction.value.currencyCode != CacheManager.shared.preferredCurrencyCode,
//           let fxRateString = Currency.getFxRateString(from: transaction.value.currencyCode,
//                                                       to: CacheManager.shared.preferredCurrencyCode),
//           let amountInTargetCurrency = Currency.convertValue(from: transaction.value.currencyCode,
//                                                              transaction.value.amount,
//                                                              to: CacheManager.shared.preferredCurrencyCode) {
//            self.displayFxRateString.accept(fxRateString
//                                            + "\n"
//                                            + "(\(amountInTargetCurrency.toCurrencyString(for: CacheManager.shared.preferredCurrencyCode)))")
//        }
        return nil
    }
    var displayCategoryString: String? {
        if let id = transaction.value?.categoryID, let categoryName = Category.getCategoryName(of: id) {
            return categoryName
        }
        return nil
    }
    var displayTagString: String? {
        return transaction.value?.tag.name
    }
    var displayRecurringRuleValue: String? {
        guard
            let recurringID = transaction.value?.recurringID,
            let item = appCoordinator?.dataProvider.getRecurringTransaction(recurringID)
        else { return nil }
        
        return item.rule.getRuleString()
    }
    var displayNoteString: String? {
        return transaction.value?.note
    }

}
// MARK: - Configure values of displayStrings
extension TransactionViewModel {
    
}
// MARK: - Update database
extension TransactionViewModel {
    func addTransaction() {
        guard
            let transaction = transaction.value,
            viewControllerMode == .add,
            let dataProvider = appCoordinator?.dataProvider
        else { return }
        
        dataProvider.addData(of: transaction) { result in
            switch result {
            case .success:
                return
            case .failure(let error):
                ErrorHandler.shared.handle(error)
            }
        }
    }
    func updateTransactionDate(to date: YearMonthDay) {
        guard var transactionData = transaction.value else { return }
        
        transactionData.date = date
        self.transaction.accept(transactionData)
        updateData(transactionData)
    }
    func updateTransaction(_ field: Transaction.EditableField, to value: Any) {
        guard var transactionData = transaction.value else { return }

        switch field {
        case .type:
            guard let value = value as? TransactionType else { return }
            transactionData.type = value
        case .amount:
            guard
                let value = value as? Double,
                value != transactionData.amount
            else { return }
            transactionData.amount = value
        case .merchantID:
            guard let merchantID = value as? MerchantID else { return }
            transactionData.merchantID = merchantID
        case .categoryID:
            guard let categoryID = value as? CategoryID else { return }
            transactionData.categoryID = categoryID
        case .tag:
            guard
                let value = value as? String,
                let tag = TransactionTag(rawValue: value)
            else { return }
            transactionData.tag = tag
        case .note:
            guard let note = value as? String else { return }
            transactionData.note = note
        case .currencyCode:
            guard let value = value as? CurrencyCode else { return }
            transactionData.currencyCode = value
        default:
            return
        }
        self.transaction.accept(transactionData)
        updateData(transactionData)
    }
    
    private func updateData(_ data: Transaction) {
        guard let dataProvider = appCoordinator?.dataProvider, viewControllerMode == .edit else { return }
        
        dataProvider.updateData(of: data) { result in
            switch result {
            case .success:
                return
            case .failure(let error):
                ErrorHandler.shared.handle(error)
            }
        }
    }
}
// MARK: - Editable Fields
extension TransactionViewModel {
    func getOptionListTitleString(at field: Transaction.EditableField) -> String {
        switch field {
        case .merchantID:
            return "Select Merchant"
        case .categoryID:
            return "Select Category"
        case .tag:
            return "Select Tag"
        default:
            return ""
        }
    }
    func getOptionsData(at field: Transaction.EditableField) -> [String] {
        switch field {
        case .merchantID:
            return appCoordinator?.dataProvider.getAllMerchants().map({ $0.id.uuidString }) ?? []
        case .categoryID:
            return Category.getAllCategoryIDs().sorted()
        case .tag:
            return TransactionTag.allCases.map { $0.rawValue }
        default:
            return []
        }
    }
    func getSelectedIndex(at field: Transaction.EditableField) -> Int? {
        guard let transaction = transaction.value else { return nil }
        switch field {
        case .merchantID:
            return getOptionsData(at: .merchantID).firstIndex(of: transaction.merchantID.uuidString)
        case .categoryID:
            return getOptionsData(at: .categoryID).firstIndex(of: transaction.categoryID)
        case .tag:
            return getOptionsData(at: .tag).firstIndex(of: transaction.tag.rawValue)
        default:
            return nil
        }
    }
    func getMerchantName(of idString: String) -> String? {
        guard let uuid = UUID(uuidString: idString) else { return nil }
        let merchantsMap = appCoordinator?.dataProvider.getMerchantsMap()
        return merchantsMap?[uuid]?.value
    }
}
