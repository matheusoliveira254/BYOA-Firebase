//
//  FirebaseService.swift
//  BYOA-Firebase
//
//  Created by Matheus Oliveira on 10/26/22.
//

import Foundation
import Firebase

enum FirebaseError: Error {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
}

//Dependency Inversion
protocol FirebaseSyncable {
    func save(_ dream: Dream)
    func loadDreams(completion: @escaping (Result<[Dream], FirebaseError>) -> Void)
    func delete(dream: Dream)
}

struct FirebaseService: FirebaseSyncable {
    
    let ref = Database.database().reference()
    
    func save(_ dream: Dream) {
        ref.child(Dream.Key.collectionType).updateChildValues([dream.uuid: dream.dreamData])
    }
    
    func loadDreams(completion: @escaping (Result<[Dream], FirebaseError>) -> Void) {
        
        ref.child(Dream.Key.collectionType).getData { error, snapshot in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }

            guard let data = snapshot?.value as? [String: [String: Any]] else {
                completion(.failure(.noDataFound))
                return
            }

            let dataArray = Array(data.values)
            let logs = dataArray.compactMap{ Dream(fromDictionary: $0)}
            let sortedDreams = logs.sorted(by: {$0.dreamDate > $1.dreamDate})
            completion(.success(sortedDreams))
        }
    }
    
    func delete(dream: Dream) {
        ref.child(Dream.Key.collectionType).child(dream.uuid).removeValue()
    }
}//End of Struct
