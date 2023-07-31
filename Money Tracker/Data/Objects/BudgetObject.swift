//
//  BudgetObject.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation
import RealmSwift

final class BudgetObject: Object {
    override class func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id: BudgetID = UUID()
    @objc dynamic var userID: UserID = UUID()
    @objc dynamic var mainCategoryID: MainCategoryID = ""
    @objc dynamic var amount: Double = 0
    
    convenience init(id: BudgetID, userID: UserID, mainCategoryID: MainCategoryID, amount: Double) {
        self.init()
        self.id = id
        self.userID = userID
        self.mainCategoryID = mainCategoryID
        self.amount = amount
    }
}


