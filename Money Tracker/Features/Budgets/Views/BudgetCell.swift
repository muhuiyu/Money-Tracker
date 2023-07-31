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
    private var viewModel: BudgetViewModel
    
    init(appCoordinator: AppCoordinator? = nil, budget: Budget) {
        viewModel = BudgetViewModel(appCoordinator: appCoordinator)
        super.init(style: .default, reuseIdentifier: nil)
        viewModel.budget.accept(budget)
        configureBindings()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureBindings() {
        viewModel.displayTransactions
            .asObservable()
            .subscribe { [weak self] _ in
                self?.configureData()
            }
            .disposed(by: disposeBag)
    }
    
    
    private func configureData() {
        iconView.image = viewModel.displayIcon
        titleLabel.text = viewModel.displayCategoryString
        subtitleLabel.textColor = viewModel.getStatus() == .over ? .red : .secondaryLabel
        subtitleLabel.text = viewModel.displayDailyAmountString
        valueLabel.text = viewModel.displayRemainingAmountString
        subvalueLabel.text = viewModel.displayTotalAmountString
    }
}
