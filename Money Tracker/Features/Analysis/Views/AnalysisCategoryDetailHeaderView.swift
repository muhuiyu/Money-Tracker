//
//  AnalysisCategoryDetailHeaderView.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/11/22.
//

import UIKit

class AnalysisCategoryDetailHeaderView: UIView {
    private let titleLabel = UILabel()
    private let amountLabel = UILabel()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var displayTotalAmountString: String? {
        didSet {
            amountLabel.text = displayTotalAmountString
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
        configureGestures()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension AnalysisCategoryDetailHeaderView {
    private func configureViews() {
        titleLabel.font = UIFont.body
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        addSubview(titleLabel)
        amountLabel.font = UIFont.h1
        amountLabel.textAlignment = .left
        amountLabel.textColor = .label
        addSubview(amountLabel)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.equalTo(layoutMarginsGuide).inset(Constants.Spacing.medium)
            make.leading.trailing.equalTo(layoutMarginsGuide).inset(Constants.Spacing.small)
        }
        amountLabel.snp.remakeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constants.Spacing.small)
            make.leading.trailing.equalTo(titleLabel)
            make.bottom.equalTo(layoutMarginsGuide).inset(Constants.Spacing.medium)
        }
    }
    private func configureGestures() {
        
    }
}

