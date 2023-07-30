//
//  LoadingScreenViewController.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class LoadingScreenViewController: BaseViewController {
    
    private let titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureSignals()
    }    
}
// MARK: - View Config
extension LoadingScreenViewController {
    private func configureViews() {
        titleLabel.font = UIFont.h2
        titleLabel.text = Localized.Loading.title
        view.addSubview(titleLabel)
    }
    private func configureConstraints() {
        titleLabel.snp.remakeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    private func configureGestures() {
        
    }
    private func configureSignals() {
        
    }
}
