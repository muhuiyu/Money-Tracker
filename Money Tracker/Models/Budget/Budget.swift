//
//  Budget.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/3/22.
//

import UIKit

typealias BudgetID = String

struct Budget {
    var id: BudgetID
    var userID: UserID
    var mainCategoryID: CategoryID
    var amount: Double
}

extension Budget {
    var icon: UIImage? {
        if let iconName = MainCategory.getIconName(of: mainCategoryID) {
            return UIImage(systemName: iconName)
        }
        return UIImage(systemName: Icons.questionmark)
    }
    var monthlyAverageExpense: Double {
//        return Database.shared.getMonthlyAverageExpense(of: Category.getAllCategoryIDs(under: self.mainCategoryID))
        return 0
    }
    var totalExpenseAmount: Double {
//        return Database.shared.getMonthlyExpenseAmount(in: Date.today.month,
//                                                       of: Date.today.year,
//                                                       of: Category.getAllCategoryIDs(under: self.mainCategoryID))
        return 0
    }
    var remainingAmount: Double { self.amount - self.totalExpenseAmount }
    
    func status() -> BudgetState {
        if self.remainingAmount > 0 {
            return .under
        } else if remainingAmount == 0 {
            return .budget
        } else {
            return .over
        }
    }
    var categoryIDs: [CategoryID] {
        return Category.getAllCategoryIDs(under: self.mainCategoryID)
    }
    var usedPercentageString: String {
        let usedPercentage = (1 - (self.remainingAmount / self.amount)) * 100
        return "\(String(usedPercentage.rounded()))%"
    }
    
    func getExpenses(completion: ((TransactionList) -> Void)?) {
//        Database.shared.getMonthlyTransactions(year: Date.today.year,
//                                               month: Date.today.month,
//                                               of: Category.getAllCategoryIDs(under: self.mainCategoryID),
//                                               calculateExpenseOnly: true,
//                                               shouldIncludePending: false,
//                                               shouldPull: false) { result in
//            var expenses = TransactionList()
//            switch result {
//            case .failure(let error):
//                ErrorHandler.shared.handle(error)
//            case .success(let data):
//                expenses = data
//            }
//            if let completion = completion {
//                return completion(expenses)
//            }
//        }
    }
}

enum BudgetState {
    case under
    case budget
    case over
}

extension Budget: Codable {
    private struct BudgetData: Codable {
        var userID: UserID
        var mainCategoryID: CategoryID
        var amount: Double
        
        private enum CodingKeys: String, CodingKey {
            case userID
            case mainCategoryID
            case amount
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            userID = try container.decode(UserID.self, forKey: .userID)
            mainCategoryID = try container.decode(CategoryID.self, forKey: .mainCategoryID)
            amount = try container.decode(Double.self, forKey: .amount)
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(userID, forKey: .userID)
            try container.encode(mainCategoryID, forKey: .mainCategoryID)
            try container.encode(amount, forKey: .amount)
        }
    }
}
