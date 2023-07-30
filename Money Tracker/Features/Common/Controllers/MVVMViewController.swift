//
//  MVVMViewController.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
//

import Foundation
import UIKit
import RxSwift

extension Base {
    
    class MVVMViewController<T: ViewModelType>: BaseViewController {
        let viewModel: T
        let disposeBag = DisposeBag()
        
        init(viewModel: T) {
            self.viewModel = viewModel
            super.init()
        }
    }

}
