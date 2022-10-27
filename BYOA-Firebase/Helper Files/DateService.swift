//
//  DateService.swift
//  BYOA-Firebase
//
//  Created by Matheus Oliveira on 10/26/22.
//

import Foundation

extension Date {
    
    /**
    Extends the Date class giving us the ability to convert a Date to a String.
     */
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
}
