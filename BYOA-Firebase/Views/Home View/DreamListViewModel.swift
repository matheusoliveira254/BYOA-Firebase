//
//  DreamListViewModel.swift
//  BYOA-Firebase
//
//  Created by Matheus Oliveira on 10/26/22.
//

import Foundation

protocol DreamListViewModelDelegate: AnyObject {
    func dreamsLoadedSuccessfully()
}

class DreamListViewModel {
    
    
    //MARK: - Properties
    var dreams: [Dream] = []
    private var service: FirebaseSyncable
    private weak var delegate: DreamListViewModelDelegate?

    init(service: FirebaseSyncable = FirebaseService(), delegate: DreamListViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }


    func loadData() {
        service.loadDreams { [weak self] result in
            switch result {
            case .success(let dreams):
                self?.dreams = dreams
                self?.delegate?.dreamsLoadedSuccessfully()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func delete(index: Int) {
        let dream = dreams[index]
        service.delete(dream: dream)
        self.dreams.remove(at: index)
    }
}
