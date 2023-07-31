//
//  BudgetList.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

typealias BudgetList = [Budget]

extension BudgetList {
    var totalBudgetAmount: Double { self.reduce(into: 0, { $0 += $1.amount }) }
    
    enum SortingRule {
        case mainCategoryID
        case remainingAmount
    }
    mutating func sort(by rule: SortingRule) {
//        self = self.sorted(by: rule)
    }
//    func sorted(by rule: SortingRule) -> BudgetList {
//        switch rule {
//        case .mainCategoryID:
//            return self.sorted { $0.mainCategoryID.localizedStandardCompare($1.mainCategoryID) == .orderedAscending }
//        case .remainingAmount:
//            return self.sorted { $0.remainingAmount < $1.remainingAmount }
//        }
//    }
}
