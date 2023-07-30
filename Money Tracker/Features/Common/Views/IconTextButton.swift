//
//  IconTextButton.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit

class IconTextButton: UIView {

    private let stackView = UIStackView()
    private let iconView = UIImageView()
    private let textLabel = UILabel()
    
    var icon: UIImage? {
        didSet {
            iconView.image = icon
        }
    }
    var text: String? {
        didSet {
            textLabel.text = text
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
}
// MARK: - Actions
extension IconTextButton {
    @objc
    private func didTapInView() {
        tapHandler?()
    }
}

// MARK: - View Config
extension IconTextButton {
    private func configureViews() {
        iconView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(iconView)
        
        textLabel.font = UIFont.smallBold
        textLabel.textColor = .label
        textLabel.textAlignment = .center
        stackView.addArrangedSubview(textLabel)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.Spacing.slight
        addSubview(stackView)
    }
    private func configureConstraints() {
        iconView.snp.remakeConstraints { make in
            make.size.equalTo(Constants.IconButtonSize.medium)
        }
        stackView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        addGestureRecognizer(tapRecognizer)
    }
}

