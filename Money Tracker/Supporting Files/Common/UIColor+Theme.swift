//
//  UIColor+Theme.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

extension UIColor {
    struct Background {
        static let view = UIColor(hex: "f9f9f9")
        static let header = UIColor(hex: "E7F1F1")
    }
    
    struct Brand {
//        static let primary = UIColor(hex: "4C8C87")
        static let primary = UIColor.systemTeal
        static let secondary = UIColor(hex: "F68B5D")
        static let tertiary = UIColor(hex: "E9DBCB")
        static let light = UIColor(hex: "F8F2E9")
    }
    
    struct Basic {
        static let light = UIColor(hex: "FAFCFE")
        static let dark = UIColor(hex: "0E0E2C")
        static let accent = UIColor(hex: "ECF1F4")
        static let darkAccent = UIColor(hex: "D4DADB")
    }
    
    struct Text {
        static let body = UIColor(hex: "4A4A68")
        static let subtle = UIColor(hex: "8C8CA1")
        static let correctionTinted = UIColor(hex: "54B948")
        static let errorTinted = UIColor(hex: "ff2626")
        static let buttonLink = UIColor.systemBlue
        static let active = UIColor.Brand.secondary
    }
    struct Action {
        static let destructive = UIColor(hex: "FF3B30")
        static let success = UIColor(hex: "34C759")
    }
    // Input
    struct TextField {
        static let backgroundPrimary = UIColor(hex: "ebeff5")
    }
    
    struct Auth {
        static let google = UIColor(hex: "DB4437")
        static let apple = UIColor(hex: "2E3033")
        static let facebook = UIColor(hex: "3B5998")
    }
}
