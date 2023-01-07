//
//  MockSession.swift
//  CatStatusCodesTests
//
//  Created by Ian Magallan on 7/1/23.
//

import Combine
import Foundation
@testable import CatStatusCodes

final class MockSession: Sessioning {
    var stubbedData: Data!
    var stubbedResponse: URLResponse!

    func dataTaskPublisher(for _: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        Result.success((stubbedData, stubbedResponse)).publisher
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
