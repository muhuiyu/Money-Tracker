//
//  User.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation

typealias UserID = UUID

struct User {
    var id: UserID
    var displayName: String?
    var email: String?
    var photoURL: URL?
}

extension User {
    mutating func clearData() {
        id = UUID()
        displayName = nil
        email = nil
        photoURL = nil
    }
}
