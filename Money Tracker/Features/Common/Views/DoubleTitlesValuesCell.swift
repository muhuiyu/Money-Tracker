//
//  DoubleTitlesValuesCell.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/8/22.
//

import UIKit
import RxSwift

/// UITableViewCell with title, subtitle, value, subvalue and optional icon
open class DoubleTitlesValuesCell: UITableViewCell, BaseCell {
    static var reuseID: String = NSStringFromClass(DoubleTitlesValuesCell.self)
    
    internal let disposeBag = DisposeBag()
    
    internal let iconView = UIImageView()
    internal let titleStack = UIStackView()
    internal let titleLabel = UILabel()
    internal let subtitleLabel = UILabel()
    internal let valueStack = UIStackView()
    internal let valueLabel = UILabel()
    internal let subvalueLabel = UILabel()
    
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

        titleLabel.textColor = .label
        titleLabel.font = .bodyBold
        titleLabel.text = "default"
        titleStack.addArrangedSubview(titleLabel)

        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.font = UIFont.small
        subtitleLabel.text = "default"
        titleStack.addArrangedSubview(subtitleLabel)

        titleStack.alignment = .leading
        titleStack.axis = .vertical
        titleStack.spacing = Constants.Spacing.trivial
        contentView.addSubview(titleStack)

        valueLabel.textColor = .label
        valueLabel.font = UIFont.body
        valueLabel.text = "default"
        valueStack.addArrangedSubview(valueLabel)
        
        subvalueLabel.textColor = .secondaryLabel
        subvalueLabel.font = UIFont.small
        subvalueLabel.text = "default"
        valueStack.addArrangedSubview(subvalueLabel)
        
        valueStack.alignment = .trailing
        valueStack.axis = .vertical
        valueStack.spacing = Constants.Spacing.trivial
        contentView.addSubview(valueStack)
    }
    internal func configureConstraints() {
        iconView.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.size.equalTo(Constants.IconButtonSize.small)
        }
        titleStack.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.Spacing.medium)
        }
        valueStack.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(titleStack.snp.trailing)
        }
//        detailStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    internal func configureGestures() {
        
    }
    internal func configureBindings() {
        
    }
}
