//
//  ListStyleTableViewHeader.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class ListStyleTableViewHeader: UIView {
    
    private let label = UILabel()
    private let rightViewContainer = UIView()
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    var rightView: UIView? {
        didSet {
            if let rightView = rightView {
                rightViewContainer.addSubview(rightView)
                rightView.snp.remakeConstraints { make in
                    make.edges.equalToSuperview()
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.systemGroupedBackground
        label.font = .small
        label.textColor = .secondaryLabel
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        addSubview(rightViewContainer)
        
        label.snp.remakeConstraints { make in
            make.leading.equalTo(layoutMarginsGuide).inset(Constants.Spacing.small)
            make.centerY.equalToSuperview()
        }
        rightViewContainer.snp.remakeConstraints { make in
            make.trailing.equalTo(layoutMarginsGuide).inset(Constants.Spacing.small)
            make.top.bottom.equalTo(layoutMarginsGuide)
            make.centerY.equalToSuperview()
            make.height.greaterThanOrEqualTo(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
