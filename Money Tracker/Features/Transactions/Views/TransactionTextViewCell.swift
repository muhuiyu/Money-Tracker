//
//  TransactionTextViewCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/2/22.
//

import UIKit

class TransactionTextViewCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionTextViewCell.self)
    
    private let placeholderLabel = UILabel()
    private let textView = UITextView()
    var value: String? {
        get { return textView.text }
        set {
            textView.text = newValue
            placeholderLabel.isHidden = textView.hasText
        }
    }
    var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    var didChangeValueHandler: (() -> Void)?
    var didTapInCellHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
        configureSignals()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Handlers
extension TransactionTextViewCell {

}
// MARK: - View Config
extension TransactionTextViewCell {
    private func configureViews() {
        placeholderLabel.textColor = .tertiaryLabel
        placeholderLabel.textAlignment = .left
        placeholderLabel.font = UIFont.body
        placeholderLabel.isHidden = false
        contentView.addSubview(placeholderLabel)
        
        textView.backgroundColor = .clear
        textView.textColor = UIColor.label
        textView.textAlignment = .left
        textView.font = UIFont.body
        textView.isUserInteractionEnabled = true
        textView.isEditable = true
        textView.delegate = self
        contentView.addSubview(textView)
    }
    private func configureConstraints() {
        textView.snp.remakeConstraints { make in
            make.height.equalTo(100)
            make.top.trailing.bottom.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(contentView.layoutMarginsGuide)
        }
        placeholderLabel.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.top.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.small)
        }
    }
    private func configureSignals() {
        
    }
}
extension TransactionTextViewCell: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.didTapInCellHandler?()
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
        self.didChangeValueHandler?()
    }
}
