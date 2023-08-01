//
//  TransactionAmountCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit

class TransactionAmountCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionAmountCell.self)
    
    private let symbolLabel = UILabel()
    private let textField = UITextField()
    
    var currencyCode: String? {
        didSet {
            symbolLabel.text =  "\(currencyCode ?? "") $"
        }
    }
    
    var type: TransactionType? {
        didSet {
            if let type = type {
                switch type {
                case .income:
                    symbolLabel.textColor = .systemGreen
                    textField.textColor = .systemGreen
                case .expense:
                    symbolLabel.textColor = .systemRed
                    textField.textColor = .systemRed
                case .transfer:
                    symbolLabel.textColor = .systemGray
                    textField.textColor = .systemGray
                }
            }
        }
    }
    
    var value: Double {
        get { return Double(textField.text ?? "") ?? 0 }
        set { textField.text = newValue.toStringTwoDigits() }
    }
    
    var didChangeValueHandler: (() -> Void)?
    var didTapInCellHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Handlers
extension TransactionAmountCell {
    @objc
    private func didChangeValue(_ sender: UITextField) {
        if
            let text = sender.text,
            !text.isEmpty,
            text.last != ".",
            let _ = Double(text) {
            self.didChangeValueHandler?()
        }
    }
}
// MARK: - View Config
extension TransactionAmountCell {
    private func configureViews() {
        symbolLabel.font = UIFont.h2
        symbolLabel.text = "$"
        contentView.addSubview(symbolLabel)
        
        textField.font = UIFont.h2
        textField.textAlignment = .left
        textField.placeholder = "Enter amount"
        textField.returnKeyType = .done
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(didChangeValue(_ :)), for: .editingChanged)
        textField.delegate = self
        contentView.addSubview(textField)
    }
    private func configureConstraints() {
        symbolLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.top.bottom.equalTo(textField)
        }
        textField.snp.remakeConstraints { make in
            make.leading.equalTo(symbolLabel.snp.trailing).offset(Constants.Spacing.trivial)
            make.top.bottom.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.small)
        }
    }
}
extension TransactionAmountCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.didTapInCellHandler?()
        return true
    }
}
