//
//  BudgetCell.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//


import UIKit
import RxSwift

class BudgetCell: DoubleTitlesValuesCell {
//    static let reuseID: String = NSStringFromClass(BudgetCell.self)
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
        let tintColor = MainCategory.getColor(of: viewModel.budget.value?.mainCategoryID ?? "")
        iconView.backgroundColor = tintColor.withAlphaComponent(0.2)
        iconView.layer.cornerRadius = 8
        iconView.image = viewModel.displayIcon
        iconView.tintColor = tintColor
        
        titleLabel.text = viewModel.displayCategoryString
        subtitleLabel.textColor = viewModel.getStatus() == .over ? .red : .secondaryLabel
        subtitleLabel.text = viewModel.displayDailyAmountString
        valueLabel.text = viewModel.displayRemainingAmountString
        subvalueLabel.text = viewModel.displayTotalAmountString
    }
}
