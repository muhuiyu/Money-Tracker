//
//  TitleValueCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/9/22.
//

import UIKit
import RxSwift

/// UITableViewCell with title and value
open class TitleValueCell: UITableViewCell, BaseCell {
    static var reuseID: String = NSStringFromClass(TitleValueCell.self)
    internal let disposeBag = DisposeBag()
    
    internal let titleLabel = UILabel()
    internal let valueLabel = UILabel()
    
    var tapHandler: (() -> Void)? {
        didSet {
            if let _ = tapHandler {
                valueLabel.textColor = UIColor.Brand.primary
                valueLabel.font = UIFont.bodyHeavy
                valueLabel.isUserInteractionEnabled = true
            }
        }
    }
    
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
        titleLabel.textColor = .label
        titleLabel.font = UIFont.body
        titleLabel.text = "default"
        titleLabel.textAlignment = .left
        contentView.addSubview(titleLabel)

        valueLabel.textColor = .label
        valueLabel.font = UIFont.body
        valueLabel.text = "default"
        valueLabel.textAlignment = .right
        contentView.addSubview(valueLabel)
    }
    internal func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.top.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.trivial)
        }
        valueLabel.snp.remakeConstraints { make in
            make.top.bottom.centerY.equalTo(titleLabel)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(titleLabel.snp.trailing)
        }
    }
    internal func configureGestures() {
        
    }
    internal func configureBindings() {
        
    }
}

