//
//  AccountObject.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import Foundation
import RealmSwift

final class AccountObject: Object {
    override class func primaryKey() -> String? {
        return "id"
    }
    
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var name: String = ""
//    @objc dynamic var amount: NSDecimalNumber = 0
    @objc dynamic var amount: Double = 0
    
    convenience init(id: UUID, name: String, amount: Double) {
        self.init()
        self.id = id
        self.name = name
        self.amount = amount
    }
}
