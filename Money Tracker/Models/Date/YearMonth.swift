//
//  YearMonth.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
//

import Foundation

struct MonthAndYear: Comparable {
    var year: Int
    var month: Int
}
extension MonthAndYear {
    init(date: Date) {
        self.year = date.year
        self.month = date.month
    }
}
extension MonthAndYear {
    var isCurrentMonth: Bool {
        return self.year == Date.today.year && self.month == Date.today.month
    }
}
extension MonthAndYear {
    func toDate(dayOfMonth: Int = 1) -> Date? {
        YearMonthDay(year: self.year, month: self.month, day: dayOfMonth).toDate
    }
    var toMonthAndYearString: String? {
        self.toDate()?.toMonthAndYearString
    }
    var nextMonth: MonthAndYear {
        if month == 12 {
            return MonthAndYear(year: self.year+1, month: 1)
        } else {
            return MonthAndYear(year: self.year, month: self.month+1)
        }
    }
    var previousMonth: MonthAndYear {
        if month == 1 {
            return MonthAndYear(year: self.year-1, month: 12)
        } else {
            return MonthAndYear(year: self.year, month: self.month-1)
        }
    }
}
extension MonthAndYear {
    static func < (lhs: MonthAndYear, rhs: MonthAndYear) -> Bool {
        if lhs.year != rhs.year { return lhs.year < rhs.year }
        return lhs.month < rhs.month
    }
}
