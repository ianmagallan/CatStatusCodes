//
//  MockCatProvider.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

import Combine
import Foundation
@testable import CatStatusCodes

final class MockCatProvider: CatProviding {
    var stubbedCatResult: Result<Data, CatError>!
    
    func fetchCat(statusCode: Int) -> AnyPublisher<Data, CatError> {
        Result<Data, CatError>.Publisher(stubbedCatResult).eraseToAnyPublisher()
    }
}
