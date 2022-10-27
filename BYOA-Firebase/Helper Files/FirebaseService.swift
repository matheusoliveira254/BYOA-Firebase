//
//  FirebaseService.swift
//  BYOA-Firebase
//
//  Created by Matheus Oliveira on 10/26/22.
//

import Foundation
import FirebaseFirestore

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
    
    let ref = Firestore.firestore()
    
    func save(_ dream: Dream) {
        ref.collection(Dream.Key.collectionType).document(dream.uuid).setData(dream.dreamData)
    }
    
    func loadDreams(completion: @escaping (Result<[Dream], FirebaseError>) -> Void) {
        
        ref.collection(Dream.Key.collectionType).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(.firebaseError(error)))
                return
            }

            guard let data = snapshot?.documents else {
                completion(.failure(.noDataFound))
                return
            }

            let dataArray = data.compactMap({$0.data()})
            let logs = dataArray.compactMap{ Dream(fromDictionary: $0)}
            let sortedDreams = logs.sorted(by: {$0.dreamDate > $1.dreamDate})
            completion(.success(sortedDreams))
        }
    }
    
    func delete(dream: Dream) {
        ref.collection(Dream.Key.collectionType).document(dream.uuid).delete()
    }
}//End of Struct
