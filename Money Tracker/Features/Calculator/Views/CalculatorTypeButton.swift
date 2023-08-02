//
//  CalculatorTypeButton.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class CalculatorTypeButton: UIView {
    var tapHandler: (() -> Void)?
    
    private let label = UILabel()
    
    var type: TransactionType? {
        didSet {
            if let type = type {
                label.text = type.name
                label.textColor = type.color
            }
        }
    }
    
    init(width: Double) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        label.font = .h3
        label.textAlignment = .center
        addSubview(label)
        label.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(Constants.Spacing.trivial)
            make.leading.trailing.lessThanOrEqualToSuperview()
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
