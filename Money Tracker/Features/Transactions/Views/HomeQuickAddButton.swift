//
//  HomeQuickAddButton.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/2/23.
//

import UIKit

class HomeQuickAddButton: UIView {
    private let icon = UIImageView(image: UIImage(systemName: Icons.boltFill))
    
    var tapHandler: (() -> Void)?
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        icon.tintColor = .systemOrange
        addSubview(icon)
        
        isUserInteractionEnabled = true
        backgroundColor = .white
        
        icon.snp.remakeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(30)
            make.edges.equalToSuperview().inset(Constants.Spacing.medium)
        }
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapInView))
        addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 32
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.25
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}

extension HomeQuickAddButton {
    @objc
    private func didTapInView() {
        tapHandler?()
    }
}
