//
//  ListStyleTableViewHeader.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class ListStyleTableViewHeader: UIView {
    
    private let label = UILabel()
    
    var text: String? {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = UIColor.systemGroupedBackground
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        
        label.snp.remakeConstraints { make in
            make.leading.equalTo(layoutMarginsGuide).inset(Constants.Spacing.small)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
