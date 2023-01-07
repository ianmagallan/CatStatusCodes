//
//  MockExecutor.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

import Combine
import Foundation
@testable import CatStatusCodes

class MockHttpExecutor: HttpExecuting {
    var stubbedResult: Result<Data, CatError>!
    
    func execute(request: URLRequest) -> AnyPublisher<Data, CatError> {
        stubbedResult.publisher.eraseToAnyPublisher()
    }
}
