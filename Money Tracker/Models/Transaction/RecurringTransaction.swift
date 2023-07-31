//
//  RecurringTransaction.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

typealias RecurringTransactionID = UUID

struct RecurringTransaction {
    let id: RecurringTransactionID
    let userID: UserID
    let transactionSettings: RecurringTransactionSettings
    let rule: RecurringRule
    let isActive: Bool
}

extension RecurringTransaction {
    var displayRecuringRuleString: String {
        guard let nextDateString = nextTransactionDate.toMonthAndDayString else { return "" }
        switch self.rule.cycle {
        case .annually:
            return "Annually - Next on \(nextDateString)"
        case .weekly:
            return "Weekly - Next on \(nextDateString)"
        case .monthly:
            return "Monthly - Next on \(nextDateString)"
        case .daily:
            return "Daily - Next on \(nextDateString)"
        }
    }
    static func getRecurringRuleString(_ id: RecurringTransactionID) -> String {
        // get recurring rule from database
//        if !id.isEmpty, let recurringTransaction = Database.shared.getRecurringTransaction(id) {
//            return recurringTransaction.displayRecuringRuleString
//        }
        return "No repeat"
    }
    var nextTransactionDate: Date {
        switch self.rule.cycle {
        case .annually:
            guard
                let dateThisCycle = YearMonthDay(year: Date.today.year, month: self.rule.monthAndDay[0], day: self.rule.monthAndDay[1]).toDate,
                let dateNextCycle = YearMonthDay(year: Date.today.year + self.rule.numberOfYears, month: self.rule.monthAndDay[0], day: self.rule.monthAndDay[1]).toDate else {
                return Date()
            }
            return dateThisCycle >= Date.today ? dateThisCycle : dateNextCycle
        case .weekly:
            let weekdays = self.rule.weekdays.sorted()
            let datesInThisCycle = weekdays.compactMap { Date.today.getDateInThisWeek(on: $0) }
            
            guard !weekdays.isEmpty, !datesInThisCycle.isEmpty else { return Date() }
            
            for date in datesInThisCycle {
                if date >= Date.today {
                    return date
                }
            }
            guard let nextDate = datesInThisCycle.last?.day(after: 7) else {
                return Date()
            }
            return nextDate
        case .monthly:
            let dates = self.rule.dates.sorted()
            let datesInThisCycle = dates.compactMap { YearMonthDay(year: Date.today.year, month: Date.today.month, day: $0).toDate }
            
            guard !dates.isEmpty, !datesInThisCycle.isEmpty else { return Date() }
            
            for date in datesInThisCycle {
                if date >= Date.today {
                    return date
                }
            }
            
            var firstDateInNextCycle: YearMonthDay
            if Date.today.month + self.rule.numberOfMonths <= 12 {
                firstDateInNextCycle = YearMonthDay(year: Date.today.year,
                                                  month: Date.today.month + self.rule.numberOfMonths,
                                                  day: dates[0])
            } else {
                firstDateInNextCycle = YearMonthDay(year: Date.today.year + 1,
                                                  month: Date.today.month + self.rule.numberOfMonths - 12,
                                                  day: dates[0])
            }
            guard let nextDate = firstDateInNextCycle.toDate else {
                return Date()
            }
            return nextDate
        case .daily:
            // TODO: - haven't finished
            return Date()
        }
    }

}
extension RecurringTransaction: Codable {
    struct RecurringTransactionSettings: Codable, TransactionSettings {
        var merchantID: MerchantID
        var currencyCode: CurrencyCode
        var amount: Double
        let type: TransactionType
        var paymentBy: PaymentMethod
        var note: String = ""
        var categoryID: CategoryID
        var tag: TransactionTag
    }
    private struct RecurringTransactionData: Codable {
        let userID: UserID
        let transactionSettings: RecurringTransactionSettings
        let rule: RecurringRule
        let isActive: Bool
        
        private enum CodingKeys: String, CodingKey {
            case userID
            case transactionSettings
            case rule
            case isActive
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            userID = try container.decode(UserID.self, forKey: .userID)
            transactionSettings = try container.decode(RecurringTransactionSettings.self, forKey: .transactionSettings)
            rule = try container.decode(RecurringRule.self, forKey: .rule)
            isActive = try container.decode(Bool.self, forKey: .isActive)
        }
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(userID, forKey: .userID)
            try container.encode(transactionSettings, forKey: .transactionSettings)
            try container.encode(rule, forKey: .rule)
            try container.encode(isActive, forKey: .isActive)
        }
    }
}
struct RecurringRule {
    let cycle: RecurringCycle
    var numberOfMonths: Int = 0
    var dates: [Int] = []
    var numberOfDays: Int = 0
    var numberOfWeeks: Int = 0
    var weekdays: [Int] = []
    var numberOfYears: Int = 0
    var monthAndDay: [Int] = []
    
    enum RecurringCycle: String, Codable {
        case annually
        case monthly
        case weekly
        case daily
    }
}
extension RecurringRule {
    init(everyNMonths numberOfMonths: Int, on dates: [Int]) {
        self.cycle = .monthly
        self.numberOfMonths = numberOfMonths
        self.dates = dates
    }
    init(everyNDays numberOfDays: Int) {
        self.cycle = .daily
        self.numberOfDays = numberOfDays
    }
    init(everyNWeeks numberOfWeeks: Int, on weekdays: [Int]) {
        self.cycle = .weekly
        self.numberOfWeeks = numberOfWeeks
        self.weekdays = weekdays
    }
    init(everyNYears numberOfYears: Int, month: Int, day: Int) {
        self.cycle = .annually
        self.monthAndDay = [month, day]
    }
}
extension RecurringRule: Codable {
    private enum CodingKeys: String, CodingKey {
        case cycle
        case numberOfMonths
        case dates
        case numberOfDays
        case numberOfWeeks
        case weekdays
        case numberOfYears
        case monthAndDay
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cycle = try container.decode(RecurringCycle.self, forKey: .cycle)
        numberOfMonths = try container.decode(Int.self, forKey: .numberOfMonths)
        dates = try container.decode([Int].self, forKey: .dates)
        numberOfDays = try container.decode(Int.self, forKey: .numberOfDays)
        numberOfWeeks = try container.decode(Int.self, forKey: .numberOfWeeks)
        weekdays = try container.decode([Int].self, forKey: .dates)
        numberOfYears = try container.decode(Int.self, forKey: .numberOfYears)
        monthAndDay = try container.decode([Int].self, forKey: .monthAndDay)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cycle, forKey: .cycle)
        try container.encode(numberOfMonths, forKey: .numberOfMonths)
        try container.encode(dates, forKey: .dates)
        try container.encode(numberOfDays, forKey: .numberOfDays)
        try container.encode(numberOfWeeks, forKey: .numberOfWeeks)
        try container.encode(weekdays, forKey: .weekdays)
        try container.encode(numberOfYears, forKey: .numberOfYears)
        try container.encode(monthAndDay, forKey: .monthAndDay)
    }
}
