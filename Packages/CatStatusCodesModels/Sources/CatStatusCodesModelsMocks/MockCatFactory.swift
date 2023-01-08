//
//  MockCatFactory.swift
//  CatStatusCodesModelsMocks
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodesModels
import Foundation

public final class MockCatFactory: CatFactoring {
    
    public init() {}
    
    public var stubbedCats = [Cat]()
    public func makeCats() -> [Cat] {
        stubbedCats
    }
}
