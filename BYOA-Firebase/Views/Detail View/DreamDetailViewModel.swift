//
//  DreamDetailViewModel.swift
//  BYOA-Firebase
//
//  Created by Matheus Oliveira on 10/26/22.
//

import Foundation

class DreamDetailViewModel {
    
    var dream: Dream?
    private let firebaseService: FirebaseSyncable

    init(dream: Dream? = nil, firebaseService: FirebaseSyncable = FirebaseService()) {
        self.dream = dream
        self.firebaseService = firebaseService
    }
    
    func saveDream(title: String, body: String) {
        if dream != nil {
            updateDream(with: title, body: body)
        } else {
            let dream = Dream(dreamTitle: title, dreamBody: body)
            firebaseService.save(dream)
        }
    }
    
    private func updateDream(with title: String, body: String) {
        guard let dream = dream else {return}
        
        dream.dreamTitle = title
        dream.dreamBody = body
        firebaseService.save(dream)
    }
}//End of class
