//
//  TransactionPreviewCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit
import RxSwift

class TransactionPreviewCell: TitleSubtitleAmountCell, BaseCell {
    static let reuseID = NSStringFromClass(TransactionPreviewCell.self)
    
    let viewModel = TransactionCellViewModel()
    override func configureBindings() {
        viewModel.transaction
            .asObservable()
            .subscribe { [weak self] _ in
                self?.configureData()
            }
            .disposed(by: disposeBag)
    }
    
    private func configureData() {
        iconView.image = viewModel.displayIcon
        titleLabel.text = viewModel.displayMerchantString
        signedAmountLabel.text = viewModel.displayAmountString
        
        switch viewModel.transaction.value?.type {
        case .expense:
            signedAmountLabel.textColor = .systemRed
        case .income:
            signedAmountLabel.textColor = .systemGreen
        default:
            signedAmountLabel.textColor = .black
        }
        
        if viewModel.subtitleAttribute == .date {
            subtitleLabel.text = viewModel.displayDateString
        }
        if viewModel.subtitleAttribute == .category {
            subtitleLabel.text = viewModel.displayCategoryString
        }
    }
}
