//
//  AnalysisMainCategoryPreviewCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/10/22.
//

import UIKit
import RxSwift

class AnalysisMainCategoryPreviewCell: TitleSubtitleAmountCell, BaseCell {
    static let reuseID = NSStringFromClass(TransactionPreviewCell.self)

    private var savedMainCategoryID: CategoryID? {
        didSet {
            guard let savedMainCategoryID = savedMainCategoryID else {
                return
            }
            if let imageName = MainCategory.getIconName(of: savedMainCategoryID) {
                iconView.image = UIImage(systemName: imageName)
            }
            titleLabel.text = MainCategory.getName(of: savedMainCategoryID)
        }
    }
    var mainCategoryID: CategoryID? {
        get { return savedMainCategoryID }
        set { savedMainCategoryID = newValue }
    }
    var numberOfTransactionsString: String? {
        didSet {
            subtitleLabel.text = numberOfTransactionsString
        }
    }
    var signedAmount: Double = 0 {
        didSet {
            signedAmountLabel.text = signedAmount.toCurrencyString()
        }
    }
}
