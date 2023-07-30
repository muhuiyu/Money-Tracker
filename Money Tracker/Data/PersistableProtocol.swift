//
//  PersistableProtocol.swift
//  Get Fit
//
//  Created by Mu Yu on 3/29/23.
//

import RealmSwift

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
