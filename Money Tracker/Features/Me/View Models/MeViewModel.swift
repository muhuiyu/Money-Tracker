//
//  MeViewModel.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/3/22.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

class MeViewModel: BaseViewModel {
    
}

extension MeViewModel {
    // TODO: - Add localized string
    var displayTitle: String { "Me" }
    var displayRefreshControlString: String { Localized.General.pullToRefresh }
}

// MARK: - Delegate
extension MeViewModel {
    @objc
    func didTapOnNotification() {
        
    }
}
