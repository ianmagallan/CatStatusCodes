//
//  MockExecutor.swift
//  CatStatusCodesAPIMocks
//
//  Created by Ian Magallan on 7/1/23.
//

@testable import CatStatusCodesAPI
import Combine
import Foundation

class MockHttpExecutor: HttpExecuting {
    var stubbedResult: Result<Data, CatError>!

    func execute(request _: URLRequest) -> AnyPublisher<Data, CatError> {
        stubbedResult.publisher.eraseToAnyPublisher()
    }
}
