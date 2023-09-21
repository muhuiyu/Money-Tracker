//
//  QuickAddItemPreviewCell.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/2/23.
//

import UIKit
import RxSwift

class QuickAddItemPreviewCell: TitleSubtitleAmountCell, BaseCell {
    static let reuseID = NSStringFromClass(QuickAddItemPreviewCell.self)
    
    var item: TransactionSettings? {
        didSet {
            configureData()
        }
    }
    var merchantName: String? {
        didSet {
            titleLabel.text = merchantName
        }
    }
    
    private func configureData() {
        let tintColor = Category.getCategoryIconColor(of: item?.categoryID ?? "")
        iconView.backgroundColor = tintColor.withAlphaComponent(0.2)
        iconView.layer.cornerRadius = 8
        iconView.image = item?.icon
        iconView.tintColor = tintColor
        signedAmountLabel.text = item?.signedAmount.toCurrencyString()
        subtitleLabel.text = Category.getCategoryName(of: item?.categoryID ?? "")
        
        switch item?.type {
        case .expense:
            signedAmountLabel.textColor = .systemRed
        case .income:
            signedAmountLabel.textColor = .systemGreen
        default:
            signedAmountLabel.textColor = .black
        }
    }
}
