//
//  UINavigationController+Extensions.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/4/22.
//

import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    func navigationBarColor(_ color: UIColor) {
        
    }
    
    func removeBottomLine() {
        navigationBar.shadowImage = UIImage()
    }
    
    func configureBackButton(_ image: UIImage, _ title: String? = nil, tintColor: UIColor? = nil) {
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image
        navigationBar.tintColor = tintColor ?? .white
        navigationBar.backItem?.title = title
        navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        navigationBar.items?.first?.title = ""  // what is this?
    }
}

extension UINavigationItem {
    internal enum ItemPosition {
        case left
        case right
    }
    func setTitle(_ text: String, color: UIColor = .label) {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textColor = color
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = true
        titleView = label
        label.sizeToFit()
    }
    func setBarButtonItem(at position: ItemPosition, with title: String? = nil, isBold: Bool = false, image: UIImage? = nil, target: Any?, action: Selector) {
        let item: UIBarButtonItem
        if let image = image {
            item = UIBarButtonItem(image: image, style: .done, target: target, action: action)
        } else {
            item = UIBarButtonItem(title: title, style: .done, target: target, action: action)
//            item.setTitleTextAttributes([
//                NSAttributedString.Key.font: isBold ? UIFont.bodyHeavy : UIFont.body,
//                NSAttributedString.Key.foregroundColor: UIColor.brand.primary,
//            ], for: .normal)
//            item.setTitleTextAttributes([
//                NSAttributedString.Key.font: isBold ? UIFont.bodyHeavy : UIFont.body,
//                NSAttributedString.Key.foregroundColor: UIColor.tertiaryLabel
//            ], for: .disabled)
        }
        switch position {
        case .left:
            leftBarButtonItems = [item]
        case .right:
            rightBarButtonItems = [item]
        }
    }
}

extension UINavigationBar {
    
}
