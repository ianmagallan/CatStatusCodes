//
//  MockExecutor.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodes
import Combine
import Foundation

class MockHttpExecutor: HttpExecuting {
    var stubbedResult: Result<Data, CatError>!

    func execute(request _: URLRequest) -> AnyPublisher<Data, CatError> {
        stubbedResult.publisher.eraseToAnyPublisher()
    }
}
