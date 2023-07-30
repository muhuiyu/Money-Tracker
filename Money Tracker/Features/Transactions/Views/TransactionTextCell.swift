//
//  TransactionTextCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import UIKit

class TransactionTextCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionTextCell.self)
    
    private let valueLabel = UILabel()
    
    var value: String? {
        didSet {
            valueLabel.text = value
        }
    }
    var numberOfLines: Int = 1 {
        didSet {
            valueLabel.numberOfLines = numberOfLines
        }
    }

    var tapHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Actions
extension TransactionTextCell {
    @objc
    private func didTapValue() {
        self.tapHandler?()
    }
}
// MARK: - View Config
extension TransactionTextCell {
    private func configureViews() {
        valueLabel.textColor = .label
        valueLabel.textAlignment = .left
        valueLabel.numberOfLines = 0
        valueLabel.font = UIFont.body
        valueLabel.text = "default"
        contentView.addSubview(valueLabel)
    }
    private func configureConstraints() {
        valueLabel.snp.remakeConstraints { make in
            make.top.leading.bottom.trailing.equalTo(contentView.layoutMarginsGuide)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapValue))
        valueLabel.addGestureRecognizer(tapRecognizer)
    }
    private func configureSignals() {
        
    }
}
