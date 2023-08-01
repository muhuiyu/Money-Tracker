//
//  BudgetStatusCell.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/8/22.
//

import UIKit

class BudgetStatusCell: UITableViewCell {
    static let reuseID = NSStringFromClass(BudgetStatusCell.self)
    
    private let titleLabel = UILabel()
    private let iconView = UIImageView()
    private let detailLabel = UILabel()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var detail: String? {
        didSet {
            detailLabel.text = detail
        }
    }
    var icon: UIImage? {
        didSet {
            iconView.image = icon
        }
    }
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
// MARK: - TapHandlers
extension BudgetStatusCell {
    
}
// MARK: - View Config
extension BudgetStatusCell {
    private func configureViews() {
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.font = .bodyBold
        titleLabel.text = "default"
        contentView.addSubview(titleLabel)
        
        iconView.contentMode = .scaleAspectFit
        contentView.addSubview(iconView)
        
        detailLabel.textColor = .secondaryLabel
        detailLabel.textAlignment = .left
        detailLabel.numberOfLines = 0
        detailLabel.font = UIFont.small
        detailLabel.text = "default"
        contentView.addSubview(detailLabel)
    }
    private func configureConstraints() {
        detailLabel.snp.remakeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func configureGestures() {
        
    }
    private func configureBindings() {
        
    }
}

