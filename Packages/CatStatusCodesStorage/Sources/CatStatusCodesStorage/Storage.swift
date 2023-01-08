//
//  Storage.swift
//  CatStatusCodesStorage
//
//  Created by Ian Magallan on 7/1/23.
//

import Foundation

public protocol Storing {
    func storeDate(_ date: Date, forKey key: String)
    func retrieveDate(forKey key: String) -> Date?
}

public final class Storage: Storing {
    
    public init() {}
    
    public func storeDate(_ date: Date, forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(date.timeIntervalSinceReferenceDate, forKey: key)
    }

    public func retrieveDate(forKey key: String) -> Date? {
        let defaults = UserDefaults.standard
        if let storedDate = defaults.value(forKey: key) as? Double {
            return .init(timeIntervalSinceReferenceDate: storedDate)
        }
        return nil
    }
}
