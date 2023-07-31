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
        case createDataError
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
//        deleteAll()
//        addAllBudgets()
//        addAllMerchants()
//        addAllTransactions()
        
//        syncBackup()
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
