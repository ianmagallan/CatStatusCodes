//
//  MockCatFactory.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodes
import Foundation

final class MockCatFactory: CatFactoring {
    var stubbedCats = [Cat]()

    func makeCats() -> [Cat] {
        stubbedCats
    }
}
