//
//  Merchant.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/2/22.
//

import UIKit

typealias MerchantID = UUID

struct Merchant: Identifiable, Codable {
    let id: MerchantID
    let value: String
}

// MARK: - Persistable
extension Merchant: Persistable {
    public init(managedObject: MerchantObject) {
        id = managedObject.id
        value = managedObject.value
    }
    
    public func managedObject() -> MerchantObject {
        return MerchantObject(id: id, value: value)
    }
}

extension Merchant {
    static var fairPriceID: UUID {
        return UUID(uuidString: "64b0b60b-7592-4b32-833b-5eee9aa2fe27") ?? UUID()
    }
    static var smrtID: UUID {
        return UUID(uuidString: "2b59d275-8de3-4482-a2d6-5b9018d7de08") ?? UUID()
    }
}
