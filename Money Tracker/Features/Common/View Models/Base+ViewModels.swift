//
//  Base+ViewModels.swift
//  Fastiee
//
//  Created by Mu Yu on 6/27/22.
//

import UIKit
import RxSwift

public protocol ViewModelType {
    
}

class BaseViewModel: ViewModelType {
    internal let disposeBag = DisposeBag()
    
    weak var appCoordinator: AppCoordinator?
    
    init(appCoordinator: AppCoordinator? = nil) {
        self.appCoordinator = appCoordinator
    }
}


//extension Base {
//
//    open class ViewModel: ViewModelType {
//        let disposeBag = DisposeBag()
//    }
//
//    open class ServiceViewModel<S: ServiceType>: Base.ViewModel {
//        var service: S.Type = S.self
//    }
//}
