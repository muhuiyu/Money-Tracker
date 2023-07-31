//
//  UserManager.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/2/22.
//

import UIKit

class UserManager {
    private var user: User?
    
    init() {
        
    }
}
extension UserManager {
    var id: UserID? { user?.id }
    var name: String? { user?.displayName }
    
    func setData(_ user: User) {
        self.user = user
    }
    func clearData() {
        self.user?.clearData()
    }
}
