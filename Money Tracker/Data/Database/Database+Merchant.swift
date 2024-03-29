//
//  Database+Merchant.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/31/23.
//

import UIKit

// MARK: - Interface
extension Database {
    /// Returns all merchants
    func getAllMerchants() -> [Merchant] {
        let merchants = realm.objects(MerchantObject.self)
            .map { Merchant(managedObject: $0) }
        return Array(merchants)
    }
    
    func getMerchantsMap() -> [MerchantID: Merchant] {
        var map = [MerchantID: Merchant]()
        getAllMerchants().forEach { map[$0.id] = $0 }
        return map
    }
    
    func getMerchant(for id: MerchantID) -> Merchant? {
        return realm.objects(MerchantObject.self)
            .first(where: { $0.id == id })
            .map { Merchant(managedObject: $0) }
    }
    
//    /// Returns merchant string value of the given id
//    func getMerchantValue(of id: MerchantID) -> String? {
//        guard let merchant = merchantList[id] else { return nil }
//        return merchant.value
//    }
//    func getAllMerchantIDs() -> [MerchantID] {
//        return Database.shared.getAllMerchants().map { $0.id }
//        return []
//    }
//    func getMerchantName(of id: MerchantID) -> String? {
//        return Database.shared.getMerchantValue(of: id)
//        return nil
//    }
}
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
