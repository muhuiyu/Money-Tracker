//
//  DateFormatter+Extensions.swift
//  Fastiee
//
//  Created by Mu Yu on 6/27/22.
//

import Foundation

extension DateFormatter {
    static let allNumericUSA: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        
        return formatter
    }()
}
