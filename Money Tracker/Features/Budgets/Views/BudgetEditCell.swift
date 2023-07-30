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
    var viewModel = BudgetViewModel()
    
    override func configureViews() {
        super.configureViews()
        textField.delegate = self
    }
    
    override func configureSignals() {
        viewModel.displayIcon
            .asObservable()
            .subscribe { image in
                self.iconView.image = image
            }
            .disposed(by: disposeBag)

        viewModel.displayCategoryString
            .asObservable()
            .subscribe { value in
                self.titleLabel.text = value
            }
            .disposed(by: disposeBag)

        viewModel.displayMonthlyAverageString
            .asObservable()
            .subscribe { value in
                self.subtitleLabel.text = value
            }
            .disposed(by: disposeBag)

        viewModel.displayTotalAmountDouble
            .asObservable()
            .subscribe { value in
                self.textField.text = value.formatted()
            }
            .disposed(by: disposeBag)
    }
    
}
// MARK: - Delegate
extension BudgetEditCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text)
    }
}
