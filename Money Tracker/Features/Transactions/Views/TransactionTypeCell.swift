//
//  TransactionTypeCell.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class TransactionTypeCell: UITableViewCell, BaseCell {
    static let reuseID = NSStringFromClass(TransactionTypeCell.self)
    private let segments: [TransactionType] = [
        TransactionType.income, TransactionType.expense, TransactionType.transfer,
    ]
    private lazy var segmentControl = UISegmentedControl(items: self.segments.map({ $0.name }))

    var type: TransactionType? {
        didSet {
            if let type = type {
                segmentControl.selectedSegmentIndex = type.index
            }
        }
    }
    var didChangeValueHandler: ((TransactionType) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - View Config
extension TransactionTypeCell {
    private func configureViews() {
        segmentControl.addTarget(self, action: #selector(didChangeSegmentIndex(_:)), for: .editingChanged)
        contentView.addSubview(segmentControl)
    }
    private func configureConstraints() {
        segmentControl.snp.remakeConstraints { make in
            make.top.equalTo(contentView.layoutMarginsGuide)
            make.leading.trailing.equalTo(contentView)
            make.centerX.equalToSuperview()
        }
    }
    @objc
    private func didChangeSegmentIndex(_ sender: UISegmentedControl) {
        didChangeValueHandler?(segments[sender.selectedSegmentIndex])
    }
}
