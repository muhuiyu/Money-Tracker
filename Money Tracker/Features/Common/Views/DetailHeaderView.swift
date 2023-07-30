//
//  DetailHeaderView.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit

class DetailHeaderView: UIView {
    
    private let headerStack = UIStackView()
    private let titleLabel = UILabel()
    private let firstSubtitleLabel = UILabel()
    private let secondSubtitleLabel = UILabel()

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var firstSubtitle: String? {
        didSet {
            firstSubtitleLabel.text = firstSubtitle
        }
    }
    var secondSubtitle: String? {
        didSet {
            secondSubtitleLabel.text = secondSubtitle
        }
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
        configureGestures()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - View Config
extension DetailHeaderView {
    private func configureViews() {
        titleLabel.font = UIFont.h1
        titleLabel.textColor = .label
        headerStack.addArrangedSubview(titleLabel)
        firstSubtitleLabel.font = UIFont.small
        firstSubtitleLabel.textColor = .secondaryLabel
        headerStack.addArrangedSubview(firstSubtitleLabel)
        secondSubtitleLabel.font = UIFont.small
        secondSubtitleLabel.textColor = .secondaryLabel
        headerStack.addArrangedSubview(secondSubtitleLabel)
        
        headerStack.axis = .vertical
        headerStack.spacing = Constants.Spacing.small
        headerStack.alignment = .leading
        addSubview(headerStack)
    }
    private func configureConstraints() {
        headerStack.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configureGestures() {
        
    }
}

