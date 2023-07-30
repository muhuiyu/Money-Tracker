//
//  BudgetSummaryCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/9/22.
//

import UIKit

class BudgetSummaryCell: UITableViewCell {
    static let reuseID = NSStringFromClass(BudgetSummaryCell.self)
    
    private let amountStack = UIStackView()
    private let remainingAmountLabel = UILabel()
    private let totalAmountLabel = UILabel()
    private let statusLabel = UILabel()
    // TODO: - chart
    private let chartView = UIView()
    
    var remainingAmountString: String? {
        didSet {
            remainingAmountLabel.text = remainingAmountString
        }
    }
    var totalAmountString: String? {
        didSet {
            totalAmountLabel.text = totalAmountString
        }
    }
    var statusString: String? {
        didSet {
            statusLabel.text = statusString
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - View Config
extension BudgetSummaryCell {
    private func configureViews() {
        remainingAmountLabel.font = UIFont.h1
        remainingAmountLabel.textColor = .label
        remainingAmountLabel.text = "default"
        remainingAmountLabel.textAlignment = .left
        amountStack.addArrangedSubview(remainingAmountLabel)
        
        totalAmountLabel.font = UIFont.body
        totalAmountLabel.textColor = .secondaryLabel
        totalAmountLabel.textAlignment = .left
        amountStack.addArrangedSubview(totalAmountLabel)
        
        amountStack.axis = .horizontal
        amountStack.alignment = .firstBaseline
        amountStack.spacing = Constants.Spacing.trivial
        contentView.addSubview(amountStack)
        
        statusLabel.font = UIFont.small
        statusLabel.textColor = .secondaryLabel
        statusLabel.textAlignment = .left
        statusLabel.text = "default"
        contentView.addSubview(statusLabel)
    }
    private func configureConstraints() {
        amountStack.snp.remakeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.medium)
            make.leading.equalTo(contentView.layoutMarginsGuide)
        }
        statusLabel.snp.remakeConstraints { make in
            make.top.equalTo(amountStack.snp.bottom).offset(Constants.Spacing.small)
            make.leading.trailing.equalTo(amountStack)
            make.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.small)
        }
    }
    private func configureGestures() {
        
    }
}
