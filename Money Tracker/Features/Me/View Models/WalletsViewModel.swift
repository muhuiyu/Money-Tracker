//
//  WalletsViewModel.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit
import RxSwift
import RxRelay

class WalletsViewModel: BaseViewModel {
    
    let wallets: BehaviorRelay<[Account]> = BehaviorRelay(value: [])
    
    override init(appCoordinator: AppCoordinator? = nil) {
        super.init(appCoordinator: appCoordinator)
        configureBindings()
    }
}

extension WalletsViewModel {
    func reloadWallets() {
        
    }
    private func configureBindings() {
        
    }
}
