//
//  TimeInterval+Extensions.swift
//  Fastiee
//
//  Created by Mu Yu on 6/27/22.
//

import Foundation

extension TimeInterval {
    var toString: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        return formatter.string(from: self) ?? ""
    }
}
