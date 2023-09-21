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
    private let recurringRuleLabel = UILabel()
    private let nextDateLabel = UILabel()
    private let signedAmountLabel = UILabel()
    
    private let disposeBag = DisposeBag()
    var viewModel = RecurringTransactionCellViewModel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
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
        
        merchantLabel.textColor = .label
        merchantLabel.font = .bodyBold
        merchantLabel.text = "default"
        detailStack.addArrangedSubview(merchantLabel)
        
        recurringRuleLabel.textColor = .secondaryLabel
        recurringRuleLabel.font = .small
        recurringRuleLabel.text = "default"
        detailStack.addArrangedSubview(recurringRuleLabel)
        
        nextDateLabel.textColor = .secondaryLabel
        nextDateLabel.font = .small
        nextDateLabel.text = "default"
        detailStack.addArrangedSubview(nextDateLabel)
                
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
    private func configureData() {
        iconView.image = viewModel.displayIcon
        merchantLabel.text = viewModel.displayMerchantString
        recurringRuleLabel.text = viewModel.displayRecurringRuleString
        nextDateLabel.text = viewModel.displayNextDateString
        signedAmountLabel.text = viewModel.displayAmountString
        signedAmountLabel.textColor = viewModel.recurringTransaction.value?.type.color
    }
    private func configureBindings() {
        viewModel.recurringTransaction
            .asObservable()
            .subscribe { [weak self] _ in
                self?.configureData()
            }
            .disposed(by: disposeBag)
    }
}

