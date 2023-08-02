//
//  TransactionDetailCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import Foundation

import UIKit

class TransactionDetailCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionDetailCell.self)
    
    private let iconView = UIImageView()
    
    private let titleLabel = UILabel()
    private let valueStack = UIStackView()
    private let valueIconView = UIImageView()
    private let valueLabel = UILabel()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var valueIconColor: UIColor? {
        didSet {
            valueIconView.backgroundColor = valueIconColor?.withAlphaComponent(0.2)
            valueIconView.tintColor = valueIconColor
        }
    }
    var valueIcon: UIImage? {
        didSet {
            valueIconView.image = valueIcon
        }
    }
    var value: String? {
        didSet {
            valueLabel.text = value
        }
    }
    var icon: UIImage? {
        didSet {
            iconView.image = icon
        }
    }

    var tapHandler: (() -> Void)?
    
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
// MARK: - Actions
extension TransactionDetailCell {
    @objc
    private func didTapValue() {
        self.tapHandler?()
    }
}
// MARK: - View Config
extension TransactionDetailCell {
    private func configureViews() {
        iconView.tintColor = .label
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        titleLabel.font = UIFont.body
        titleLabel.text = "default"
        contentView.addSubview(titleLabel)
        
        valueIconView.layer.cornerRadius = 8
        valueIconView.contentMode = .scaleAspectFit
        valueIconView.tintColor = .label
        valueStack.addArrangedSubview(valueIconView)
        
        valueLabel.isUserInteractionEnabled = true
        valueLabel.textColor = .label
        valueLabel.textAlignment = .right
        valueLabel.font = .bodyBold
        valueLabel.text = "default"
        valueStack.addArrangedSubview(valueLabel)
        
        let nextIcon = UIImageView(image: UIImage(systemName: Icons.chevronForward))
        nextIcon.contentMode = .scaleAspectFit
        nextIcon.tintColor = .secondaryLabel
        nextIcon.snp.remakeConstraints { make in
            make.size.equalTo(16)
        }
        valueStack.addArrangedSubview(nextIcon)
        
        valueStack.axis = .horizontal
        valueStack.alignment = .center
        valueStack.spacing = Constants.Spacing.small
        contentView.addSubview(valueStack)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.Spacing.small)
            make.centerY.equalToSuperview()
        }
        iconView.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.size.equalTo(Constants.IconButtonSize.trivial)
        }
        valueIconView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.IconButtonSize.trivial)
        }
        valueStack.snp.remakeConstraints { make in
            make.top.bottom.equalTo(titleLabel)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(titleLabel.snp.trailing).offset(Constants.Spacing.small)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapValue))
        valueLabel.addGestureRecognizer(tapRecognizer)
    }
    private func configureBindings() {
        
    }
}
