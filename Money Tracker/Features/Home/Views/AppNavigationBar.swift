//
//  AppNavigationBar.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class AppNavigationBar: UIView {
    
    private let walletButton = WalletButton()
    private let searchButton = IconButton(icon: UIImage(systemName: Icons.magnifyingglass))
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        walletButton.walletName = "All Wallets"
        addSubview(walletButton)
        searchButton.tintColor = .label
        addSubview(searchButton)
    }
    
    private func configureConstraints() {
        walletButton.snp.remakeConstraints { make in
            make.top.bottom.equalTo(layoutMarginsGuide)
            make.leading.equalToSuperview().inset(Constants.Spacing.medium)
            make.centerY.equalToSuperview()
        }
        searchButton.snp.remakeConstraints { make in
            make.top.bottom.equalTo(layoutMarginsGuide)
            make.trailing.equalToSuperview().inset(Constants.Spacing.medium)
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }
    }
}


// MARK: - WalletButton
class WalletButton: UIView {
    
    private let globeIcon = UIImageView(image: UIImage(systemName: Icons.globe))
    private let textLabel = UILabel()
    private let downIcon = UIImageView(image: UIImage(systemName: Icons.chevronDown))
    
    var walletName: String? {
        didSet {
            textLabel.text = walletName
        }
    }
    var tapHandler: (() -> Void)?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        globeIcon.contentMode = .scaleAspectFit
        globeIcon.tintColor = .label
        addSubview(globeIcon)
        textLabel.text = "Default"
        textLabel.font = .bodyBold
        addSubview(textLabel)
        downIcon.contentMode = .scaleAspectFit
        downIcon.tintColor = .label
        addSubview(downIcon)
    }
    
    private func configureConstraints() {
        globeIcon.snp.remakeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.size.equalTo(24)
        }
        textLabel.snp.remakeConstraints { make in
            make.leading.equalTo(globeIcon.snp.trailing).offset(Constants.Spacing.small)
            make.trailing.equalTo(downIcon.snp.leading).offset(-Constants.Spacing.small)
            make.centerY.equalToSuperview()
        }
        downIcon.snp.remakeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(12)
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
