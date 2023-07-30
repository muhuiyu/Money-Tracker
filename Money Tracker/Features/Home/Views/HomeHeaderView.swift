//
//  HomeHeaderView.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit

class HomeHeaderView: UIView {
    
    private let balanceStackView = UIStackView()
    private let titleLabel = UILabel()
    private let amountLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let buttonStackView = UIStackView()
    private let addTransactionButton = IconTextButton()
    private let pocketButton = IconTextButton()
    
    var amountString: String? {
        didSet {
            amountLabel.text = amountString
        }
    }
    var subtitleString: String? {
        didSet {
            subtitleLabel.text = subtitleString
        }
    }
    var addTransactionTapHandler: (() -> Void)? {
        didSet {
            addTransactionButton.tapHandler = addTransactionTapHandler
        }
    }
    var pocketTaphandler: (() -> Void)? {
        didSet {
            pocketButton.tapHandler = pocketTaphandler
        }
    }
    var analysisViewTapHandler: (() -> Void)?
    
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
// MARK: - Handlers
extension HomeHeaderView {
    @objc
    private func didTapInBalanceView(_ sender: UITapGestureRecognizer) {
        self.analysisViewTapHandler?()
    }
}
// MARK: - View Config
extension HomeHeaderView {
    private func configureViews() {
        titleLabel.text = "default"
        titleLabel.text = Localized.Home.balanceTitle
        titleLabel.font = UIFont.smallBold
        titleLabel.textColor = UIColor.Brand.primary
        titleLabel.textAlignment = .left
        balanceStackView.addArrangedSubview(titleLabel)
        
        amountLabel.text = "default"
        amountLabel.font = UIFont.h3
        amountLabel.textColor = .label
        amountLabel.textAlignment = .left
        balanceStackView.addArrangedSubview(amountLabel)
        
        subtitleLabel.text = "default"
        subtitleLabel.font = UIFont.smallBold
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.textAlignment = .left
        balanceStackView.addArrangedSubview(subtitleLabel)
        
        balanceStackView.spacing = Constants.Spacing.trivial
        balanceStackView.alignment = .leading
        balanceStackView.axis = .vertical
        addSubview(balanceStackView)
        
        addTransactionButton.text = Localized.Home.addTransaction
        addTransactionButton.icon = UIImage(systemName: Icons.plusCircle)
        buttonStackView.addArrangedSubview(addTransactionButton)
        
        pocketButton.text = Localized.Home.pocket
        pocketButton.icon = UIImage(systemName: Icons.calenderBadgeClock)
        buttonStackView.addArrangedSubview(pocketButton)
        
        buttonStackView.spacing = Constants.Spacing.trivial
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        addSubview(buttonStackView)
        
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 8
    }
    private func configureConstraints() {
        balanceStackView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(layoutMarginsGuide).inset(Constants.Spacing.small)
            make.leading.equalTo(layoutMarginsGuide).inset(Constants.Spacing.medium)
            make.trailing.equalTo(buttonStackView.snp.leading).offset(Constants.Spacing.small)
        }
        buttonStackView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(layoutMarginsGuide).inset(Constants.Spacing.medium)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInBalanceView(_:)))
        balanceStackView.addGestureRecognizer(tapRecognizer)
    }
}

