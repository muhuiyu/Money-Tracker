//
//  MerchantObject.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation
import RealmSwift

final class MerchantObject: Object {
    override class func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id: MerchantID = UUID()
    @objc dynamic var value: String = ""
    
    convenience init(id: MerchantID, value: String) {
        self.init()
        self.id = id
        self.value = value
    }
}

