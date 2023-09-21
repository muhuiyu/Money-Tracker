//
//  AppNavigationBar.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class AppNavigationBar: UIView {

    enum ContentType {
        case wallets
        case title(String)
    }
    
    // MARK: - Views
    private let leftStackView = UIStackView()
    private let walletButton = WalletButton()
    private let titleLabel = UILabel()
    private let searchButton = IconButton(icon: UIImage(systemName: Icons.magnifyingglass))
    
    private let contentType: ContentType
    
    var tapWalletsHandler: (() -> Void)? {
        didSet {
            walletButton.tapHandler = tapWalletsHandler
        }
    }
    
    var tapSearchHandler: (() -> Void)? {
        didSet {
            searchButton.tapHandler = tapSearchHandler
        }
    }
    
    init(contentType: ContentType) {
        self.contentType = contentType
        super.init(frame: .zero)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        switch contentType {
        case .wallets:
            walletButton.walletName = "All Wallets"
            leftStackView.addArrangedSubview(walletButton)
        case .title(let title):
            titleLabel.font = .h3
            titleLabel.text = title
            titleLabel.textAlignment = .left
            titleLabel.textColor = .label
            leftStackView.addArrangedSubview(titleLabel)
        }
        
        leftStackView.axis = .vertical
        addSubview(leftStackView)
        searchButton.tintColor = .label
        addSubview(searchButton)
    }
    
    private func configureConstraints() {
        leftStackView.snp.remakeConstraints { make in
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
        configureGestures()
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
