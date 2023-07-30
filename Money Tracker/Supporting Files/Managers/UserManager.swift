//
//  UserManager.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/2/22.
//

import UIKit

typealias UserID = UUID

class UserManager {
    private var userID: UserID = UUID()
    private var userName: String = ""
    private var userProfileImageUrlString: String?
    
    init() {
        
    }
}
extension UserManager {
    func clearData() {
        userID = UUID()
        userName = ""
        userProfileImageUrlString = nil
    }
}
