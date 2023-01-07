//
//  MockStorage.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

import Foundation
@testable import CatStatusCodes

final class MockStorage: Storing {
    var stubbedStoredDates = [String: Date]()
    
    var invokedStoreDateCount = 0
    func storeDate(_ date: Date, forKey key: String) {
        invokedStoreDateCount += 1
        stubbedStoredDates[key] = date
    }
    
    var invokedRetrieveDateCount = 0
    func retrieveDate(forKey key: String) -> Date? {
        invokedRetrieveDateCount += 1
        return stubbedStoredDates[key]
    }
}
