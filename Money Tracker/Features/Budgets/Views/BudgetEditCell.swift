//
//  BudgetEditCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit
import RxSwift

class BudgetEditCell: DoubleTitlesTextFieldCell, BaseCell {
    static let reuseID = NSStringFromClass(BudgetEditCell.self)
    
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
    
    override func configureBindings() {
//        viewModel.budget
//            .asObservable()
//            .subscribe { [weak self] value in
//                self?.configureData()
//            }
//            .disposed(by: disposeBag)
        
//        viewModel.displayMonthlyAverageString
//            .asObservable()
//            .subscribe { value in
//                self.subtitleLabel.text = value
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.displayTotalAmountDouble
//            .asObservable()
//            .subscribe { value in
//                self.textField.text = value.formatted()
//            }
//            .disposed(by: disposeBag)
    }
    
    private func configureData() {
        iconView.image = budget?.icon
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
