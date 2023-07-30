//
//  Date+Extensions.swift
//  Fastiee
//
//  Created by Mu Yu on 6/27/22.
//

import Foundation

// MARK: - Get certain day
extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month],
                                                                           from: Calendar.current.startOfDay(for: self)))!
    }
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1),
                                     to: self.startOfMonth())!
    }
    var dayBefore: Date { self.day(before: 1) }
    var dayAfter: Date { self.day(after: 1) }
    
    func day(before numberOfDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -numberOfDays, to: noon)!
    }
    func day(after numberOfDays: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: numberOfDays, to: noon)!
    }
    
    var noon: Date { Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)! }
    var year: Int { Calendar.current.component(.year, from: self) }
    var month: Int { Calendar.current.component(.month, from: self) }
    var dayOfMonth: Int { Calendar.current.component(.day, from: self) }
    
    func getDateInThisWeek(on weekday: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let weekDayOfToday = calendar.component(.weekday, from: self)
        return self.day(before: weekDayOfToday - weekday)
    }
    
    static var today: Date { Date() }
    static var currentDay: Int { Date().dayOfMonth }
    static var currentMonth: Int { Date().month }
    static var currentYear: Int { Date().year }
    
    var firstDayOfMonth: Date { self.day(before: self.dayOfMonth-1) }
    var numberOfDaysRemainingToEndOfMonth: Int {
        guard let monthInNumber = MonthInNumber(rawValue: self.month) else { return -1 }
        return Date.getNumberOfDays(in: monthInNumber, of: self.year) - self.dayOfMonth + 1
    }
}

// MARK: - Verification
extension Date {
    static func isLeapYear(year: Int) -> Bool {
        return year.isMultiple(of: 400) || (!year.isMultiple(of: 100) && year.isMultiple(of: 4))
    }
    static func isValid(year: Int, month: Int, day: Int) -> Bool {
        guard year > 0, month > 0, month <= 12, day > 0 else { return false }
        
        switch month {
        case MonthInNumber.january.rawValue,
            MonthInNumber.march.rawValue,
            MonthInNumber.may.rawValue,
            MonthInNumber.july.rawValue,
            MonthInNumber.august.rawValue,
            MonthInNumber.october.rawValue,
            MonthInNumber.december.rawValue: return day <= 31
        case MonthInNumber.april.rawValue,
            MonthInNumber.june.rawValue,
            MonthInNumber.september.rawValue,
            MonthInNumber.november.rawValue: return day <= 30
        case MonthInNumber.february.rawValue:
            if isLeapYear(year: year) {
                return day <= 29
            } else {
                return day <= 28
            }
        default: return false
        }
    }
    static func getNumberOfDays(in month: MonthInNumber, of year: Int) -> Int {
        switch month {
        case .january, .march, .may, .july, .august, .october, .december:
            return 31
        case .april, .june, .september, .november:
            return 30
        case .february:
            return isLeapYear(year: year) ? 29 : 28
        }
    }
    static func isValid(month: Int) -> Bool {
        return month >= 1 && month <= 12
    }
    enum MonthInString: String {
        case january
        case february
        case march
        case april
        case may
        case june
        case july
        case august
        case september
        case october
        case november
        case december
    }
    
    enum MonthInNumber: Int {
        case january = 1
        case february = 2
        case march = 3
        case april = 4
        case may = 5
        case june = 6
        case july = 7
        case august = 8
        case september = 9
        case october = 10
        case november = 11
        case december = 12
    }
}

// MARK: - Determine
extension Date {
    var isFirstDayOfMonth: Bool { dayBefore.month != month }
    var isLastDayOfMonth: Bool { dayAfter.month != month }
    func isTodayWeekend() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: self)
        return (weekDay == 1 || weekDay == 7)
    }
    func isToday(weekDay: Int) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let todayWeekDay = calendar.component(.weekday, from: self)
        return (todayWeekDay == weekDay)
    }
}

// MARK: - Date Formatter
extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
    var toMonthAndYearString: String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM yyyy"
        return dateFormatterPrint.string(from: self)
    }
    func toWeekDayAndDayString() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        let weekDay = Calendar.current.component(.weekday, from: self)
        return dateFormatterPrint.weekdaySymbols[weekDay - 1] + ", " + dateFormatterPrint.string(from: self)
    }
    func toWeekDayAndDayWithoutYearString() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        let weekDay = Calendar.current.component(.weekday, from: self)
        return dateFormatterPrint.weekdaySymbols[weekDay - 1] + ", " + dateFormatterPrint.string(from: self)
    }
    var toMonthDayYearString: String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        return dateFormatterPrint.string(from: self)
    }
    var toMonthAndDayString: String? {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd"
        return dateFormatterPrint.string(from: self)
    }
    func toYearMonthDayAndTimeString() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd hh:mm:ss"
        return dateFormatterPrint.string(from: self)
    }
    func toHistoryID() -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        return dateFormatterPrint.string(from: self) + "-history-entry"
    }
}
