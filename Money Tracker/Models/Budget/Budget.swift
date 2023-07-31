//
//  Budget.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

typealias BudgetID = UUID

struct Budget: Codable {
    var id: BudgetID
    var userID: UserID
    var mainCategoryID: MainCategoryID
    var amount: Double
}

extension Budget {
    var icon: UIImage? {
        if let iconName = MainCategory.getIconName(of: mainCategoryID) {
            return UIImage(systemName: iconName)
        }
        return UIImage(systemName: Icons.questionmark)
    }
    
    var categoryIDs: [CategoryID] {
        return Category.getAllCategoryIDs(under: self.mainCategoryID)
    }
}

// MARK: - Persistable
extension Budget: Persistable {
    public init(managedObject: BudgetObject) {
        id = managedObject.id
        userID = managedObject.userID
        mainCategoryID = managedObject.mainCategoryID
        amount = managedObject.amount
        
    }
    public func managedObject() -> BudgetObject {
        return BudgetObject(id: id, userID: userID, mainCategoryID: mainCategoryID, amount: amount)
    }
}
