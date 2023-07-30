//
//  InfoTextButton.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class InfoTextButton: UIView {
    
    private let textLabel = UILabel()
    
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
        configureSignals()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - Actions
extension InfoTextButton {
    @objc
    private func didTapInView() {
        self.tapHandler?()
    }
}
// MARK: - View Config
extension InfoTextButton {
    private func configureViews() {
        textLabel.textAlignment = .center
        textLabel.text = "default"
        textLabel.font = UIFont.smallBold
        textLabel.textColor = UIColor.orange
        addSubview(textLabel)
    }
    private func configureConstraints() {
        textLabel.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configureGestures() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        addGestureRecognizer(tapRecognizer)
    }
    private func configureSignals() {
        
    }
}

