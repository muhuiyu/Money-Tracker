//
//  TransactionToggleCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/31/22.
//
import UIKit

class TransactionToggleCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionToggleCell.self)
    
    private let titleLabel = UILabel()
    private let toggleView = UISwitch()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var value: Bool {
        get { return toggleView.isOn }
        set { toggleView.isOn = newValue }
    }
    var didChangeValueHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Actions
extension TransactionToggleCell {
    @objc
    private func didChangeValue(_ sender: UISwitch) {
        self.didChangeValueHandler?()
    }
}
// MARK: - View Config
extension TransactionToggleCell {
    private func configureViews() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        titleLabel.font = UIFont.body
        titleLabel.text = "default"
        contentView.addSubview(titleLabel)
        
        toggleView.addTarget(self, action: #selector(didChangeValue(_ :)), for: .valueChanged)
        toggleView.preferredStyle = .sliding
        contentView.addSubview(toggleView)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.leading.bottom.equalTo(contentView.layoutMarginsGuide)
        }
        toggleView.snp.remakeConstraints { make in
            make.top.bottom.equalTo(titleLabel)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(titleLabel.snp.trailing).offset(Constants.Spacing.small)
        }
    }
}
