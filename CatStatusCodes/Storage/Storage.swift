//
//  Storage.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 7/1/23.
//

import Foundation

protocol Storing {
    func storeDate(_ date: Date, forKey key: String)
    func retrieveDate(forKey key: String) -> Date?
}

final class Storage: Storing {
    func storeDate(_ date: Date, forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(date.timeIntervalSinceReferenceDate, forKey: key)
    }

    func retrieveDate(forKey key: String) -> Date? {
        let defaults = UserDefaults.standard
        if let storedDate = defaults.value(forKey: key) as? Double {
            return .init(timeIntervalSinceReferenceDate: storedDate)
        }
        return nil
    }
}
