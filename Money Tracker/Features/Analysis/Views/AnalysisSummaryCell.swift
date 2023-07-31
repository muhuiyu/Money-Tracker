//
//  AnalysisSummaryCell.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import UIKit

class AnalysisSummaryCell: UICollectionViewCell {
    static let reuseID = NSStringFromClass(AnalysisSummaryCell.self)
    
    private let containerView = UIView()
    private let monthSummaryLabel = UILabel()
    
    var viewModel = AnalysisSummaryCellViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
// MARK: - View Config
extension AnalysisSummaryCell {
    private func configureViews() {
        containerView.layer.cornerRadius = 20
        containerView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(containerView)
        
        monthSummaryLabel.text = "Default"
        monthSummaryLabel.textColor = .label
        monthSummaryLabel.font = UIFont.h3
        monthSummaryLabel.textAlignment = .left
        contentView.addSubview(monthSummaryLabel)
    }
    private func configureConstraints() {
        monthSummaryLabel.snp.remakeConstraints { make in
            make.top.leading.equalTo(contentView.layoutMarginsGuide).inset(Constants.Spacing.small)
        }
        containerView.snp.remakeConstraints { make in
            make.height.equalTo(170)
            make.edges.equalToSuperview()
        }
    }
    private func configureGestures() {
        
    }
    private func configureBindings() {
        
    }
}
