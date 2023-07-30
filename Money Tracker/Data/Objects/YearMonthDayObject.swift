//
//  YearMonthDayObject.swift
//  Get Fit
//
//  Created by Mu Yu on 4/4/23.
//

import Foundation
import RealmSwift

final class YearMonthDayObject: Object {
    override class func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var id: UUID = UUID()
    @objc dynamic var year: Int = 0
    @objc dynamic var month: Int = 0
    @objc dynamic var day: Int = 0
    
    convenience init(id: UUID, year: Int, month: Int, day: Int) {
        self.init()
        self.id = id
        self.year = year
        self.month = month
        self.day = day
    }
}
