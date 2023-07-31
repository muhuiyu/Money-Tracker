//
//  Account.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

typealias AccountID = UUID

struct Account: Codable {
    let id: AccountID
    let name: String
    let amount: Double
}
