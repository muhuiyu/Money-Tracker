//
//  UnderlinedTextField.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit

class UnderlinedTextField: UITextField {
    
    private let underlineLayer = CALayer()
    
    private func setupUnderlineLayer() {
        var frame = self.bounds
        frame.origin.y = frame.size.height - 1
        frame.size.height = 1

        underlineLayer.frame = frame
        underlineLayer.backgroundColor = UIColor.quaternaryLabel.cgColor
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.layer.addSublayer(underlineLayer)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.addSublayer(underlineLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUnderlineLayer()
    }
}
