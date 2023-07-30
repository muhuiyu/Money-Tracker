//
//  YearMonthDay.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import Foundation

struct YearMonthDay: Comparable {
    var year: Int
    var month: Int
    var day: Int
}

extension YearMonthDay {
    static func < (lhs: YearMonthDay, rhs: YearMonthDay) -> Bool {
        guard let ldate = lhs.toDate, let rdate = rhs.toDate else { return false }
        return ldate < rdate
    }
}

extension YearMonthDay {
    static var today: YearMonthDay {
        let today = Date()
        return YearMonthDay(year: today.year, month: today.month, day: today.dayOfMonth)
    }
    
    var toDate: Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = CacheManager.shared.preferredTimeZone
        return Calendar.current.date(from: dateComponents)
    }
    
    func toString(in format: String) -> String {
        guard let date = self.toDate else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = CacheManager.shared.preferredTimeZone
        dateFormatter.calendar = CacheManager.shared.preferredCalendar
        dateFormatter.locale = CacheManager.shared.preferredLocale
        return dateFormatter.string(from: date)
    }
}
