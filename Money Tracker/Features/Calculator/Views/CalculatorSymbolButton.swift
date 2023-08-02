//
//  CalculatorSymbolButton.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class CalculatorSymbolButton: UIView {
    var tapHandler: (() -> Void)?
    
    private let value: String?
    private let width: Double?
    
    init(value: String?, iconName: String?, backgroundColor: UIColor? = nil, width: Double) {
        self.value = value
        self.width = width
        super.init(frame: .zero)
        
        self.backgroundColor = .white
        
        if let iconName = iconName {
            let icon = UIImageView(image: UIImage(systemName: iconName))
            if let backgroundColor = backgroundColor {
                icon.tintColor = .white
                self.backgroundColor = backgroundColor
            } else {
                icon.tintColor = .label
            }
            icon.contentMode = .scaleAspectFit
            addSubview(icon)
            icon.snp.remakeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalTo(Constants.IconButtonSize.small)
                make.top.bottom.equalToSuperview().inset(Constants.Spacing.small)
                make.leading.trailing.lessThanOrEqualToSuperview()
            }
        } else if let value = value {
            let label = UILabel()
            label.font = .h2Regular
            label.text = value
            label.textAlignment = .center
            addSubview(label)
            label.snp.remakeConstraints { make in
                make.center.equalToSuperview()
                make.top.bottom.equalToSuperview().inset(Constants.Spacing.trivial)
                make.leading.trailing.lessThanOrEqualToSuperview()
            }
        }
        
        snp.remakeConstraints { make in
            make.width.equalTo(width)
        }
        layer.cornerRadius = 8
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        addGestureRecognizer(tapRecognizer)
    }
    
    @objc
    private func didTapInView() {
        tapHandler?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
