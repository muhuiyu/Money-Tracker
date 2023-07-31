//
//  PaymentMethod.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import Foundation

enum PaymentMethod: String, Codable, CaseIterable {
    case ocbcBankTransfer
    case amexTrueCashbackCard
    case amazeCard
    case citiRewardsCard
    case dbsAltitudeCard
    case grabPayCard
    case revolutCard
    case cash
}
