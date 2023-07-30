//
//  TitleSubtitleAmountCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/10/22.
//

import UIKit
import RxSwift

open class TitleSubtitleAmountCell: UITableViewCell {
    internal let iconView = UIImageView()
    internal let detailStack = UIStackView()
    internal let titleLabel = UILabel()
    internal let subtitleLabel = UILabel()
    internal let signedAmountLabel = UILabel()
    
    internal let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    internal func configureViews() {
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont.bodyHeavy
        titleLabel.text = "default"
        detailStack.addArrangedSubview(titleLabel)
        
        subtitleLabel.textColor = UIColor.secondaryLabel
        subtitleLabel.font = UIFont.small
        subtitleLabel.text = "default"
        detailStack.addArrangedSubview(subtitleLabel)
                
        detailStack.alignment = .leading
        detailStack.axis = .vertical
        detailStack.spacing = Constants.Spacing.trivial
        contentView.addSubview(detailStack)
        
        signedAmountLabel.textColor = UIColor.Brand.primary
        signedAmountLabel.font = UIFont.h3
        signedAmountLabel.text = "default"
        contentView.addSubview(signedAmountLabel)
    }
    internal func configureConstraints() {
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
    internal func configureGestures() {
        
    }
    internal func configureSignals() {

    }
}
