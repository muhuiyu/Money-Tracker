//
//  PaymentMethod.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
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
