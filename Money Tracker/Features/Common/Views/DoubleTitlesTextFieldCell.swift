//
//  DoubleTitlesTextFieldCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/9/22.
//

import UIKit
import RxSwift

/// UITableViewCell with title, subtitle, textField and optional icon
open class DoubleTitlesTextFieldCell: UITableViewCell, BaseCell {
    static var reuseID: String = NSStringFromClass(DoubleTitlesTextFieldCell.self)
    
    internal let disposeBag = DisposeBag()
    
    internal let iconView = UIImageView()
    internal let stackView = UIStackView()
    internal let titleLabel = UILabel()
    internal let subtitleLabel = UILabel()
    internal let amountStackView = UIStackView()
    internal let dollarSignLabel = UILabel()
    internal let textField = UnderlinedTextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func configureViews() {
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        titleLabel.textAlignment = .left
        titleLabel.font = .bodyBold
        titleLabel.textColor = .label
        stackView.addArrangedSubview(titleLabel)
        
        subtitleLabel.textAlignment = .left
        subtitleLabel.font = UIFont.small
        subtitleLabel.textColor = .secondaryLabel
        stackView.addArrangedSubview(subtitleLabel)
        
        stackView.spacing = Constants.Spacing.trivial
        stackView.alignment = .leading
        stackView.axis = .vertical
        contentView.addSubview(stackView)
        
        dollarSignLabel.text = "$"
        dollarSignLabel.textAlignment = .right
        dollarSignLabel.textColor = .label
        dollarSignLabel.font = UIFont.body
        amountStackView.addArrangedSubview(dollarSignLabel)
        
        textField.textAlignment = .right
        textField.textColor = .label
        textField.font = UIFont.body
        textField.keyboardType = .decimalPad
        amountStackView.addArrangedSubview(textField)
        
        amountStackView.alignment = .center
        amountStackView.spacing = 0
        amountStackView.axis = .horizontal
        contentView.addSubview(amountStackView)
    }
    internal func configureConstraints() {
        iconView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.IconButtonSize.small)
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
        }
        stackView.snp.remakeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.Spacing.medium)
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
        }
        amountStackView.snp.remakeConstraints { make in
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.leading.equalTo(stackView.snp.trailing)
        }
        textField.snp.remakeConstraints { make in
            make.width.greaterThanOrEqualTo(100)
        }
    }
    internal func configureGestures() {
        
    }
    internal func configureBindings() {
        
    }
}

