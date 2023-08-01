//
//  RecurringTransaction.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

typealias RecurringTransactionID = UUID

struct RecurringTransaction: TransactionSettings, Codable {
    let id: RecurringTransactionID
    let userID: UserID
    var rule: RecurringRule
    var isActive: Bool
    var merchantID: MerchantID
    var currencyCode: CurrencyCode
    var amount: Double
    var type: TransactionType
    var note: String
    var categoryID: CategoryID
    var tag: TransactionTag
}

enum RecurringRule: Codable {
    case annually([YearMonthDay])   // days in year
    case monthly([Int])             // days in month
    case weekly([Int])              // days in week
    case daily
    
    func getRuleString() -> String {
        switch self {
        case .annually(let array):
            let dateString = array.map({ $0.toString(in: "MMM dd") }).joined(separator: ", ")
            return "Annually on \(dateString)"
        case .monthly(let array):
            let dateString = array.map { day in
                switch day {
                case 1: return "1st"
                case 2: return "2nd"
                case 3: return "3rd"
                default: return "\(day)th"
                }
            }.joined(separator: ", ")
            return "Monthly on \(dateString) of the month"
        case .weekly(let array):
            let dateString = array.compactMap { Date.Weekday(rawValue: $0)?.name }.joined(separator: ", ")
            return "Weekly on \(dateString)"
        case .daily:
            return "Daily"
        }
    }
}

