//
//  UserObject.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation
import RealmSwift

final class UserObject: Object {
    override class func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id: UserID = UUID()
    @objc dynamic var displayName: String?
    @objc dynamic var email: String?
    @objc dynamic var photoURLString: String?
    
    convenience init(id: UserID, displayName: String? = nil, email: String? = nil, photoURLString: String? = nil) {
        self.init()
        self.id = id
        self.displayName = displayName
        self.email = email
        self.photoURLString = photoURLString
    }
}
