//
//  ListStyleTableViewCell.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/1/23.
//

import UIKit

class ListStyleTableViewCell: UITableViewCell, BaseCell {
    static var reuseID: String = NSStringFromClass(ListStyleTableViewCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set the cell appearance
        contentView.backgroundColor = UIColor.systemBackground
        textLabel?.textColor = UIColor.label
        textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
