//
//  TransactionSettings.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
//

import UIKit

typealias TransactionID = UUID

protocol TransactionSettings: Codable {
    var merchantID: MerchantID { get set }
    var currencyCode: CurrencyCode { get set }
    var amount: Double { get set }
    var type: TransactionType { get }
    var note: String { get set }
    var categoryID: CategoryID { get set }
    var tag: TransactionTag { get set }
}

extension TransactionSettings {
    var signedAmount: Double {
        type == .expense ? -amount : amount
    }
    var icon: UIImage? {
        if let iconName = Category.getCategoryIconName(of: self.categoryID) {
            return UIImage(systemName: iconName)
        }
        return UIImage(systemName: Icons.questionmark)
    }
    var mainCategoryID: CategoryID? {
        return Category.getMainCategoryID(of: self.categoryID)
    }
}
