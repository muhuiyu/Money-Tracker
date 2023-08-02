//
//  TransactionDateCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/30/22.
//

import Foundation
import UIKit

class TransactionDateCell: UITableViewCell {
    static let reuseID = NSStringFromClass(TransactionDateCell.self)
    
    private let iconView = UIImageView(image: UIImage(systemName: Icons.calender))
    private let titleLabel = UILabel()
    private let valueStack = UIStackView()
    private let datePicker = UIDatePicker()
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var date: YearMonthDay {
        get {
            return YearMonthDay(year: datePicker.date.year,
                                month: datePicker.date.month,
                                day: datePicker.date.dayOfMonth)
        }
        set {
            datePicker.date = newValue.toDate ?? Date()
        }
    }
    var endEditingHandler: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.date = YearMonthDay.today
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - Selectors
extension TransactionDateCell {
    @objc
    private func didChangeValue(_ sender: UIDatePicker) {
        self.endEditingHandler?()
    }
}
// MARK: - View Config
extension TransactionDateCell {
    private func configureViews() {
        iconView.tintColor = .label
        contentView.addSubview(iconView)
        
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        titleLabel.font = UIFont.body
        contentView.addSubview(titleLabel)
        
        datePicker.date = date.toDate ?? Date()
        datePicker.datePickerMode = .date
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(didChangeValue(_:)), for: .editingDidEnd)
        contentView.addSubview(datePicker)
    }
    private func configureConstraints() {
        iconView.snp.remakeConstraints { make in
            make.leading.equalTo(contentView.layoutMarginsGuide)
            make.size.equalTo(Constants.IconButtonSize.trivial)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(iconView.snp.trailing).offset(Constants.Spacing.small)
            make.centerY.equalToSuperview()
        }
        datePicker.snp.remakeConstraints { make in
            make.top.bottom.equalTo(contentView.layoutMarginsGuide)
            make.trailing.equalTo(contentView.layoutMarginsGuide)
            make.leading.equalTo(titleLabel.snp.trailing).offset(Constants.Spacing.small)
        }
    }
    private func configureGestures() {
        
    }
    private func configureBindings() {
        
    }
}
