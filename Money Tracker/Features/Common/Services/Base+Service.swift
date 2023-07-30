//
//  Base+Service.swift
//  Why am I so poor
//
//  Created by Mu Yu on 12/29/22.
//

import Foundation
import RxSwift

protocol ServiceType {
    
}

extension Base {
    
//    open class Service<T: Codable>: ServiceType {
//
//    }
//
//    open class FirebaseService<T: Codable>: ServiceType {
//
//        private let reference: CollectionReference
//
//        init(collectionName: String) {
//            reference = Firestore.firestore().collection(collectionName)
//        }
        
//        func query(_ params: [String: Any]) -> Observable<T> {
//            return Observable.create { observer -> Disposable in
//
//            }
//        }
//    }
    
}

class EmptyService: ServiceType {
    
}

struct ServiceError: Codable {
    let code: Int
    let message: String
}

//extension Base.Service {
//
//}
