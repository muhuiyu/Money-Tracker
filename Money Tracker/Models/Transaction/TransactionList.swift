//
//  TransactionList.swift
//  Why am I so poor
//
//  Created by Grace, Mu-Hui Yu on 8/7/22.
//

import Foundation
import Collections
import RxSwift
import RxRelay
import UIKit

typealias TransactionList = [Transaction]
typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

extension TransactionList {
//    var totalSignedAmount: Double {
//        return self.reduce(0, { $0 + $1.signedAmount })
//    }
//    var totalAmount: Double {
//        return self.reduce(0, { $0 + $1.amount })
//    }
//    mutating func remove(id: TransactionID) {
//        guard let index = self.firstIndex(where: { $0.id == id }) else { return }
//        self.remove(at: index)
//    }
//    func sorted() -> TransactionList {
//        return self.sorted(by: {
//            YearMonthDay(year: $0.year, month: $0.month, day: $0.day) > YearMonthDay(year: $1.year, month: $1.month, day: $1.day)
//        })
//    }
//    func accumulate() -> TransactionPrefixSum {
//        guard !self.isEmpty else { return [] }
//
//        let today = YearMonthDay.today
//        guard let dateInterval = Calendar.current.dateInterval(of: .month, for: today) else { return [] }
//        var sum: Double = .zero
//        var cumulativeSum = TransactionPrefixSum()
//        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
//            let dailyTotal = self.filter { $0.date == date && $0.type == .expense }.reduce(0) { $0 - $1.signedAmount }
//            sum += dailyTotal
//            sum = sum.roundedToTwoDigits()
//            cumulativeSum.append((date.formatted(), sum))
//        }
//        return cumulativeSum
//    }
    func accumulateInDays(in month: Date.MonthInNumber,
                          of year: Int,
                          shouldRoundOffToInt: Bool = false) -> [Double] {
        let numberOfDaysInMonth = Date.getNumberOfDays(year: year, month: month.rawValue)
        guard !self.isEmpty else {
            return [Double](repeating: 0, count: numberOfDaysInMonth)
        }
        var sum: Double = .zero
        var cumulativeSum = [Double]()
//        for day in 1...numberOfDaysInMonth {
//            let dailyTotal = self
//                .filter { $0.day == day && $0.month == month.rawValue && $0.year == year }
//                .filter { $0.type == .expense }
//                .reduce(0) { $0 - $1.signedAmount }
//            sum += dailyTotal
//            if shouldRoundOffToInt {
//                cumulativeSum.append(sum.rounded())
//            } else {
//                cumulativeSum.append(sum.roundedToTwoDigits())
//            }
//        }
        return cumulativeSum
    }
}

extension TransactionList {
    func groupedByMonth() -> TransactionGroup {
        guard !self.isEmpty else { return [:] }
        let groupedTransactions = TransactionGroup(grouping: self) { $0.monthYearString }
        return groupedTransactions
    }
    func groupedByDay() -> TransactionGroup {
        guard !self.isEmpty else { return [:] }
        let groupedTransactions = TransactionGroup(grouping: self) { $0.dateStringInLocalDateFormat }
        return groupedTransactions
    }
    func groupedByCategory() -> TransactionGroup {
        guard !self.isEmpty else { return [:] }
        let groupedTransactions = TransactionGroup(grouping: self) { $0.categoryID }
        return groupedTransactions
    }
    func groupedByMainCategory() -> TransactionGroup {
        guard !self.isEmpty else { return [:] }
        var groupedTransactions = TransactionGroup()
        for transaction in self {
            guard let mainCategoryID = Category.getMainCategoryID(of: transaction.categoryID) else { continue }
            groupedTransactions[mainCategoryID, default: []].append(transaction)
        }
        return groupedTransactions
    }
}

extension TransactionList {
    
}
