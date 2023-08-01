//
//  TransactionListHeaderView.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit

class TransactionListHeaderView: UIView {
    
    private let titleLabel = UILabel()
    private let moreButtonLabel = UILabel()
    
    var tapHandler: (() -> Void)?
    
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
extension TransactionListHeaderView {
    private func configureViews() {
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.h2
        titleLabel.text = Localized.TransactionList.recentTransactions
        addSubview(titleLabel)
        
        moreButtonLabel.textColor = UIColor.Brand.primary
        moreButtonLabel.textAlignment = .right
        moreButtonLabel.font = .bodyBold
        moreButtonLabel.text = Localized.TransactionList.seeAll
        moreButtonLabel.isUserInteractionEnabled = true
        addSubview(moreButtonLabel)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalToSuperview()
            make.top.bottom.equalTo(layoutMarginsGuide)
        }
        moreButtonLabel.snp.remakeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing)
            make.top.bottom.equalTo(titleLabel)
            make.trailing.equalToSuperview()
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        moreButtonLabel.addGestureRecognizer(tapRecognizer)
    }
}
// MARK: - Actions
extension TransactionListHeaderView {
    @objc
    private func didTapInView() {
        self.tapHandler?()
    }
}