extension RecurringTransaction {
    var displayRecuringRuleString: String {
        let nextDateString = nextTransactionDate.toString(in: "MMM dd, YYYY")
        switch self.rule {
        case .annually(_):
            return "Annually - Next on \(nextDateString)"
        case .weekly(_):
            return "Weekly - Next on \(nextDateString)"
        case .monthly(_):
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
    var nextTransactionDate: YearMonthDay {
        switch rule {
        case .annually(let dates):
            let datesThisYear = dates
                .map({ YearMonthDay(year: Date.today.year, month: $0.month, day: $0.day) })
                .sorted()
            
            guard let lastDateThisYear = datesThisYear.last else { return .today }
            
            if lastDateThisYear < YearMonthDay.today {
                // if the last date in this year has passed, use the first value in next cycle
                guard let firstDate = dates.first else { return YearMonthDay.today }
                return YearMonthDay(year: Date.today.year + 1, month: firstDate.month, day: firstDate.day)
                
            } else {
                // or find the closet next date
                return datesThisYear.first(where: { $0 >= .today }) ?? .today
            }

        case .weekly(let days):
            let datesThisWeek = days
                .sorted()
                .compactMap { YearMonthDay.today.getDateInThisWeek(on: $0) }
            
            guard let lastDateThisWeek = datesThisWeek.last else { return .today }

            if lastDateThisWeek < YearMonthDay.today {
                // if the last date in this weak has passed, use the first value in next cycle
                guard let firstDate = datesThisWeek.first else { return YearMonthDay.today }
                return firstDate.day(after: 7)
            } else {
                // or find the closet next date
                return datesThisWeek.first(where: { $0 >= .today }) ?? .today
            }
        case .monthly(let days):
            let datesInThisMonth = days
                .sorted()
                .map({ YearMonthDay(year: Date.today.year, month: Date.today.month, day: $0) })
            
            guard let lastDateThisMonth = datesInThisMonth.last else { return .today }

            if lastDateThisMonth < YearMonthDay.today {
                // if the last date in this weak has passed, use the first value in next cycle
                guard let firstDay = days.first else { return YearMonthDay.today }
                let nextYearMonth = YearMonth.now.nextMonth
                return YearMonthDay(year: nextYearMonth.year, month: nextYearMonth.month, day: firstDay)
            } else {
                // or find the closet next date
                return datesInThisMonth.first(where: { $0 >= .today }) ?? .today
            }
        case .daily:
            return .today
        }
    }

}

//extension RecurringRule {
//    init(everyNMonths numberOfMonths: Int, on dates: [Int]) {
//        self.cycle = .monthly
//        self.numberOfMonths = numberOfMonths
//        self.dates = dates
//    }
//    init(everyNDays numberOfDays: Int) {
//        self.cycle = .daily
//        self.numberOfDays = numberOfDays
//    }
//    init(everyNWeeks numberOfWeeks: Int, on weekdays: [Int]) {
//        self.cycle = .weekly
//        self.numberOfWeeks = numberOfWeeks
//        self.weekdays = weekdays
//    }
//    init(everyNYears numberOfYears: Int, month: Int, day: Int) {
//        self.cycle = .annually
//        self.monthAndDay = [month, day]
//    }
//}
//extension RecurringRule: Codable {
//    private enum CodingKeys: String, CodingKey {
//        case cycle
//        case numberOfMonths
//        case dates
//        case numberOfDays
//        case numberOfWeeks
//        case weekdays
//        case numberOfYears
//        case monthAndDay
//    }
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        cycle = try container.decode(RecurringCycle.self, forKey: .cycle)
//        numberOfMonths = try container.decode(Int.self, forKey: .numberOfMonths)
//        dates = try container.decode([Int].self, forKey: .dates)
//        numberOfDays = try container.decode(Int.self, forKey: .numberOfDays)
//        numberOfWeeks = try container.decode(Int.self, forKey: .numberOfWeeks)
//        weekdays = try container.decode([Int].self, forKey: .dates)
//        numberOfYears = try container.decode(Int.self, forKey: .numberOfYears)
//        monthAndDay = try container.decode([Int].self, forKey: .monthAndDay)
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(cycle, forKey: .cycle)
//        try container.encode(numberOfMonths, forKey: .numberOfMonths)
//        try container.encode(dates, forKey: .dates)
//        try container.encode(numberOfDays, forKey: .numberOfDays)
//        try container.encode(numberOfWeeks, forKey: .numberOfWeeks)
//        try container.encode(weekdays, forKey: .weekdays)
//        try container.encode(numberOfYears, forKey: .numberOfYears)
//        try container.encode(monthAndDay, forKey: .monthAndDay)
//    }
//}

// MARK: - Persistable
extension RecurringTransaction: Persistable {
    public init(managedObject: RecurringTransactionObject) {
        id = managedObject.id
        userID = managedObject.userID
        isActive = managedObject.isActive
        currencyCode = managedObject.currencyCode
        merchantID = managedObject.merchantID
        amount = managedObject.amount
        type = TransactionType(rawValue: managedObject.type) ?? .expense
        note = managedObject.note
        categoryID = managedObject.categoryID
        tag = TransactionTag(rawValue: managedObject.tag) ?? .dailyLiving
        
        if let persistedRule = managedObject.rule {
            switch persistedRule.ruleCase {
            case "annually":
                var yearMonthDays = [YearMonthDay]()
                for ymdObject in persistedRule.yearMonthDay {
                    let yearMonthDay = YearMonthDay(year: ymdObject.year, month: ymdObject.month, day: ymdObject.day)
                    yearMonthDays.append(yearMonthDay)
                }
                rule = .annually(yearMonthDays)
            case "monthly":
                var days = [Int]()
                persistedRule.days.forEach { days.append($0) }
                rule = .monthly(days)
            case "weekly":
                var days = [Int]()
                persistedRule.days.forEach { days.append($0) }
                rule = .weekly(days)
            case "daily":
                rule = .daily
            default:
                rule = .daily
            }
        } else {
            rule = .daily
        }
    }
    
    public func managedObject() -> RecurringTransactionObject {
        let persistedRule = PersistedRecurringRule()
        switch rule {
        case .annually(let yearMonthDays):
            persistedRule.ruleCase = "annually"
            for ymd in yearMonthDays {
                let ymdObject = YearMonthDayObject()
                ymdObject.year = ymd.year
                ymdObject.month = ymd.month
                ymdObject.day = ymd.day
                persistedRule.yearMonthDay.append(ymdObject)
            }
        case .monthly(let days):
            persistedRule.ruleCase = "monthly"
            persistedRule.days.append(objectsIn: days)
        case .weekly(let days):
            persistedRule.ruleCase = "weekly"
            persistedRule.days.append(objectsIn: days)
        case .daily:
            persistedRule.ruleCase = "daily"
        }
        
        return RecurringTransactionObject(id: id,
                                          userID: userID,
                                          rule: persistedRule,
                                          isActive: isActive,
                                          merchantID: merchantID,
                                          currencyCode: currencyCode,
                                          amount: amount,
                                          type: type.rawValue,
                                          note: note,
                                          categoryID: categoryID,
                                          tag: tag.rawValue)
    }
}

extension RecurringTransaction {
    static var testEntries: [RecurringTransaction] = [
        RecurringTransaction(id: UUID(uuidString: "f1a781c8-0039-45f1-b0a2-9a27ee2f14b0") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([1]),
                             isActive: true,
                             merchantID: UUID(uuidString: "5fcee846-c340-470f-8e7e-853424f550d3") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 375,
                             type: .expense,
                             note: "12 months for $4481, $375 per month, from Oct 2022 to Sep 2023",
                             categoryID: "13-01",
                             tag: .smallBill),
        RecurringTransaction(id: UUID(uuidString: "d5fd5e56-8ec1-46bf-be6b-553361a3267c") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([1]),
                             isActive: true,
                             merchantID: UUID(uuidString: "3a6211ff-a11b-4a97-ad14-9dce8992bfbe") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 15,
                             type: .expense,
                             note: "Yearly plan (99 USD/year → 12 SGD/month), renew on Apr 15th, 2023",
                             categoryID: "7-01",
                             tag: .smallBill),
        RecurringTransaction(id: UUID(uuidString: "943ecc17-46ae-4458-b00d-1474bc2897ec") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([1]),
                             isActive: true,
                             merchantID: UUID(uuidString: "91a44a02-37f8-46d2-b764-5720e61b8d01") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 3.3,
                             type: .expense,
                             note: "Yearly plan (99 SGD/year but 3.3 SGD/month for first 2 years), renew on Oct 23, 2023",
                             categoryID: "7-01",
                             tag: .smallBill),
        RecurringTransaction(id: UUID(uuidString: "5cda0a1b-4b9e-4905-968a-dbbf99714dc5") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([1]),
                             isActive: true,
                             merchantID: UUID(uuidString: "547a0072-ad01-4c53-be56-f7528f0df33b") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 1410,
                             type: .expense,
                             note: "🎓 UIUC MCS monthly (total 21440 USD = 31000 SGD), 1410 SGD per month (Aug 2021 to May 2022)",
                             categoryID: "8-01",
                             tag: .debt),
        RecurringTransaction(id: UUID(uuidString: "f8a6c6d2-09f4-4584-99ab-4d168cae5508") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([27]),
                             isActive: false,
                             merchantID: UUID(uuidString: "d1838d66-ad73-4861-935f-bbc9485092b3") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 20,
                             type: .expense,
                             note: "NTD390 on 27th of the month",
                             categoryID: "12-02",
                             tag: .smallBill),
        RecurringTransaction(id: UUID(uuidString: "f5aa2ec7-79ec-4230-a2da-d68e19e17bf0") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([3]),
                             isActive: true,
                             merchantID: UUID(uuidString: "b0f277f0-ef84-4aa7-b778-5752d0c14b48") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 5,
                             type: .expense,
                             note: "",
                             categoryID: "3-04",
                             tag: .bigBill),
        RecurringTransaction(id: UUID(uuidString: "0ed8aa85-b685-4d09-b592-a53905cf1654") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([1]),
                             isActive: true,
                             merchantID: UUID(uuidString: "638e0a4b-97b1-4376-8d57-a49a45d5aa7d") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 840,
                             type: .transfer,
                             note: "Rent (on every 26th monthly)",
                             categoryID: "15-01",
                             tag: .bigBill),
        RecurringTransaction(id: UUID(uuidString: "590b79ac-e382-43f6-babb-1e00c4553c4b") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([15]),
                             isActive: true,
                             merchantID: UUID(uuidString: "59b4a5eb-826d-4d50-8ff3-1e094583a2a8") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 100,
                             type: .expense,
                             note: "100 credits for $485",
                             categoryID: "8-02",
                             tag: .smallBill),
        RecurringTransaction(id: UUID(uuidString: "c148ea5d-2e35-4b8c-b60f-52d043fcb6c3") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([1]),
                             isActive: true,
                             merchantID: UUID(uuidString: "664d2776-8d32-42ea-b306-83c911d7b962") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 35,
                             type: .expense,
                             note: "Conceptive Pills, renew every 6 months (168 days), next one is on Jan 17, 2023",
                             categoryID: "11-03",
                             tag: .smallBill),
        RecurringTransaction(id: UUID(uuidString: "f28adeab-5a6a-409a-ab6e-e85cb1e3d929") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([1]),
                             isActive: true,
                             merchantID: UUID(uuidString: "638e0a4b-97b1-4376-8d57-a49a45d5aa7d") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 1030,
                             type: .transfer,
                             note: "",
                             categoryID: "15-02",
                             tag: .bigBill),
        RecurringTransaction(id: UUID(uuidString: "f345082a-6f77-4bf0-b40f-0f54d2a593b8") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([7]),
                             isActive: true,
                             merchantID: UUID(uuidString: "04379ac3-0310-44db-bdef-892539f5ff05") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 7200,
                             type: .income,
                             note: "",
                             categoryID: "0-01",
                             tag: .smallBill),
        RecurringTransaction(id: UUID(uuidString: "7b9ae03a-2e74-4333-ac39-fa5ee8057b75") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([1]),
                             isActive: true,
                             merchantID: UUID(uuidString: "638e0a4b-97b1-4376-8d57-a49a45d5aa7d") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 281.2,
                             type: .expense,
                             note: "Change to annual payment (3373.83 per year), next payment on July 25, 2023",
                             categoryID: "10-01",
                             tag: .bigBill),
        RecurringTransaction(id: UUID(uuidString: "f8d8c087-899a-4159-9d93-b3ff5c3132b2") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([1]),
                             isActive: true,
                             merchantID: UUID(uuidString: "1cb80702-8643-45cb-9fb2-2c196d067919") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 2.4,
                             type: .expense,
                             note: "Yearly plan (28 SGD/year → 2.4 SGD/month), next payment on Dec 28th, 2022",
                             categoryID: "7-01",
                             tag: .smallBill),
        RecurringTransaction(id: UUID(uuidString: "1bf12f94-8e95-4c98-a69b-68b809955b13") ?? UUID(),
                             userID: UUID(uuidString: "582b621d-579f-4ab6-a9e7-8614d07f997f") ?? UUID(),
                             rule: .monthly([5]),
                             isActive: true,
                             merchantID: UUID(uuidString: "34b62b3b-83e5-4ba6-a495-9543609ce636") ?? UUID(),
                             currencyCode: "SGD",
                             amount: 2.6,
                             type: .expense,
                             note: "250 yen per month (550 yen for anime)",
                             categoryID: "12-02",
                             tag: .smallBill),
    ]
}
