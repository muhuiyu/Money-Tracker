//
//  Account.swift
//  Why am I so poor
//
//  Created by Mu Yu on 7/5/22.
//

import UIKit

typealias AccountID = UUID

struct Account: Codable {
    let id: AccountID
    let name: String
    let amount: Double
}
