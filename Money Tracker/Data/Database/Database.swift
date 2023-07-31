//
//  Database.swift
//  Money Tracker
//
//  Created by Grace, Mu-Hui Yu on 7/30/23.
//

import Foundation
import Realm
import RealmSwift
//import CloudKit

public enum VoidResult {
    case success
    case failure(Error)
}

class Database {
//    internal let ckContainer = CKContainer(identifier: "MoneyTrackerRealmDatabase")
    private (set) var lastSyncTime: Date = Date()

    internal let realm: Realm

    public convenience init() throws {
        try self.init(realm: Realm())
    }

    internal init(realm: Realm) {
        self.realm = realm
        setup()
    }


    struct Attribute {
        static var userID: String { "userID" }
        static var year: String { "year" }
        static var month: String { "month" }
        static var day: String { "day" }
    }

    enum RealmError: Error {
        case missingDataProvider
        case missingObject
        case snapshotMissing
        case multipleDocumentUsingSameID
        case dataKeyMissing
        case entryInitFailure
        case userMissing
        case documentMissing
        case invalidDocumentID
        case invalidQuery
        case setDataFailure
        case deleteDataFailure
        case dataEncodingError
    }
    
    enum ReloadTransactionsOption {
        case all
        case inGivenMonth(Int, Int)
        case pendingOnly
    }
}

// MARK: - Setup
extension Database {
    func setup() {

//        try? realm.write {
//            realm.deleteAll()
//        }
//
//        if let data = readMerchantsFromJSONFile() {
//            data.forEach { item in
//                try? realm.write({
//                    let _ = realm.create(MerchantObject.self, value: item.managedObject())
//                })
//            }
//        }
//
//        if let data = readTransactionsFromJSONFile() {
//            print("data generated", data.count)
//            data.map { item in
//                return Transaction(id: item.id, userID: item.userID, currencyCode: item.currencyCode, date: YearMonthDay(year: item.year, month: item.month, day: item.day) , merchantID: item.merchantID, amount: item.amount, type: item.type, categoryID: item.categoryID, tag: item.tag, recurringID: item.recurringID, sourceAccountID: item.sourceAccountID, targetAccountID: item.targetAccountID)
//            }
//            .forEach { item in
//                try? realm.write {
//                    let transactionObject = item.managedObject()
//                    let _ = realm.create(TransactionObject.self, value: transactionObject)
//                }
//            }
//        }

        
//        syncBackup()

        // TODO: -
//        try? realm.write {
//            realm.deleteAll()
//        }
//        try? realm.write {
//            workoutSessionData.forEach { item in
//                let sessionObject = item.managedObject()
//                let _ = realm.create(WorkoutSessionObject.self, value: sessionObject)
//                item.circuits.forEach { circuit in
//                    let object = circuit.managedObject()
//                    let _ = realm.create(WorkoutCircuitObject.self, value: object)
//                }
//            }
//        }
    }
}

// MARK: - Users
extension Database {
//    func getUserPreference(for userID: UserID) -> UserPreference? {
//        guard let object = realm.objects(UserPreferenceObject.self).where({ $0.userID == userID }).first else {
//            return nil
//        }
//        return UserPreference(managedObject: object)
//    }
//
//    func getUserProfile(for userID: UserID) -> User? {
//        guard let object = realm.objects(UserObject.self).where({ $0.id == userID }).first else {
//            return nil
//        }
//        return User(managedObject: object)
//    }
}

