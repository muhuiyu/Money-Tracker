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
    
    var viewModel = TransactionCellViewModel()
    override func configureSignals() {
        viewModel.displayIcon
            .asObservable()
            .subscribe { image in
                self.iconView.image = image
            }
            .disposed(by: disposeBag)

        viewModel.displayMerchantString
            .asObservable()
            .subscribe { value in
                self.titleLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayDateString
            .asObservable()
            .subscribe(onNext: { value in
                if self.viewModel.subtitleAttribute == .date {
                    self.subtitleLabel.text = value
                }
            })
            .disposed(by: disposeBag)
    
        viewModel.displayCategoryString
            .asObservable()
            .subscribe(onNext: { value in
                if self.viewModel.subtitleAttribute == .category {
                    self.subtitleLabel.text = value
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.displayAmountString
            .asObservable()
            .subscribe { value in
                self.signedAmountLabel.text = value
            }
            .disposed(by: disposeBag)
    }
}
