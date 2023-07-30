//
//  BudgetCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//


import UIKit
import RxSwift

class BudgetCell: DoubleTitlesValuesCell, BaseCell {
    static let reuseID: String = NSStringFromClass(BudgetCell.self)
    var viewModel = BudgetViewModel()
    
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
        
        viewModel.displayDailyAmountString
            .asObservable()
            .subscribe(onNext: { value in
                self.subtitleLabel.text = value
                self.subtitleLabel.textColor = self.viewModel.isOverSpent ? .red : .secondaryLabel
            })
            .disposed(by: disposeBag)

        viewModel.displayRemainingAmountString
            .asObservable()
            .subscribe { value in
                self.valueLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayTotalAmountString
            .asObservable()
            .subscribe { value in
                self.subvalueLabel.text = value
            }
            .disposed(by: disposeBag)
    }
}
