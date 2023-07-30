//
//  Database+Merchant.swift
//  Why am I so poor
//
//  Created by Mu Yu on 8/2/22.
//

import UIKit

// MARK: - Interface
//extension Database {
//    /// Returns all merchants
//    func getAllMerchants() -> [Merchant] {
//        return Array(merchantList.values)
//    }
//    /// Returns merchant string value of the given id
//    func getMerchantValue(of id: MerchantID) -> String? {
//        guard let merchant = merchantList[id] else { return nil }
//        return merchant.value
//    }
//}
//
//// MARK: -
//extension Database {
//    internal func fetchMerchants() async -> VoidResult {
//        do {
//            let snapshot = try await merchantRef.getDocuments()
//            let entries: [Merchant] = snapshot
//                .documentChanges
//                .filter { $0.type == .added }
//                .compactMap { try? Merchant(snapshot: $0.document) }
//
//            updateMerchantList(from: entries)
//            return .success
//
//        } catch {
//            return .failure(error)
//        }
//    }
//
//    private func updateMerchantList(from data: [Merchant]) {
//        merchantList.removeAll()
//
//        data.forEach {
//            merchantList[$0.id] = $0
//        }
//    }
//
//}
//
//// MARK: - Private functions
//extension Database {
//
//}
