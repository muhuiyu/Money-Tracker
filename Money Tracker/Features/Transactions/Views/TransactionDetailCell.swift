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
    
    private let titleLabel = UILabel()
    private let valueStack = UIStackView()
    private let iconView = UIImageView()
    private let valueLabel = UILabel()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var valueIcon: UIImage? {
        didSet {
            iconView.image = valueIcon
        }
    }
    var value: String? {
        didSet {
            valueLabel.text = value
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
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        titleLabel.font = UIFont.body
        titleLabel.text = "default"
        contentView.addSubview(titleLabel)
        
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = UIColor.Brand.primary
        valueStack.addArrangedSubview(iconView)
        
        valueLabel.isUserInteractionEnabled = true
        valueLabel.textColor = UIColor.Brand.primary
        valueLabel.textAlignment = .right
        valueLabel.font = UIFont.bodyHeavy
        valueLabel.text = "default"
        valueStack.addArrangedSubview(valueLabel)
        
        valueStack.axis = .horizontal
        valueStack.alignment = .center
        valueStack.spacing = Constants.Spacing.small
        contentView.addSubview(valueStack)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.leading.bottom.equalTo(contentView.layoutMarginsGuide)
        }
        iconView.snp.remakeConstraints { make in
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
