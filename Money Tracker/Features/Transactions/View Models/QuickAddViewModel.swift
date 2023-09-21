//
//  QuickAddViewModel.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 8/2/23.
//

import UIKit
import RxSwift
import RxRelay

class QuickAddViewModel: BaseViewModel {
    enum Mode: Int {
        case shortcut = 0
        case recurring
    }
    
    let currentMode: BehaviorRelay<Mode> = BehaviorRelay(value: .shortcut)
    let items: BehaviorRelay<[TransactionSettings]> = BehaviorRelay(value: [])
    
    override init(appCoordinator: AppCoordinator? = nil) {
        super.init(appCoordinator: appCoordinator)
        
        currentMode
            .asObservable()
            .subscribe { _ in
                self.reloadData()
            }
            .disposed(by: disposeBag)
    }
}

extension QuickAddViewModel {
    func reloadData() {
        guard let dataProvider = appCoordinator?.dataProvider else { return }
        switch currentMode.value {
        case .recurring:
            items.accept(dataProvider.getAllRecurringTransactions())
        case .shortcut:
            items.accept(dataProvider.getAllShortcutTransactions())
        }
    }
    
    func getMerchantName(at indexPath: IndexPath) -> String? {
        guard let merchantList = appCoordinator?.dataProvider.getMerchantsMap() else { return nil }
        if let merchantName = merchantList[items.value[indexPath.row].merchantID]?.value {
            return merchantName
        }
        return nil
    }
}
