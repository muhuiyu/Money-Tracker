//
//  MeViewController.swift
//  Fastiee
//
//  Created by Mu Yu on 6/25/22.
//

import UIKit

class MeViewController: Base.MVVMViewController<MeViewModel> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureGestures()
        configureBindings()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
}
// MARK: - Handlers
extension MeViewController {
    @objc
    private func didTapSettings() {
        // TODO: - Add settings page
        print("didTapSettings")
    }
}
// MARK: - View Config
extension MeViewController {
    private func configureViews() {
        title = viewModel.displayTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Icons.gearshape),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapSettings))
    }
    private func configureConstraints() {
        
    }
    private func configureGestures() {
        
    }
    private func configureBindings() {
        
    }
}