//// MARK: - Food
//extension RealmDatabase {
//    func getCustomizedMeals(for userID: UserID) -> [CustomizedMeal] {
//        // TODO: -
//        return []
//    }
//
//    func getDailyMealLog(for userID: UserID, on date: Date) -> DailyMealLog? {
//        // TODO: -
//        return nil
//    }
//
//    func updateMealLog(for userID: UserID, to value: MealLog) -> VoidResult {
//        // TODO: -
//        return .success
//    }
//
//    func removeMealLog(for userID: UserID) -> VoidResult {
//        // TODO: -
//        return .success
//    }
//
//    func getPreviousFoodLogs(for userID: UserID) -> [FoodID : FoodLog] {
//        // TODO: -
//        return [:]
//    }
//
//    func searchFoods(contain keyword: String) -> [FoodID] {
//        // TODO: -
//        return []
//    }
//}
//
//// MARK: - Workout
//extension RealmDatabase {
//    func getWorkoutRoutines(for userID: UserID) -> [WorkoutRoutine] {
//        // TODO: -
//        return WorkoutRoutine.testEntries
//    }
//
//    func removeWorkoutRoutine(for userID: UserID, at workoutRoutine: WorkoutRoutineID) -> VoidResult {
//        // TODO: -
//        return .success
//    }
//
//    func getWorkoutCircuits(_ ids: [WorkoutCircuitID]) -> [WorkoutCircuit] {
//        let items = realm.objects(WorkoutCircuitObject.self)
//            .filter({ ids.contains($0.id) })
//            .map({ WorkoutCircuit(managedObject: $0) })
//        return Array(items)
//    }
//
//    func getAllWorkoutSessions(for userID: UserID) -> [WorkoutSession] {
//        let sessions = realm.objects(WorkoutSessionObject.self)
//            .filter({ $0.userID == userID })
//            .map({ session in
//                let circuits = self.getWorkoutCircuits(Array(session.circuits))
//                return WorkoutSession(managedObject: session, circuits: circuits)
//            })
//        return Array(sessions)
//    }
//
//    func getAllWorkoutRoutines(for userID: UserID) -> [WorkoutRoutine] {
//        // TODO: - connect to Realm
//        return WorkoutRoutine.testEntries
//    }
//
//    func getWorkoutSessions(for userID: UserID, from startDate: Date, to endDate: Date) -> [WorkoutSession] {
//        let sessions = realm.objects(WorkoutSessionObject.self)
//            .filter({ $0.userID == userID })
//            .filter({ session in
//                guard let startTimeObject = session.startTime else { return false }
//                let startTime = DateAndTime(managedObject: startTimeObject)
//                return startTime >= startDate.toDateAndTime && startTime <= endDate.toDateAndTime
//            })
//            .map({ session in
//                let circuits = self.getWorkoutCircuits(Array(session.circuits))
//                return WorkoutSession(managedObject: session, circuits: circuits)
//            })
//        return Array(sessions)
//    }
//
//    func getWorkoutSessions(for userID: UserID, on date: YearMonthDay) -> [WorkoutSession] {
//        let sessions = realm.objects(WorkoutSessionObject.self)
//            .filter({ $0.userID == userID })
//            .filter({ session in
//                guard let startTimeObject = session.startTime, let endTimeObject = session.endTime else { return false }
//                let startTime = DateAndTime(managedObject: startTimeObject)
//                let endTime = DateAndTime(managedObject: endTimeObject)
//                return startTime.toYearMonthDay == date || endTime.toYearMonthDay == date
//            })
//            .map({ session in
//                let circuits = self.getWorkoutCircuits(Array(session.circuits))
//                return WorkoutSession(managedObject: session, circuits: circuits)
//            })
//        return Array(sessions)
//    }
//
//    func removeCircuit(at id: WorkoutCircuitID) -> VoidResult {
//        do {
//            try realm.write({
//                try? deleteCircuitFromRealm(at: id)
//            })
//            return .success
//        } catch {
//            return .failure(error)
//        }
//    }
//
//    @discardableResult
//    func removeWorkoutSession(for userID: UserID, at sessionID: WorkoutSessionID) -> VoidResult {
//        guard let object = realm.objects(WorkoutSessionObject.self).where({ $0.id == sessionID }).first else {
//            return .failure(RealmError.missingObject)
//        }
//
//        do {
//            try realm.write({
//                object.circuits.forEach { circuitID in
//                    try? deleteCircuitFromRealm(at: circuitID)
//                }
//                realm.delete(object)
//            })
//            return .success
//        } catch {
//            return .failure(error)
//        }
//    }
//
//    func updateWorkoutSession(for userID: UserID, _ session: WorkoutSession) -> VoidResult {
//        do {
//            try realm.write({
//                realm.add(session.managedObject(), update: .modified)
//                session.circuits.forEach({
//                    realm.add($0.managedObject(), update: .modified)
//                })
//            })
//            return .success
//        } catch {
//            return .failure(error)
//        }
//    }
//
//    func fetchHistory(for userID: UserID, for circuit: WorkoutCircuit) -> [WorkoutCircuit] {
//        let items = realm.objects(WorkoutCircuitObject.self)
//            .map({ WorkoutCircuit(managedObject: $0) })
//            .filter { item in
//                return item.type == circuit.type && item.workoutItems == circuit.workoutItems
//            }
//        return Array(items)
//    }
//
//    func getJournal(for userID: UserID, on date: Date) -> [Journal] {
//        // TODO: -
//        return []
//    }
//}
//
//// MARK: - Backup Methods
//extension RealmDatabase {
//    internal var backupRecordID: CKRecord.ID { return CKRecord.ID(recordName: "backup") }
//
//    internal var backupURL: URL { FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("backup.realm") }
//
//    func syncBackup() {
////        createBackupToCloud()
////        lastSyncTime = Date()
//    }
//
//    internal func createBackupToCloud() {
//        // TODO: - login to my icloud
//        guard let fileURL = Realm.Configuration.defaultConfiguration.fileURL else { return }
//        let record = CKRecord(recordType: "Backup", recordID: backupRecordID)
//        let asset = CKAsset(fileURL: fileURL)
//        record["backup"] = asset
//        ckContainer.publicCloudDatabase.save(record) { _, error in
//            if let error = error {
//                print("Error uploading backup: \(error.localizedDescription)")
//            }
//        }
//    }
//    internal func readBackup() -> Data? {
//        var backupData: Data?
//        ckContainer.publicCloudDatabase.fetch(withRecordID: backupRecordID) { record, error in
//            if let error = error {
//                print("Error uploading backup: \(error.localizedDescription)")
//            } else if let backupRecord = record, let asset = backupRecord["backup"] as? CKAsset, let url = asset.fileURL {
//                do {
//                    backupData = try Data(contentsOf: url)
//                } catch {
//                    print("Error reading backup file: \(error.localizedDescription)")
//                }
//            }
//        }
//        return backupData
//    }
//    internal func createRealmDatabase(from file: Data) {
//        guard let fileURL = Realm.Configuration.defaultConfiguration.fileURL else { return }
//        let config = Realm.Configuration(fileURL: fileURL)
//        do {
//            let realm = try Realm(configuration: config)
//            try realm.write { realm.deleteAll() }
//            realm.beginWrite()
//            realm.deleteAll()
//            let backupRealm = try Realm(configuration: Realm.Configuration(encryptionKey: nil))
//            try backupRealm.writeCopy(toFile: fileURL, encryptionKey: nil)
//            try realm.commitWrite()
//            print("Backup restored successfully!")
//        } catch {
//            print("Error reading backup file: \(error.localizedDescription)")
//        }
//    }
//}
//
//// MARK: - Private methods
//extension RealmDatabase {
//    internal func deleteCircuitFromRealm(at id: WorkoutCircuitID) throws {
//        guard let object = realm.objects(WorkoutCircuitObject.self).where({ $0.id == id }).first else {
//            return
//        }
//        realm.delete(object)
//    }
//}
//
// MARK: - Convert from JSON
extension Database {
    private func readTransactionsFromJSONFile() -> [TransactionRawData]? {
        if let fileURL = Bundle.main.url(forResource: "transactions_output", withExtension: "json") {
            do {
                let jsondata = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                print(jsondata)
                let transactions = try decoder.decode([TransactionRawData].self, from: jsondata)
                return transactions
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
        return nil
    }

    private func readMerchantsFromJSONFile() -> [Merchant]? {
        if let fileURL = Bundle.main.url(forResource: "merchants_output", withExtension: "json") {
            do {
                let jsondata = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let transactions = try decoder.decode([Merchant].self, from: jsondata)
                return transactions
            } catch {
                print("Error decoding JSON: \(error)")
            }
        } else {
            print("JSON file not found.")
        }
        return nil
    }
}


struct TransactionRawData: Identifiable, Codable {
    var id: TransactionID
    var userID: UserID
    var currencyCode: CurrencyCode
    var year: Int
    var month: Int
    var day: Int
    var merchantID: MerchantID
    var amount: Double
    let type: TransactionType
    var note: String = ""
    var categoryID: CategoryID
    var tag: TransactionTag
    
    // Recurring payment
    var recurringID: RecurringTransactionID?
    
    // current account
    var sourceAccountID: AccountID
    // for transfer and saving only
    var targetAccountID: AccountID?
    
    enum CodingKeys: CodingKey {
        case id
        case userID
        case currencyCode
        case year
        case month
        case day
        case merchantID
        case amount
        case type
        case note
        case categoryID
        case tag
        case recurringID
        case sourceAccountID
        case targetAccountID
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(TransactionID.self, forKey: .id)
        self.userID = try container.decode(UserID.self, forKey: .userID)
        self.currencyCode = try container.decode(CurrencyCode.self, forKey: .currencyCode)
        self.year = try container.decode(Int.self, forKey: .year)
        self.month = try container.decode(Int.self, forKey: .month)
        self.day = try container.decode(Int.self, forKey: .day)
        if let merchantIDString = try? container.decode(String.self, forKey: .merchantID) {
            print(merchantIDString)
            self.merchantID = try container.decode(MerchantID.self, forKey: .merchantID)
        } else {
            self.merchantID = UUID()
        }
        
        self.amount = try container.decode(Double.self, forKey: .amount)
        self.type = try container.decode(TransactionType.self, forKey: .type)
        self.note = try container.decode(String.self, forKey: .note)
        self.categoryID = try container.decode(CategoryID.self, forKey: .categoryID)
        self.tag = try container.decode(TransactionTag.self, forKey: .tag)
        if let recurringIDString = try? container.decodeIfPresent(String.self, forKey: .recurringID), !recurringIDString.isEmpty {
            self.recurringID = UUID(uuidString: recurringIDString)
        }
        if let sourceAccountIDString = try? container.decodeIfPresent(String.self, forKey: .sourceAccountID), !sourceAccountIDString.isEmpty {
            self.sourceAccountID = UUID(uuidString: sourceAccountIDString) ?? CacheManager.shared.mainAccountID
        } else {
            self.sourceAccountID = CacheManager.shared.mainAccountID
        }
        if let targetAccountIDString = try? container.decodeIfPresent(String.self, forKey: .recurringID), !targetAccountIDString.isEmpty {
            self.targetAccountID = UUID(uuidString: targetAccountIDString)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.userID, forKey: .userID)
        try container.encode(self.currencyCode, forKey: .currencyCode)
        try container.encode(self.year, forKey: .year)
        try container.encode(self.month, forKey: .month)
        try container.encode(self.day, forKey: .day)
        try container.encode(self.merchantID, forKey: .merchantID)
        try container.encode(self.amount, forKey: .amount)
        try container.encode(self.type, forKey: .type)
        try container.encode(self.note, forKey: .note)
        try container.encode(self.categoryID, forKey: .categoryID)
        try container.encode(self.tag, forKey: .tag)
        try container.encodeIfPresent(self.recurringID, forKey: .recurringID)
        try container.encode(self.sourceAccountID, forKey: .sourceAccountID)
        try container.encodeIfPresent(self.targetAccountID, forKey: .targetAccountID)
    }
}
