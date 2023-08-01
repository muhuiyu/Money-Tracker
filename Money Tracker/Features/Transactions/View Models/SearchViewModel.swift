//
//  SearchViewModel.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit
import RxSwift
import RxRelay

class SearchViewModel: BaseViewModel {
    
    let result: BehaviorRelay<[Transaction]> = BehaviorRelay(value: [])
    
    let searchQuery = BehaviorRelay(value: "")
    
    override init(appCoordinator: AppCoordinator? = nil) {
        super.init(appCoordinator: appCoordinator)
        
        searchQuery
            .asObservable()
            .subscribe { _ in
                self.getSearchResult()
            }
            .disposed(by: disposeBag)
    }
}

extension SearchViewModel {
    private func getSearchResult() {
        guard let dataProvider = appCoordinator?.dataProvider else { return }
        result.accept(dataProvider.getTransactions(for: searchQuery.value))
    }
}
