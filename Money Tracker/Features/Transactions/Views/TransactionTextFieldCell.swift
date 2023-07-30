//
//  TransactionTextFieldCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/10/22.
//

import UIKit

class TransactionTextFieldCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionTextFieldCell.self)
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    
    var title: String? {
        get { return titleLabel.text }
        set { titleLabel.text = newValue }
    }
    var value: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    var endEditingHandler: (() -> Void)?
    
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
// MARK: - View Config
extension TransactionTextFieldCell {
    private func configureViews() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        titleLabel.font = UIFont.body
        titleLabel.text = "default"
        contentView.addSubview(titleLabel)
        
        textField.textColor = UIColor.label
        textField.textAlignment = .right
        textField.font = UIFont.body
        textField.placeholder = "someplaceholder"
        textField.delegate = self
        contentView.addSubview(textField)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.top.leading.bottom.equalTo(contentView.layoutMarginsGuide)
        }
        textField.snp.remakeConstraints { make in
            make.top.bottom.equalTo(titleLabel)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(titleLabel.snp.trailing).offset(Constants.Spacing.small)
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}
extension TransactionTextFieldCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.endEditingHandler?()
    }
}
