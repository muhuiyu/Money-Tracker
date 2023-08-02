//
//  CalculatorCurrencyButton.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class CalculatorCurrencyButton: UIView {
    var tapHandler: (() -> Void)?
    
    let label = UILabel()
    let iconView = UIImageView(image: UIImage(systemName: Icons.chevronDown))
    
    var currency: String? {
        didSet {
            label.text = currency
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
        configureGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Config
extension CalculatorCurrencyButton {
    private func configureViews() {
        label.font = .small
        label.textColor = .secondaryLabel
        label.text = "SGD"
        addSubview(label)
        
        iconView.tintColor = .secondaryLabel
        iconView.contentMode = .scaleAspectFit
        addSubview(iconView)
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.withAlphaComponent(0.3).cgColor
    }
    private func configureConstraints() {
        label.snp.remakeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.bottom.leading.equalToSuperview().inset(Constants.Spacing.small)
        }
        iconView.snp.remakeConstraints { make in
            make.size.equalTo(16)
            make.centerY.equalToSuperview()
            make.leading.equalTo(label.snp.trailing).offset(Constants.Spacing.small)
            make.trailing.equalToSuperview().inset(Constants.Spacing.small)
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        addGestureRecognizer(tapRecognizer)
    }
    @objc
    private func didTapInView() {
        tapHandler?()
    }
}

