//
//  RecurringTransactionCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import UIKit
import RxSwift

class RecurringTransactionCell: UITableViewCell {
    static let reuseID = NSStringFromClass(RecurringTransactionCell.self)

    private let iconView = UIImageView()
    private let detailStack = UIStackView()
    private let merchantLabel = UILabel()
    private let recurringRuleCell = UILabel()
    private let signedAmountLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    var viewModel = RecurringTransactionCellViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension RecurringTransactionCell {
    private func configureViews() {
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        merchantLabel.textColor = UIColor.label
        merchantLabel.font = UIFont.bodyHeavy
        merchantLabel.text = "default"
        detailStack.addArrangedSubview(merchantLabel)
        
        recurringRuleCell.textColor = UIColor.secondaryLabel
        recurringRuleCell.font = UIFont.small
        recurringRuleCell.text = "default"
        detailStack.addArrangedSubview(recurringRuleCell)
                
        detailStack.alignment = .leading
        detailStack.axis = .vertical
        detailStack.spacing = Constants.Spacing.trivial
        contentView.addSubview(detailStack)
        
        signedAmountLabel.textColor = UIColor.Brand.primary
        signedAmountLabel.font = UIFont.h3
        signedAmountLabel.text = "default"
        contentView.addSubview(signedAmountLabel)
    }
    private func configureConstraints() {
        iconView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.size.equalTo(Constants.IconButtonSize.small)
        }
        detailStack.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.Spacing.medium)
        }
        signedAmountLabel.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(detailStack.snp.trailing)
        }
        detailStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        viewModel.displayIcon
            .asObservable()
            .subscribe { image in
                self.iconView.image = image
            }
            .disposed(by: disposeBag)

        viewModel.displayMerchantString
            .asObservable()
            .subscribe { value in
                self.merchantLabel.text = value
            }
            .disposed(by: disposeBag)
        
        viewModel.displayRecurringRuleString
            .asObservable()
            .subscribe { value in
                self.recurringRuleCell.text = value
            }
            .disposed(by: disposeBag)
        
//        viewModel.displayCategoryString
//            .asObservable()
//            .subscribe { value in
//
//            }
//            .disposed(by: disposeBag)
        
        viewModel.displayAmountString
            .asObservable()
            .subscribe { value in
                self.signedAmountLabel.text = value
            }
            .disposed(by: disposeBag)

    }
}
