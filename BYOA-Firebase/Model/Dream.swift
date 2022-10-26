//
//  Dream.swift
//  BYOA-Firebase
//
//  Created by Matheus Oliveira on 10/26/22.
//

import Foundation

class Dream {
    
    //MARK: - Keys
    enum Key {
        static let collectionType = "dreams"
        static let dreamTitle = "title"
        static let dreamDate = "date"
        static let dreamBody = "body"
        static let uuid = "uuid"
    }
    
    //MARK: - Properties
    var dreamTitle: String
    var dreamBody: String
    var dreamDate: Date
    let uuid: String
    
    //MARK: - Computed Property
    var dreamData: [String: AnyHashable] {
        [Key.dreamTitle: self.dreamTitle,
        Key.dreamBody: self.dreamBody,
        Key.dreamDate: self.dreamDate,
        Key.uuid: self.uuid]
    }
    
    init(dreamTitle: String, dreamBody: String, dreamDate: Date = Date(), uuid: String = UUID().uuidString) {
        self.dreamTitle = dreamTitle
        self.dreamBody = dreamBody
        self.dreamDate = dreamDate
        self.uuid = uuid
    }
    
}//End of class

//Optional Initializer
extension Dream {
    convenience init?(fromDictionary dictionary: [String: Any]) {
        guard let title = dictionary[Key.dreamTitle] as? String,
              let body = dictionary[Key.dreamBody] as? String,
              let date = dictionary[Key.dreamDate] as? Double,
              let uuid = dictionary[Key.uuid] as? String else {return nil}
        
        self.init(dreamTitle: title, dreamBody: body, dreamDate: Date(timeIntervalSince1970: date), uuid: uuid)
    }
}

extension Dream: Equatable {
    static func == (lhs: Dream, rhs: Dream) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
