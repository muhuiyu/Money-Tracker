//
//  BudgetEditCell.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import UIKit
import RxSwift

class BudgetEditCell: DoubleTitlesTextFieldCell {
//    static let reuseID = NSStringFromClass(BudgetEditCell.self)

    var changeBudgetAmountHandler: (() -> Void)?
    
    var budget: Budget? {
        didSet {
            configureData() // set title and icon
        }
    }
    
    var value: Double {
        get { return Double(textField.text ?? "") ?? 0 }
        set { textField.text = newValue.toStringTwoDigits() }
    }
    
    override func configureViews() {
        super.configureViews()
        textField.addTarget(self, action: #selector(didChangeValue(_:)), for: .editingChanged)
        textField.returnKeyType = .done
    }
    
    private func configureData() {
        let tintColor = MainCategory.getColor(of: budget?.mainCategoryID ?? "")
        iconView.backgroundColor = tintColor.withAlphaComponent(0.2)
        iconView.layer.cornerRadius = 8
        iconView.image = budget?.icon
        iconView.tintColor = tintColor
        titleLabel.text = MainCategory.getName(of: budget?.mainCategoryID ?? "")
        textField.keyboardType = .decimalPad
    }
    
    @objc
    private func didChangeValue(_ sender: UITextField) {
        if
            let text = sender.text,
            !text.isEmpty,
            text.last != ".",
            let _ = Double(text) {
            changeBudgetAmountHandler?()
        }
    }
}
