//
//  TransactionAmountCell.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class TransactionAmountCell: UITableViewCell, BaseCell {
    static let reuseID = NSStringFromClass(TransactionAmountCell.self)
    
    private let symbolLabel = UILabel()
    private let valueLabel = UILabel()
    
    var currencyCode: String? {
        didSet {
            symbolLabel.text =  "\(currencyCode ?? "") $"
        }
    }
    
    var type: TransactionType? {
        didSet {
            if let type = type {
                symbolLabel.textColor = type.color
                valueLabel.textColor = type.color
            }
        }
    }
    
    var value: Double {
        get { return Double(valueLabel.text ?? "") ?? 0 }
        set { valueLabel.text = newValue.toStringTwoDigits() }
    }
    
    var didTapInCellHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureGestures()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - View Config
extension TransactionAmountCell {
    private func configureViews() {
        symbolLabel.font = UIFont.h2
        symbolLabel.text = "$"
        contentView.addSubview(symbolLabel)
        valueLabel.font = UIFont.h2
        valueLabel.textAlignment = .left
        contentView.addSubview(valueLabel)
    }
    private func configureConstraints() {
        symbolLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.top.bottom.equalTo(valueLabel)
        }
        valueLabel.snp.remakeConstraints { make in
            make.leading.equalTo(symbolLabel.snp.trailing).offset(Constants.Spacing.trivial)
            make.top.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.small)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        addGestureRecognizer(tapRecognizer)
    }
    @objc
    private func didTapInView() {
        didTapInCellHandler?()
    }
}
