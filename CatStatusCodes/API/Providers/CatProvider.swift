//
//  CatProviding.swift
//  CatStatusCodes
//
//  Created by Ian Magallan on 6/1/23.
//

import Combine
import Foundation

protocol CatProviding {
    func fetchCat(statusCode: Int) -> AnyPublisher<Data, CatError>
}

final class CatProvider: CatProviding {
    private let requestFactory: RequestFactoring
    private let httpExecutor: HttpExecuting

    init(
        requestFactory: RequestFactoring = RequestFactory(),
        httpExecutor: HttpExecuting = HttpExecutor()
    ) {
        self.requestFactory = requestFactory
        self.httpExecutor = httpExecutor
    }

    func fetchCat(statusCode: Int) -> AnyPublisher<Data, CatError> {
        httpExecutor.execute(request: requestFactory.fetchCat(statusCode: statusCode))
    }
}
