//
//  TimeZone+Extensions.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
//

import Foundation

extension TimeZone {
    init?(iso8601String: String) {
        // iso8601String format: 2018-09-18T11:00:00+09:00Z
        let timeZoneString = String(iso8601String.suffix(7))
        let sign = String(timeZoneString.prefix(1))

        guard sign == "+" || sign == "-" else { return nil }

        let fullTimeString = timeZoneString.filter("0123456789".contains)

        guard
            fullTimeString.count == 4,
            let hours = Int(sign+fullTimeString.prefix(2)),
            let minutes = Int(sign+fullTimeString.suffix(2))
        else {
            return nil
        }

        let secondsFromGMT = hours * 3600 + minutes * 60

        self.init(secondsFromGMT: secondsFromGMT)
    }
}
