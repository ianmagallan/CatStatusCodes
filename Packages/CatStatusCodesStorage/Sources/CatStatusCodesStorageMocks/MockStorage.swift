//
//  MockStorage.swift
//  CatStatusCodesStorageMocks
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodesStorage
import Foundation

public final class MockStorage: Storing {
    
    public init() {}
    
    public var stubbedStoredDates = [String: Date]()

    public var invokedStoreDateCount = 0
    public func storeDate(_ date: Date, forKey key: String) {
        invokedStoreDateCount += 1
        stubbedStoredDates[key] = date
    }

    public var invokedRetrieveDateCount = 0
    public func retrieveDate(forKey key: String) -> Date? {
        invokedRetrieveDateCount += 1
        return stubbedStoredDates[key]
    }
}
