//
//  MockCatProvider.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodes
import Combine
import Foundation

final class MockCatProvider: CatProviding {
    var stubbedCatResult: Result<Data, CatError>!

    func fetchCat(statusCode _: Int) -> AnyPublisher<Data, CatError> {
        Result<Data, CatError>.Publisher(stubbedCatResult).eraseToAnyPublisher()
    }
}
