//
//  MockCatFactory.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

import Foundation
@testable import CatStatusCodes

final class MockCatFactory: CatFactoring {
    var stubbedCats = [Cat]()
    
    func makeCats() -> [Cat] {
        stubbedCats
    }
}
